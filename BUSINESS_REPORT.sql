--- BUSINESS  REPORT

--- SOME QUESTION BUSINESS AND QUERY THEN INSIGHT OF BUSINESS
-- CUSTOMER ANALYSIS
-- HOW MANY CUSTOMER REGISTER?
SELECT COUNT(*) AS total_customer FROM customers;
-- 50 CUSTOMER ARE REGISTER

--  WHICH COUNTRY/STATE HAS MORE CUSTOMER REGISTER?
SELECT c.country,c.state,COUNT(*)AS total_customer FROM customers o JOIN address c 
ON o.customer_id=c.customer_id GROUP BY c.country,c.state;
-- ONLY INDIA HAS MORE CUSOMTER AND  ALL STATE WISE ALSO CUSTOMER IS SAME 

-- WHO'S MOSTLY GENDER CUSOMTER ARE REGISTER?
SELECT gender,COUNT(*)AS TOTAL_CUSOMER FROM customers GROUP BY gender;
-- THE  FEMALE AND MALE HAVE SAME CUSTOMER

-- WHICH CUSTOMER HAVE MORE ORDER?
SELECT c.customer_id,c.first_name,c.last_name,COUNT(*)AS TOTAL_ORDER FROM 
customers c JOIN orders o ON c.customer_id=o.customer_id GROUP BY 
c.customer_id,c.first_name,c.last_name ORDER BY TOTAL_ORDER DESC;
-- ALL MOST ALL CUSTOMER ORDER ONLY ONE TIMES

-- HOE MANY CUSTOMER  GET REGISTERED BY MONTH?
SELECT TO_CHAR(created_at,'MONTH')AS month_name,COUNT(*) AS total_customer 
FROM customers GROUP BY month_name;
-- JULY RECORD THE HIGHEST CUSTOMER REGISTRATIONS (50 CUSTOMERS)

-- PRODUCT ANALYSIS
-- HOW MANY PRODUCT?
SELECT COUNT(*) AS TOTAL_PRODUCT FROM products;
-- 51 PRODUCTS

-- WHICH PRODUCT HAS MAX PRICE?
SELECT * FROM products WHERE price=(SELECT MAX(price) FROM products);
--iPhone 15  IS THE HAVE HIGEST PRICE 79999.0  PRODUCT IN CATLOG.


--WHICH PRODUCTS HAVE MAX DISCOUNT ?
SELECT DISTINCT product_name,discount FROM products ORDER BY discount DESC LIMIT 1;
-- ONLY Boat Airdropes HAVE MAX DISCOUNT 25 %.

-- WHICH PRODUCT HAS GOING TO OUT OF STOCK?
SELECT DISTINCT product_name,stock_quantity FROM products ORDER BY stock_quantity ASC LIMIT 5;
-- THEY LIKE STOCK 15,25,30 HAS LOW STOCK

-- WHICH PRODUCT HAS MORE EXPENSIVE?
SELECT * FROM products ORDER BY price DESC LIMIT 10;
-- THEY ARE TOP 10 PRODUCT HAS MOST EXPENSIVE

-- WISHLIST_ANALYSIS
-- WHICH PRODUCTS ARE MOST POPULAR IN CUSTOMER WISHLST?
SELECT p.product_name ,COUNT(*)AS wishlist_count FROM products p JOIN wishlist w 
ON p.product_id=w.product_id GROUP BY p.product_name HAVING COUNT(*)>1;
-- THE 8 PRODUCTS HAS MORE CUSTOEMR WISHLIST.

--- SHIPMENTS ANALYSIS
-- HOW MANY CUSTOMER ORDER ARE DELIVERED?
SELECT COUNT(*) FROM shipments WHERE shipment_status='Delivered';
-- 21 ORDER ARE DELVERED

-- WHICH COURIER ARE MOSTLY USED FOR SHIPMENTS?
SELECT courier_name,COUNT(*) shipement FROM shipments GROUP BY courier_name;
-- COURIER USSAGE IS EVENLY DISTRIBUTED AMONG AVAILBLE COURIER PARTNERS.

-- HOW MANY SHIPMENTS WERE DISPATCHED EACH MONTH?
SELECT TO_CHAR(shipment_date,'Month') AS month_name,EXTRACT(MONTH FROM shipment_date)AS month,
COUNT(*)AS total_shipment FROM shipments GROUP BY month_name,month ORDER BY month;
-- ONLY JULY HAS HIGHEST SHIPMENTS 31 THEN NEXT AUGEST

-- HOW MANY SHIPMENTS WERE DELIVERED EACH MONTH?
SELECT EXTRCT(MONTH FROM delivery_date) AS month,COUNT(*) AS delivery_order FROM shipments 
WHERE shipment_status='Delivered' GROUP BY EXTRCT(MONTH FROM delivery_date) ORDER BY month;


-- PAYMENT ANALYSIS

-- WHICH PAYMENT TYPE ARE USED MORE ?
SELECT payment_type,COUNT(*) AS total_payment FROM payments GROUP BY payment_type;
-- THE UPI AND CARD HAVE 17 TIMES BY PAYMENT AND MORE PAYMENT TYPE USED IS CASH 18 TIMES .

-- INVENTORY ANALYSIS

-- WHICH PRODUCT HAS LOW STOCK?
SELECT product_name,stock_quantity FROM products WHERE stock_quantity <10;
-- THEY ARE NO PRODUCTS IS LOW STOCK

-- SELLER ANALYSIS

-- WHAT IS THE AVERAGE PRODUCT PRICE BY SELLER?
SELECT s.seller_name,s.business_name,ROUND(AVG(p.price),2) AS AVG_PRODUCT_BY_SELLER FROM sellers s JOIN products p
ON s.seller_id=p.seller_id GROUP BY s.seller_name,s.business_name ORDER BY AVG_PRODUCT_BY_SELLER DESC;
-- PRIYA PATEL HAS LARGEST AVG_PRODUCT_PRICE LIKE 41999.0

-- WHICH BUSINESS OR SELLER CRETED THE RECENT?
SELECT * FROM sellers WHERE created_at=CURRENT_DATE;
-- NO ONE SELLER ADDED

-- WHICH BUSNIESS OR SELLER HIGHEST RATING?
SELECT * FROM sellers ORDER BY rating DESC ;
-- MAX RATING IS 5 CAMERE STORE HAS HIHGEST RATING



-- ORDER ANALYSIS
-- HOW MANY ORDERS GET ORDER?
SELECT DISTINCT COUNT(*) AS total_order FROM orders ;
-- TOTAL ORDER 50 

-- WHICH PRODUCT MOSTLY ORDERS?
SELECT p.prodcut_name,COUNT(*) AS total_orders FROM order_items o JOIN 
products p ON o.prodcut_id=p.product_id GROUP BY p.product_name ORDER BY total_orders DESC;
-- ALL MOST SAME GET ORDER ONE TIMES

-- CATEGORY ANALYSIS
-- HOW MANY CATEGORY ARE THERE?
SELECT COUNT(*) AS total_category FROM categories;
-- THERE ARE 20 CATEGORY

-- WHICH CATEGORY PRODUCT ARE MORE ORDERED?
SELECT c.category_name,p.product_name,COUNT(*)AS total_order FROM categories c JOIN products p
ON c.category_id=p.category_id JOIN order_items oi ON p.product_id=oi.product_id 
GROUP BY c.category_name,p.product_name HAVING COUNT(*)>1;
-- ALL MOST  ALL CATEGORY HAVE SAME ORDER NUMBER 1 NOT TO 2

-- REVIEW ANALYSIS
-- WHICH PRODUCTS ARE MORE REVIEW  RATING?
SELECT p.product_name,r.rating FROM products p JOIN 
review r ON p.product_id=r.product_id  ORDER BY r.rating DESC ;
-- 19 PRODUCT HAVE SAME RATING OR HIGHEST RATING 5

-- GIFT ANALYSIS
--  WHICH CUSTOMER HAVE MORE GIFT GET?
SELECT c.customer_id,c.first_name,c.last_name,COUNT(g.gifT_id)AS total_gift FROM customers c JOIN orders o 
ON c.customer_id=o.customer_id JOIN gifts g ON o.order_id=g.order_id GROUP BY c.customer_id,c.first_name,
c.last_name HAVING COUNT(g.gift_id)>1;
-- NO ONE HAS MORE GIFT ONLY 1


-- SALES ANALYSIS

-- TELL THE TOTAL_SALES
SELECT SUM(quantity*selling_price) AS total_sales FROM order_items;
-- TOTAL SALES 6554090.0

-- HOW MANY PRODUCTS ARE SOLD?
SELECT SUM(quantity) AS total_sold_products FROM order_items;
-- 50 PRODUCTS ARE SOLD

-- TOP 5 PRODUCTS HAS HIGHEST REVENUE
SELECT p.product_name,SUM(o.quantity*o.selling_price)AS revenue FROM order_items o JOIN 
products p ON o.product_id=p.product_id GROUP BY p.product_name ORDER BY revenue DESC LIMIT 5;
-- iPhone 15 HAS HIGHEST REVENUE 79999.0

-- WHICH CUSTOMER ARE SPENDING MORE?
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,SUM(oi.quantity*oi.selling_price) AS revenue 
FROM customers c JOIN orders o
    ON c.customer_id = o.customer_id
JOIN Order_Items oi
    ON o.order_id = oi.order_id  GROUP BY c.customer_id,c.first_name,c.last_name ORDER BY revenue DESC LIMIT 1;
-- RAHUL HAS  HIGHEST SPENDING AMOUNT

-- TOP 5 CATEGORY HAVE HIGHEST REVENUE
SELECT  c.category_name ,SUM(o.quantity*o.selling_price)AS revenue FROM order_items o JOIN 
products p ON o.product_id=p.product_id JOIN categories c ON p.category_id=c.category_id  GROUP BY c.category_name 
ORDER BY revenue DESC LIMIT 5;
-- ELECTRONICS HAVE HIGHEST REVENUE 483490.0

-- WHAT IS LOWEST ORDER VALUE?
SELECT order_id,SUM(quantity*selling_price) AS rev FROM order_items GROUP BY order_id ORDER BY rev ASC LIMIT 1;
-- LOWEST REV 180.0 HAVE ORDER ID 26

-- WHAT IS DISCOUNT AVERAGE?
SELECT AVG(discount) AS average_discount FROM order_items;
-- NO DISCOUNT GIVEN TO ALL ORDERS SO THE AVERAGE VALUE 0

-- WHAT IS AVERAGE REVENUE?
SELECT ROUND(AVG(order_total),2) FROM (
SELECT order_id,SUM(quantity*selling_price) AS order_total FROM order_items GROUP BY order_id ) t;
-- THE AVERAGE 13108.18
