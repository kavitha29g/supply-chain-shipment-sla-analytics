#24. Create a SQL VIEW called Shipment_Performance_View containing: Order ID , Customer , warehouse , Carrier ,Shipment Date ,Expected Delivery ,Actual Delivery , Delivery Days , SLA Status 

create view  Shipment_Performance_View as select o.Order_ID , c.Customer_name , w.Warehouse_name , 
ca.Carrier_name ,s.Shipment_Date ,s.Expected_Delivery,  s.Actual_Delivery , 
datediff( s.Actual_Delivery, s.Shipment_Date) as delivery_days,
case
        WHEN s.actual_delivery IS NULL THEN 'PENDING'
        WHEN s.actual_delivery <= s.expected_delivery THEN 'ON TIME'
        ELSE 'SLA BREACHED'
    END AS SLA_Status
from shipments s
 join orders o on s.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN warehouses w ON o.warehouse_id = w.warehouse_id
JOIN carriers ca ON s.carrier_id = ca.carrier_id;
