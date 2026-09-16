#21 Rank warehouses based on their delivery performance using RANK() or DENSE_RANK()

with warehouse_performance AS (select w.warehouse_id, w.warehouse_name,
        avg(DATEDIFF(s.actual_delivery, s.shipment_date)) as avg_delivery_days
    from warehouses w join orders o on w.warehouse_id = o.warehouse_id
    join shipments s on o.order_id = s.order_id
    where s.actual_delivery is not null
    group by  w.warehouse_id, w.warehouse_name)
select warehouse_id, warehouse_name, avg_delivery_days,
    dense_rank() over ( order by  avg_delivery_days  ) AS performance_rank
from warehouse_performance;

#22 Find the second-highest performing carrier based on SLA compliance. 

WITH carrier_sla AS (SELECT carrier_id, COUNT(shipment_id) AS completed_shipments,
SUM(CASE
	WHEN actual_delivery <= expected_delivery THEN 1
    ELSE 0
	END) AS on_time_shipments FROM shipments
WHERE actual_delivery IS NOT NULL
GROUP BY carrier_id),
sla_percentage AS ( SELECT carrier_id,
        (on_time_shipments / completed_shipments) * 100 AS sla_compliance_percentage
    FROM carrier_sla),
ranked_carriers AS ( SELECT carrier_id, sla_compliance_percentage,
        DENSE_RANK() OVER ( ORDER BY sla_compliance_percentage DESC) AS rank_no
    FROM sla_percentage)
SELECT carrier_id, sla_compliance_percentage FROM ranked_carriers
WHERE rank_no = 2;

#23. Create a CTE to identify customers whose total spending is greater than the average customer spending. 

with cte as (select customer_id, sum(order_value) as total_spending  from orders
  group by customer_id)
  select * from cte 
  where total_spending > (select avg(total_spending) from cte)  ;

