#Supply Chain Shipment & Delivery SLA Analytics

create database Shipment_db;
use Shipment_db;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) UNIQUE,
    city VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    created_date DATE DEFAULT (CURRENT_DATE)
);

INSERT INTO Customers
(customer_id, customer_name, email, phone, city, region)
VALUES
(1,'Arun Kumar','arun@gmail.com','9000000001','Chennai','South'),
(2,'Priya Sharma','priya@gmail.com','9000000002','Bangalore','South'),
(3,'Rahul Verma','rahul@gmail.com','9000000003','Mumbai','West'),
(4,'Sneha Reddy','sneha@gmail.com','9000000004','Hyderabad','South'),
(5,'Vikram Singh','vikram@gmail.com','9000000005','Delhi','North'),
(6,'Meena Iyer','meena@gmail.com','9000000006','Chennai','South'),
(7,'Karthik Rao','karthik@gmail.com','9000000007','Pune','West'),
(8,'Anjali Das','anjali@gmail.com','9000000008','Kolkata','East'),
(9,'Ravi Patel','ravi@gmail.com','9000000009','Ahmedabad','West'),
(10,'Divya Nair','divya@gmail.com','9000000010','Kochi','South'),
(11,'Suresh Babu','suresh@gmail.com','9000000011','Coimbatore','South'),
(12,'Neha Gupta','neha@gmail.com','9000000012','Delhi','North'),
(13,'Manoj Shah','manoj@gmail.com','9000000013','Mumbai','West'),
(14,'Lakshmi Menon','lakshmi@gmail.com','9000000014','Kochi','South'),
(15,'Ajay Mishra','ajay@gmail.com','9000000015','Lucknow','North'),
(16,'Pooja Roy','pooja@gmail.com','9000000016','Kolkata','East'),
(17,'Nitin Jain','nitin@gmail.com','9000000017','Jaipur','North'),
(18,'Swathi Rao','swathi@gmail.com','9000000018','Bangalore','South'),
(19,'Deepak Kumar','deepak@gmail.com','9000000019','Chennai','South'),
(20,'Asha Thomas','asha@gmail.com','9000000020','Kochi','South'),
(21,'Rohan Mehta','rohan@gmail.com','9000000021','Ahmedabad','West'),
(22,'Geetha Krishnan','geetha@gmail.com','9000000022','Madurai','South'),
(23,'Amit Das','amit@gmail.com','9000000023','Kolkata','East'),
(24,'Shalini Kapoor','shalini@gmail.com','9000000024','Delhi','North'),
(25,'Varun Joshi','varun@gmail.com','9000000025','Pune','West');

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    supplier VARCHAR(100) NOT NULL
);

INSERT INTO Products
(product_id, product_name, category, price, stock_quantity, supplier)
VALUES
(1,'Laptop Pro 14','Electronics',75000,50,'TechWorld'),
(2,'Wireless Mouse','Electronics',1200,200,'TechWorld'),
(3,'Mechanical Keyboard','Electronics',3500,120,'KeyTech'),
(4,'Office Chair','Furniture',8500,70,'FurniCorp'),
(5,'Standing Desk','Furniture',15000,40,'FurniCorp'),
(6,'USB-C Hub','Electronics',2200,150,'ConnectPro'),
(7,'Monitor 24 Inch','Electronics',12500,80,'DisplayTech'),
(8,'Monitor 27 Inch','Electronics',18000,60,'DisplayTech'),
(9,'Bluetooth Speaker','Electronics',4500,100,'SoundMax'),
(10,'Running Shoes','Footwear',3200,150,'SportFit'),
(11,'Formal Shoes','Footwear',4200,100,'WalkStyle'),
(12,'Cotton Shirt','Clothing',1800,250,'FashionHub'),
(13,'Denim Jeans','Clothing',2800,180,'FashionHub'),
(14,'Backpack','Accessories',2200,140,'BagWorld'),
(15,'Smart Watch','Electronics',6500,90,'WearTech'),
(16,'Air Fryer','Appliances',7200,75,'HomePlus'),
(17,'Mixer Grinder','Appliances',5600,85,'HomePlus'),
(18,'Coffee Maker','Appliances',4800,65,'BrewCorp'),
(19,'Water Bottle','Accessories',900,300,'DailyNeeds'),
(20,'Travel Bag','Accessories',3600,110,'BagWorld'),
(21,'Table Lamp','Furniture',1600,130,'LightHouse'),
(22,'Bookshelf','Furniture',6200,45,'FurniCorp'),
(23,'Headphones','Electronics',3800,120,'SoundMax'),
(24,'Tablet 10 Inch','Electronics',24000,55,'TechWorld'),
(25,'Power Bank','Electronics',1800,200,'ConnectPro');

CREATE TABLE Warehouses (
    warehouse_id INT PRIMARY KEY,
    warehouse_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    capacity INT NOT NULL CHECK (capacity > 0),
    manager_name VARCHAR(100) NOT NULL
);

INSERT INTO Warehouses
(warehouse_id, warehouse_name, city, region, capacity, manager_name)
VALUES
(1,'Chennai Central Warehouse','Chennai','South',5000,'Ramesh'),
(2,'Bangalore Distribution Hub','Bangalore','South',4500,'Sanjay'),
(3,'Hyderabad Logistics Hub','Hyderabad','South',4000,'Venkat'),
(4,'Mumbai West Warehouse','Mumbai','West',5500,'Mahesh'),
(5,'Pune Distribution Center','Pune','West',3500,'Amit'),
(6,'Delhi North Hub','Delhi','North',6000,'Rajesh'),
(7,'Jaipur Warehouse','Jaipur','North',3000,'Mohan'),
(8,'Kolkata East Hub','Kolkata','East',4200,'Subhash'),
(9,'Ahmedabad Warehouse','Ahmedabad','West',3800,'Dinesh'),
(10,'Kochi South Hub','Kochi','South',3200,'Thomas'),
(11,'Coimbatore Warehouse','Coimbatore','South',2800,'Prakash'),
(12,'Lucknow Distribution Hub','Lucknow','North',3600,'Vijay'),
(13,'Madurai Warehouse','Madurai','South',2500,'Bala'),
(14,'Nagpur Central Hub','Nagpur','West',4000,'Nilesh'),
(15,'Bhubaneswar East Hub','Bhubaneswar','East',3000,'Suresh'),
(16,'Noida North Hub','Noida','North',4800,'Anil'),
(17,'Mysore Warehouse','Mysore','South',2700,'Ganesh'),
(18,'Surat Warehouse','Surat','West',3300,'Kiran'),
(19,'Patna East Warehouse','Patna','East',2900,'Manish'),
(20,'Gurgaon Distribution Hub','Gurgaon','North',5200,'Harish');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_value DECIMAL(10,2) NOT NULL CHECK (order_value > 0),
    order_status VARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    FOREIGN KEY (warehouse_id)
        REFERENCES Warehouses(warehouse_id),

    CHECK (order_status IN
        ('Pending','Confirmed','Shipped','Delivered','Cancelled'))
);

INSERT INTO Orders
(order_id, customer_id, warehouse_id, order_date, order_value, order_status)
VALUES
(1001,1,1,'2026-01-05',76200,'Delivered'),
(1002,2,2,'2026-01-08',4700,'Delivered'),
(1003,3,4,'2026-01-12',18000,'Delivered'),
(1004,4,3,'2026-01-18',8500,'Delivered'),
(1005,5,6,'2026-01-22',24000,'Shipped'),
(1006,6,1,'2026-02-02',6500,'Delivered'),
(1007,7,5,'2026-02-05',15000,'Delivered'),
(1008,8,8,'2026-02-10',5600,'Delivered'),
(1009,9,9,'2026-02-14',4200,'Cancelled'),
(1010,10,10,'2026-02-18',7200,'Delivered'),
(1011,11,11,'2026-03-01',12500,'Delivered'),
(1012,12,6,'2026-03-04',38000,'Delivered'),
(1013,13,4,'2026-03-08',9500,'Shipped'),
(1014,14,10,'2026-03-12',1800,'Delivered'),
(1015,15,12,'2026-03-18',32000,'Delivered'),
(1016,16,8,'2026-03-22',6200,'Delivered'),
(1017,17,7,'2026-04-01',3600,'Pending'),
(1018,18,2,'2026-04-05',8700,'Delivered'),
(1019,19,1,'2026-04-10',24000,'Delivered'),
(1020,20,10,'2026-04-15',4800,'Delivered'),
(1021,1,1,'2026-04-20',11200,'Delivered'),
(1022,2,2,'2026-05-02',15000,'Delivered'),
(1023,3,4,'2026-05-08',7600,'Delivered'),
(1024,5,6,'2026-05-15',8500,'Shipped'),
(1025,7,5,'2026-05-20',24500,'Delivered');

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal > 0),

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);

INSERT INTO Order_Details
(order_detail_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES
(1,1001,1,1,75000,75000),
(2,1001,2,1,1200,1200),
(3,1002,3,1,3500,3500),
(4,1002,2,1,1200,1200),
(5,1003,8,1,18000,18000),
(6,1004,4,1,8500,8500),
(7,1005,24,1,24000,24000),
(8,1006,15,1,6500,6500),
(9,1007,5,1,15000,15000),
(10,1008,17,1,5600,5600),
(11,1009,11,1,4200,4200),
(12,1010,16,1,7200,7200),
(13,1011,7,1,12500,12500),
(14,1012,23,1,3800,3800),
(15,1012,24,1,24000,24000),
(16,1013,9,2,4500,9000),
(17,1014,12,1,1800,1800),
(18,1015,13,2,2800,5600),
(19,1015,24,1,24000,24000),
(20,1016,22,1,6200,6200),
(21,1017,20,1,3600,3600),
(22,1018,14,1,2200,2200),
(23,1018,4,1,8500,8500),
(24,1019,24,1,24000,24000),
(25,1020,18,1,4800,4800),
(26,1021,21,1,1600,1600),
(27,1021,7,1,12500,12500),
(28,1022,5,1,15000,15000),
(29,1023,10,1,3200,3200),
(30,1023,23,1,3800,3800),
(31,1024,4,1,8500,8500),
(32,1025,24,1,24000,24000),
(33,1025,2,1,1200,1200);

CREATE TABLE Carriers (
    carrier_id INT PRIMARY KEY AUTO_INCREMENT,
    carrier_name VARCHAR(100) NOT NULL UNIQUE,
    region VARCHAR(50) NOT NULL,
    contact_number VARCHAR(15) UNIQUE,
    rating DECIMAL(3,2) CHECK (rating BETWEEN 0 AND 5)
);

INSERT INTO Carriers
(carrier_id, carrier_name, region, contact_number, rating)
VALUES
(1,'BlueDart','South','9100000001',4.50),
(2,'DHL','South','9100000002',4.70),
(3,'FedEx','West','9100000003',4.60),
(4,'Delhivery','North','9100000004',4.20),
(5,'DTDC','East','9100000005',4.00),
(6,'Ecom Express','South','9100000006',3.90),
(7,'XpressBees','West','9100000007',4.10),
(8,'Shadowfax','North','9100000008',3.80),
(9,'Ekart','East','9100000009',4.30),
(10,'Amazon Logistics','South','9100000010',4.40),
(11,'Safexpress','West','9100000011',4.10),
(12,'Gati','North','9100000012',3.70),
(13,'TCI Express','East','9100000013',4.00),
(14,'Rivigo','North','9100000014',3.90),
(15,'Shiprocket','South','9100000015',4.20),
(16,'Loadshare','West','9100000016',3.80),
(17,'Pickrr','East','9100000017',3.90),
(18,'Shadow Logistics','North','9100000018',4.10),
(19,'ParcelPro','South','9100000019',4.00),
(20,'QuickShip','West','9100000020',4.30);

CREATE TABLE Shipments (
    shipment_id INT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    carrier_id INT NOT NULL,
    shipment_date DATE NOT NULL,
    expected_delivery DATE NOT NULL,
    actual_delivery DATE,
    shipment_status VARCHAR(30) DEFAULT 'In Transit',

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    FOREIGN KEY (carrier_id)
        REFERENCES Carriers(carrier_id),

    CHECK (expected_delivery >= shipment_date),

    CHECK (actual_delivery IS NULL
           OR actual_delivery >= shipment_date)
);
select * from Shipments;
INSERT INTO Shipments
(shipment_id, order_id, carrier_id, shipment_date,
 expected_delivery, actual_delivery, shipment_status)
VALUES
(5001,1001,1,'2026-01-06','2026-01-10','2026-01-09','Delivered'),
(5002,1002,2,'2026-01-09','2026-01-13','2026-01-14','Delivered'),
(5003,1003,3,'2026-01-13','2026-01-18','2026-01-18','Delivered'),
(5004,1004,6,'2026-01-19','2026-01-23','2026-01-25','Delivered'),
(5005,1005,4,'2026-01-23','2026-01-28',NULL,'In Transit'),
(5006,1006,1,'2026-02-03','2026-02-07','2026-02-07','Delivered'),
(5007,1007,7,'2026-02-06','2026-02-10','2026-02-12','Delivered'),
(5008,1008,5,'2026-02-11','2026-02-16','2026-02-15','Delivered'),
(5009,1009,9,'2026-02-15','2026-02-20',NULL,'Cancelled'),
(5010,1010,10,'2026-02-19','2026-02-24','2026-02-24','Delivered'),
(5011,1011,2,'2026-03-02','2026-03-07','2026-03-06','Delivered'),
(5012,1012,4,'2026-03-05','2026-03-10','2026-03-13','Delivered'),
(5013,1013,3,'2026-03-09','2026-03-14',NULL,'In Transit'),
(5014,1014,15,'2026-03-13','2026-03-17','2026-03-17','Delivered'),
(5015,1015,12,'2026-03-19','2026-03-25','2026-03-29','Delivered'),
(5016,1016,5,'2026-03-23','2026-03-28','2026-03-27','Delivered'),
(5017,1017,14,'2026-04-02','2026-04-07',NULL,'Pending'),
(5018,1018,2,'2026-04-06','2026-04-11','2026-04-10','Delivered'),
(5019,1019,1,'2026-04-11','2026-04-16','2026-04-18','Delivered'),
(5020,1020,10,'2026-04-16','2026-04-21','2026-04-21','Delivered'),
(5021,1021,6,'2026-04-21','2026-04-26','2026-04-28','Delivered'),
(5022,1022,7,'2026-05-03','2026-05-08','2026-05-07','Delivered'),
(5023,1023,3,'2026-05-09','2026-05-14','2026-05-16','Delivered'),
(5024,1024,4,'2026-05-16','2026-05-21',NULL,'In Transit'),
(5025,1025,11,'2026-05-21','2026-05-27','2026-05-26','Delivered');

CREATE TABLE Delivery_Tracking (
    tracking_id INT PRIMARY KEY AUTO_INCREMENT,
    shipment_id INT NOT NULL,
    tracking_date DATETIME NOT NULL,
    location VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL,

    FOREIGN KEY (shipment_id)
        REFERENCES Shipments(shipment_id)
);

INSERT INTO Delivery_Tracking
(tracking_id, shipment_id, tracking_date, location, status)
VALUES
(1,5001,'2026-01-06 09:00:00','Chennai','Picked Up'),
(2,5001,'2026-01-08 14:00:00','Bangalore','In Transit'),
(3,5001,'2026-01-09 18:00:00','Chennai','Delivered'),

(4,5002,'2026-01-09 10:00:00','Bangalore','Picked Up'),
(5,5002,'2026-01-12 12:00:00','Chennai','In Transit'),
(6,5002,'2026-01-14 17:00:00','Chennai','Delivered'),

(7,5003,'2026-01-13 11:00:00','Mumbai','Picked Up'),
(8,5003,'2026-01-16 15:00:00','Pune','Arrived at Hub'),
(9,5003,'2026-01-18 18:00:00','Mumbai','Delivered'),

(10,5004,'2026-01-19 10:00:00','Hyderabad','Picked Up'),
(11,5004,'2026-01-22 13:00:00','Chennai','In Transit'),
(12,5004,'2026-01-25 19:00:00','Chennai','Delivered'),

(13,5005,'2026-01-23 09:00:00','Delhi','Picked Up'),
(14,5005,'2026-01-25 14:00:00','Agra','In Transit'),

(15,5006,'2026-02-03 10:00:00','Chennai','Picked Up'),
(16,5006,'2026-02-05 16:00:00','Bangalore','Arrived at Hub'),
(17,5006,'2026-02-07 18:00:00','Chennai','Delivered'),

(18,5007,'2026-02-06 11:00:00','Pune','Picked Up'),
(19,5007,'2026-02-09 13:00:00','Mumbai','In Transit'),
(20,5007,'2026-02-12 19:00:00','Pune','Delivered'),

(21,5008,'2026-02-11 09:30:00','Kolkata','Picked Up'),
(22,5008,'2026-02-13 15:30:00','Bhubaneswar','In Transit'),
(23,5008,'2026-02-15 18:30:00','Kolkata','Delivered'),

(24,5010,'2026-02-19 10:00:00','Kochi','Picked Up'),
(25,5010,'2026-02-22 15:00:00','Coimbatore','Arrived at Hub'),
(26,5010,'2026-02-24 18:00:00','Kochi','Delivered'),

(27,5012,'2026-03-05 09:00:00','Delhi','Picked Up'),
(28,5012,'2026-03-08 14:00:00','Agra','In Transit'),
(29,5012,'2026-03-13 19:00:00','Delhi','Delivered'),

(30,5015,'2026-03-19 10:00:00','Lucknow','Picked Up'),
(31,5015,'2026-03-23 13:00:00','Delhi','Arrived at Hub'),
(32,5015,'2026-03-29 20:00:00','Lucknow','Delivered'),

(33,5019,'2026-04-11 10:00:00','Chennai','Picked Up'),
(34,5019,'2026-04-15 14:00:00','Bangalore','In Transit'),
(35,5019,'2026-04-18 18:00:00','Chennai','Delivered'),

(36,5021,'2026-04-21 09:00:00','Chennai','Picked Up'),
(37,5021,'2026-04-24 15:00:00','Hyderabad','Arrived at Hub'),
(38,5021,'2026-04-28 19:00:00','Chennai','Delivered'),

(39,5023,'2026-05-09 11:00:00','Mumbai','Picked Up'),
(40,5023,'2026-05-12 14:00:00','Pune','In Transit'),
(41,5023,'2026-05-16 19:00:00','Mumbai','Delivered'),

(42,5025,'2026-05-21 10:00:00','Mumbai','Picked Up'),
(43,5025,'2026-05-24 15:00:00','Pune','Arrived at Hub'),
(44,5025,'2026-05-26 18:00:00','Mumbai','Delivered');

CREATE TABLE Returns (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    return_date DATE NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    reason VARCHAR(100) NOT NULL,
    return_status VARCHAR(30) DEFAULT 'Requested',

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES Products(product_id),

    CHECK (return_status IN
        ('Requested','Approved','Completed','Rejected'))
);

INSERT INTO Returns
(return_id, order_id, product_id, return_date, quantity, reason, return_status)
VALUES
(1,1001,2,'2026-01-15',1,'Damaged','Completed'),
(2,1003,8,'2026-01-25',1,'Defective','Completed'),
(3,1004,4,'2026-02-01',1,'Customer Changed Mind','Approved'),
(4,1006,15,'2026-02-15',1,'Defective','Completed'),
(5,1007,5,'2026-02-18',1,'Damaged','Completed'),
(6,1008,17,'2026-02-22',1,'Wrong Product','Completed'),
(7,1010,16,'2026-03-01',1,'Damaged','Completed'),
(8,1011,7,'2026-03-12',1,'Defective','Approved'),
(9,1012,24,'2026-03-20',1,'Damaged','Completed'),
(10,1013,9,'2026-03-25',1,'Wrong Product','Requested'),
(11,1015,13,'2026-04-02',1,'Size Issue','Completed'),
(12,1015,24,'2026-04-03',1,'Defective','Completed'),
(13,1016,22,'2026-04-05',1,'Damaged','Completed'),
(14,1018,14,'2026-04-15',1,'Customer Changed Mind','Approved'),
(15,1019,24,'2026-04-25',1,'Defective','Completed'),
(16,1020,18,'2026-05-01',1,'Damaged','Completed'),
(17,1021,7,'2026-05-05',1,'Wrong Product','Completed'),
(18,1022,5,'2026-05-15',1,'Damaged','Approved'),
(19,1023,10,'2026-05-20',1,'Size Issue','Completed'),
(20,1023,23,'2026-05-21',1,'Defective','Completed'),
(21,1024,4,'2026-05-28',1,'Damaged','Requested'),
(22,1025,24,'2026-06-02',1,'Defective','Completed'),
(23,1001,1,'2026-01-18',1,'Customer Changed Mind','Rejected'),
(24,1003,8,'2026-01-28',1,'Defective','Completed'),
(25,1012,23,'2026-03-22',1,'Wrong Product','Approved');
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

#25. Create appropriate indexes to improve query performance on frequently used columns such as Customer_ID , 
#Order_ID , Shipment_ID ,Carrier_ID ,Shipment_Date

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