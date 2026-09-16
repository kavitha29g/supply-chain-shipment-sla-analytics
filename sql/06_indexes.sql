#25. Create appropriate indexes to improve query performance on frequently used columns such as Customer_ID , Order_ID , Shipment_ID ,Carrier_ID ,Shipment_Date

CREATE INDEX idx_customers_customer_id
ON customers(customer_id);

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX idx_orders_order_id
ON orders(order_id);

CREATE INDEX idx_shipments_shipment_id
ON shipments(shipment_id);

CREATE INDEX idx_shipments_order_id
ON shipments(order_id);

CREATE INDEX idx_shipments_carrier_id
ON shipments(carrier_id);

CREATE INDEX idx_shipments_shipment_date
ON shipments(shipment_date);
