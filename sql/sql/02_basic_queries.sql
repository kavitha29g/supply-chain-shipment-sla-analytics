#data check#

select * from carriers;
select * from customers;
select * from delivery_tracking;
select * from order_details;
select * from orders;
select * from products;
select * from returns;
select * from shipments;
select * from warehouses;

#3 Display all orders along with customer name, order date, warehouse, order value, and order status. 

select c.customer_name, o.order_date, o.order_value, o.order_status, w.warehouse_name
from orders o left join customers c on c.customer_id = o.customer_id
left join warehouses w on o.warehouse_id = w.warehouse_id;

#4Find the top 10 customers based on total order value.

select c.customer_name, sum(o.order_value) as total_order_value
from orders o left join customers c on c.customer_id = o.customer_id
group by c.customer_name
order by total_order_value desc
limit 10;

#5. Find customers who have never placed an order. 

select c.customer_name
from customers c left join orders o on c.customer_id = o.customer_id
where o.order_id is null;

#6. Calculate the total number of shipments by carrier.

select carrier_id, count(shipment_id) as total_no_of_shipment from shipments
group by carrier_id;

#7. Identify all shipments that were delivered after the expected delivery date. 

select shipment_id from shipments
where expected_delivery < actual_delivery;

#8. Calculate the number of delivery days for every completed shipment. 

select order_id,  DATEDIFF(actual_delivery, shipment_date) AS No_of_deliverydays
from shipments
where shipment_status = 'delivered';

#9. Create an SLA status:  ON TIME  and SLA BREACHED 

select shipment_id, 
case
when (shipment_status = 'delivered' and expected_delivery <= actual_delivery) or
     (shipment_status in ('In Transit', 'pending') and expected_delivery >= current_date()) or
     (shipment_status = 'Cancelled') then 'ON TIME'
	when expected_delivery > actual_delivery then 'SLA BREACHED'
    else 'SLA BREACHED'
end as SLA_status from shipments;
