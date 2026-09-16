#10. Calculate the SLA compliance percentage for each carrier. 
#step1 finding SLA_status

SELECT 
    shipment_id,
    CASE
        WHEN actual_delivery <= expected_delivery THEN 'ON TIME'
        ELSE 'SLA BREACHED'
    END AS SLA_status
FROM shipments
WHERE actual_delivery IS NOT NULL;

#step 2 finding count
select  carrier_id, count(carrier_id) as total_carrier_count from shipments
group by  carrier_id;


#step 3 combine with cte and finding percentage 
with cte as (SELECT 
    carrier_id,
    COUNT(shipment_id) AS total_carrier_count,
    SUM(CASE
            WHEN actual_delivery <= expected_delivery THEN 1
            ELSE 0
        END) AS on_time,
    SUM( CASE
            WHEN actual_delivery > expected_delivery THEN 1
            ELSE 0
        END) AS sla_breached
FROM shipments
WHERE actual_delivery IS NOT NULL
GROUP BY carrier_id)
select carrier_id, (on_time/total_carrier_count)*100 as SLA_percentage from cte;


#11. Find the best and worst-performing delivery carriers.

with cte as (SELECT 
    carrier_id,
    COUNT(shipment_id) AS total_carrier_count,
    SUM(CASE
            WHEN actual_delivery <= expected_delivery THEN 1
            ELSE 0
        END) AS on_time,
    SUM( CASE
            WHEN actual_delivery > expected_delivery THEN 1
            ELSE 0
        END) AS sla_breached
FROM shipments
WHERE actual_delivery IS NOT NULL
GROUP BY carrier_id), SLA as
(select carrier_id, (on_time/total_carrier_count)*100 as SLA_percentage
from cte), ranks as (SELECT
        carrier_id,
        sla_percentage,
        RANK() OVER (ORDER BY sla_percentage DESC) AS best_rank,
        RANK() OVER (ORDER BY sla_percentage ASC) AS worst_rank
    FROM sla
)
SELECT carrier_id, sla_percentage,
       CASE
           WHEN best_rank = 1 THEN 'BEST'
           WHEN worst_rank = 1 THEN 'WORST'
       END AS performance
FROM ranks
WHERE best_rank = 1 OR worst_rank = 1;


#12. Find the top 3 carriers in each region using a window function. 

with cte as (select  carrier_id, carrier_name, region, dense_rank() over 
( partition by region order by rating desc) as top_3 from carriers)
select * from cte
where top_3 in (1,2,3);

#13. Calculate the average delivery time for each warehouse. 

with cte as (select order_id,  DATEDIFF(actual_delivery, shipment_date) AS No_of_deliverydays
from shipments
where shipment_status = 'delivered')
select w.warehouse_name, w.warehouse_id , avg(cte.No_of_deliverydays) as avg_days from cte
JOIN orders o
    ON cte.order_id = o.order_id
JOIN warehouses w
    ON o.warehouse_id = w.warehouse_id
GROUP BY
    w.warehouse_id,
    w.warehouse_name
    order by warehouse_id ;
    
    
#14. Identify warehouses having the highest number of delayed shipments.

select o.warehouse_id, count(s.shipment_id) as no_of_shipment
from shipments s left join orders o on o.order_id = s.order_id
where expected_delivery < actual_delivery
group by o.warehouse_id
order by count(s.shipment_id) desc
limit 1;

#15. Calculate monthly: Total Orders, Total Shipments , Delivered Shipments ,Delayed Shipments ,SLA Compliance % 
 
 WITH monthly_orders AS (SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, COUNT(order_id) AS total_orders
    FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')),
monthly_shipments AS (SELECT DATE_FORMAT(shipment_date, '%Y-%m') AS month, COUNT(shipment_id) AS total_shipments,
SUM( CASE
	      WHEN shipment_status = 'Delivered' THEN 1
		  ELSE 0
		  END ) AS delivered_shipments,
SUM(CASE
		WHEN actual_delivery > expected_delivery THEN 1
	    ELSE 0
		END
        ) AS delayed_shipments,
SUM( CASE
		  WHEN actual_delivery <= expected_delivery THEN 1
		   ELSE 0
		   END) AS on_time_shipments
FROM shipments
GROUP BY DATE_FORMAT(shipment_date, '%Y-%m'))

SELECT
    mo.month, mo.total_orders, ms.total_shipments, ms.delivered_shipments, ms.delayed_shipments,
 (ms.on_time_shipments / NULLIF(ms.delivered_shipments, 0)) * 100 AS sla_compliance_percentage
FROM monthly_orders mo
JOIN monthly_shipments ms ON mo.month = ms.month ORDER BY mo.month;

#16. Find the region with the highest SLA breach percentage. 

SELECT
    w.region, COUNT(s.shipment_id) AS total_completed_shipments,
SUM( CASE
            WHEN s.actual_delivery > s.expected_delivery THEN 1
            ELSE 0
        END
    ) AS delayed_shipments,
SUM( CASE
                WHEN s.actual_delivery > s.expected_delivery THEN 1
                ELSE 0
            END
        ) / COUNT(s.shipment_id) * 100
        AS sla_breach_percentage

FROM shipments s
JOIN orders o ON s.order_id = o.order_id
JOIN warehouses w ON o.warehouse_id = w.warehouse_id
WHERE s.actual_delivery IS NOT NULL
GROUP BY w.region
ORDER BY sla_breach_percentage DESC
LIMIT 1;

#17. Identify products having the highest return rate. 

select  r.product_id,
    r.return_count,
    o.total_orders,
    (r.return_count * 100.0 / o.total_orders) AS return_rate
FROM
 (SELECT product_id, COUNT(*) AS return_count FROM returns
GROUP BY product_id ) r
join
(SELECT product_id, COUNT(*) AS total_orders FROM order_details
    GROUP BY product_id) o
    ON r.product_id = o.product_id
ORDER BY return_rate DESC
LIMIT 1;

#18. Find customers who placed more than 5 orders and also had at least one returned product.

select c.customer_id, c.customer_name, 
count(distinct o.order_id) as order_count from customers c
 join orders o on c.customer_id = o.customer_id
 join returns r on o.order_id = r.order_id
group by  c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.order_id) > 5
   AND COUNT(r.return_id) >= 1;


#19. Identify shipments that had multiple tracking updates before delivery. 

select s.shipment_id , count(dt.tracking_id) as tracking_update from delivery_tracking dt 
join shipments s on s.shipment_id = dt.shipment_id
Where s.actual_delivery IS NOT NULL
  and dt.tracking_date < s.actual_delivery
group by  s.shipment_id
having COUNT(dt.tracking_id) > 1;

#20 Find orders where the shipment was delivered late but the order value was greater than the average order value.

select o.order_id, o.order_value, s.expected_delivery, s.actual_delivery
from  orders o join shipments s on o.order_id = s.order_id
where s.actual_delivery > s.expected_delivery
and o.order_value > ( select AVG(order_value)from orders);
