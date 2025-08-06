USE my_guitar_shop;
SELECT COUNT(*) AS Number_of_Orders, SUM(tax_amount) AS Total_Tax
FROM orders;
    
USE my_guitar_shop;
SELECT c.category_id, c.category_name, COUNT(*) AS Product_Count, MAX(list_price) AS Most_Expensive
FROM products p JOIN categories c
	ON p.category_id = c.category_id
GROUP BY p.category_id
ORDER BY Product_Count DESC;

USE my_guitar_shop;
SELECT c.email_address, (oi.item_price * oi.quantity) AS Base_Price, (oi.discount_amount * oi.quantity) As Discount_Amount
FROM customers c JOIN orders o
	ON c.customer_id = o.customer_id
	JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.email_address
ORDER BY Base_Price DESC;

USE my_guitar_shop;
SELECT c.email_address, COUNT(o.customer_id) as Order_Count, ((oi.item_price - oi.discount_amount) * oi.quantity) AS Price
FROM customers c JOIN orders o
	ON c.customer_id = o.customer_id
    JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.email_address
HAVING Count(o.customer_id) > 1;

USE my_guitar_shop;
SELECT c.email_address, COUNT(o.customer_id) as Order_Count, ((oi.item_price - oi.discount_amount) * oi.quantity) AS Price
FROM customers c JOIN orders o
	ON c.customer_id = o.customer_id
    JOIN order_items oi
    ON o.order_id = oi.order_id
	WHERE oi.item_price > 400
GROUP BY c.email_address
HAVING Count(o.customer_id) > 1;

USE my_guitar_shop;
SELECT p.product_name, SUM(oi.quantity) AS Total_Amount, SUM(oi.quantity) AS quantity
FROM products p JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id WITH ROLLUP;

USE my_guitar_shop;
SELECT DISTINCT c.email_address, COUNT(oi.product_id)
FROM customers c JOIN orders o
	ON c.customer_id = o.customer_id
    JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.email_address
HAVING COUNT(oi.product_id) > 1
ORDER BY c.email_address ASC;
    
    