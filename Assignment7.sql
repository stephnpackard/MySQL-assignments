USE my_guitar_shop;
SELECT DISTINCT category_name
FROM categories
WHERE category_id IN 
	(SELECT category_id
	 FROM products)
ORDER BY category_name;

SELECT product_name, list_price
FROM products
WHERE list_price >
	(SELECT AVG(list_price)
	 FROM products)
ORDER BY list_price DESC;

SELECT category_name
FROM categories
WHERE NOT EXISTS
	(SELECT category_id
     FROM products
     WHERE category_id = categories.category_id);
       
SELECT customers.email_address, orders.order_id, order_items.item_price - order_items.discount_amount AS Order_Total
FROM order_items, customers, orders
WHERE customers.customer_id = orders.customer_id AND
	  orders.order_id = order_items.order_id
GROUP BY email_address, order_id;

SELECT c.email_address, order_id, order_date
FROM customers c, orders
WHERE order_date IN (
	SELECT MIN(order_date)
    FROM orders
    WHERE customer_id = c.customer_id
    ORDER BY order_date ASC
)
ORDER BY order_date, order_id;

SELECT list_price, 
	   FORMAT(list_price,1) AS one_decimal, 
	   CONVERT(list_price, SIGNED) AS convert_integer, 
       CAST(list_price AS SIGNED) AS cast_integer
FROM Products;

SELECT date_added,
	   CAST(date_added AS DATE) AS date_only,
       DATE_FORMAT(CAST(date_added AS DATE),"%Y-%m")  AS date_ym,
       CAST(date_added AS TIME) AS time_only
FROM Products;