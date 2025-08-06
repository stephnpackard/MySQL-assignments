USE my_guitar_shop;
SELECT list_price, discount_percent,
	   ROUND((list_price * (discount_percent * 0.01)),2) AS discount_amount
FROM products;

USE my_guitar_shop;
SELECT order_date, DATE_FORMAT(order_date, "%Y") AS year,
	   DATE_FORMAT(order_date, "%b-%d-%Y") as `Mon-DD-YYYY`,
       DATE_FORMAT(order_date, "%l:%i %p") as `12 hour`,
       DATE_FORMAT(order_date, "%m/%d/%y %H:%i") as `24 hour`
FROM orders;

USE my_guitar_shop;
SELECT order_id, order_date,
	   DATE_ADD(order_date, INTERVAL 2 DAY) AS approx_ship_date,
       ship_date,
       DATEDIFF(ship_date, order_date) AS shipping_time
FROM Orders
WHERE ship_date IS NOT NULL;

USE my_guitar_shop;
SELECT p.product_name, SUM(oi.quantity) as quantity,
	   RANK() OVER (
			ORDER BY SUM(oi.quantity) DESC
	   ) my_rank,
       DENSE_RANK() OVER (
			ORDER BY SUM(oi.quantity) DESC
	   ) d_rank
FROM products p
JOIN order_items oi
WHERE p.product_id = oi.product_id
GROUP BY product_name;

USE my_guitar_shop;
SELECT c.category_name, p.product_name, SUM(oi.quantity) AS total_sales,
	   FIRST_VALUE(p.product_name) OVER (
		    PARTITION BY c.category_name
			ORDER BY SUM(oi.quantity) DESC
	   ) highest_sales,
       LAST_VALUE(p.product_name) OVER (
			PARTITION BY c.category_name
            ORDER BY SUM(oi.quantity) DESC
            RANGE BETWEEN UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING
	   ) lowest_sales
FROM products p, categories c, order_items oi
WHERE p.category_id = c.category_id AND
	  p.product_id = oi.product_id
GROUP BY product_name
ORDER BY category_name, SUM(oi.quantity) DESC;

CREATE VIEW customer_addresses AS
SELECT c.customer_id, c.email_address, c.last_name, first_name,
	   aa.line1 AS bill_line1, aa.line2 AS bill_line2,
       aa.city AS bill_city, aa.state AS bill_state, 
       aa.zip_code AS bill_zip, a.line1 AS ship_line1,
       a.line2 AS ship_line2, a.city AS ship_city,
       a.state AS ship_state, a.zip_code AS ship_zip
FROM customers c
JOIN addresses a
ON c.shipping_address_id = a.address_id
JOIN addresses aa
ON c.billing_address_id = aa.address_id;

SELECT customer_id, last_name, first_name, bill_line1
FROM customer_addresses
ORDER BY last_name, first_name;

UPDATE customer_addresses
SET ship_line1 = '1990 Westwood Blvd'
WHERE customer_id = 8;
 
CREATE VIEW order_item_products AS
SELECT o.order_id, o.order_date, o.tax_amount, o.ship_date,
	   p.product_name, oi.item_price, oi.discount_amount,
	   (oi.item_price - oi.discount_amount) AS final_price,
       oi.quantity,
       ((oi.item_price - oi.discount_amount) * oi.quantity) AS item_total
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id;

CREATE VIEW product_summary AS
SELECT product_name, SUM(quantity) AS order_count, 
	   (final_price * SUM(quantity)) AS order_total
FROM order_item_products
GROUP BY product_name;

SELECT product_name, order_count, order_total
FROM product_summary
ORDER BY order_total DESC
LIMIT 5;
