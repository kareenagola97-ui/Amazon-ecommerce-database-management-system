
CREATE DATABASE ecommerce_amazon_db;

--Create Table
CREATE TABLE Customers(
customer_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
date_of_birth DATE NOT NULL,
gender VARCHAR(10) CHECK(gender IN('Female','Male','Other','Prefer not to say')),
email VARCHAR(100) UNIQUE NOT NULL,
country_code VARCHAR(5) NOT NULL,
phone_number VARCHAR(10) UNIQUE NOT NULL ,
password  VARCHAR(255) NOT NULL,
account_status VARCHAR(15) CHECK(account_status IN ('active')),
created_at DATE DEFAULT(CURRENT_DATE)
);
CREATE TABLE Address(
address_id SERIAL PRIMARY KEY,
customer_id INT ,FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
house_no  SERIAL NOT NULL,
state VARCHAR(100) NOT NULL,
country VARCHAR(100) NOT NULL,
postal_code INT NOT NULL,
address_type VARCHAR(20) CHECK(address_type IN('Home','Office','Other'))
);
CREATE TABLE Sellers(
seller_id  SERIAL PRIMARY KEY,
seller_name VARCHAR(150) NOT NULL,
business_name VARCHAR(150) NOT NULL,
email VARCHAR(100) NOT NULL u
phone_number VARCHAR(10) UNIQUE NOT NULL,
gst_number VARCHAR(15) NOT NULL,
rating INT CHECK(rating<=5),
created_at DATE DEFAULT(CURRENT_DATE)
);
CREATE TABLE Categories(
category_id  SERIAl PRIMARY KEY,
category_name VARCHAR(100) NOT NULL,
description VARCHAR(250) NOT NULL
);
CREATE TABLE Products(
product_id SERIAL PRIMARY KEY,
seller_id INT ,FOREIGN KEY(seller_id) REFERENCES Sellers(seller_id),
category_id INT,FOREIGN KEY(category_id) REFERENCES Categories(category_id),
product_name VARCHAR(150) NOT NULL,
brand VARCHAR(100) NOT NULL,
description VARCHAR(150) NOT NULL,
price DECIMAL(5,2) CHECK(price>0),
discount DECIMAL(5,2) CHECK(discount>10),
stock_quantity INT   CHECK(stock_quantity>0)
);
CREATE TABLE Cart(
cart_id SERIAL PRIMARY KEY,
customer_id INT,FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE Cart_item(
cart_item_id SERIAL PRIMARY KEY,
cart_id INT,FOREIGN KEY(cart_id) REFERENCES Cart(cart_id),
product_id INT,FOREIGN KEY(product_id) REFERENCES Products(product_id)
);
CREATE TABLE Orders(
order_id SERIAL PRIMARY KEY,
customer_id INT,FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
address_id INT,FOREIGN KEY(address_id) REFERENCES Address(address_id)
);
CREATE TABLE Order_items(
order_item_id SERIAL PRIMARY KEY,
order_id INT ,FOREIGN KEY(order_id) REFERENCES Orders(order_id),
product_id INT ,FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

ALTER TABLE order_items ADD COLUMN quantity INT DEFAULT 1,
ADD COLUMN sellinh_price DECIMAL(10,2),
ADD COLUMN discount DECIMAL(5,2) DEFAULT 0;
ALTER TABLE order_items RENAME COLUMN sellinh_price TO selling_price;

CREATE TABLE Payments(
payment_id SERIAL PRIMARY KEY,
order_id INT,FOREIGN KEY(order_id) REFERENCES Orders(order_id),
payment_type VARCHAR(150) NOT NULL CHECK(payment_type IN('cash','UPI','card'))
);
CREATE TABLE Shipments(
shipment_id  SERIAL PRIMARY KEY,
order_id INT,FOREIGN KEY(order_id) REFERENCES Orders(order_id),
tracking_number VARCHAR(50) UNIQUE,
courier_name  VARCHAR(100) NOT NULL,
shipment_status  VARCHAR(20) CHECK(shipment_status IN('Pending','Shipment','Out for','Delivery','Delivered','Cancelled')),
shipment_date DATE ,
expected_delivery_date DATE,
delivery_date DATE
);
CREATE TABLE Review(
review_id SERIAL PRIMARY KEY,
customer_id INT ,FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
product_id INT ,FOREIGN KEY (product_id) REFERENCES Products(product_id),
rating INT CHECK(rating<=5)
);
CREATE TABLE Wishlist(
wishlist_id SERIAL PRIMARY KEY,
customer_id INT ,FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
product_id INT ,FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Inventory(
inventory_id SERIAL PRIMARY KEY,
product_id INT ,FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Gifts(
gift_id SERIAL PRIMARY KEY,
order_id INT,FOREIGN KEY(order_id) REFERENCES Orders(order_id),
gift_message VARCHAR(255) ,
gift_wrap BOOLEAN  DEFAULT  FALSE,
recipient_name VARCHAR(100) NOT NULL
);

