SELECT c.category_name, p.product_name, p.list_price
FROM categories c
INNER JOIN products p
ON c.category_id = p.category_id
ORDER BY c.category_name,
	product_name ASC;
    
SELECT c.first_name, c.last_name, a.line1, a.city,
		a.state, a.zip_code
FROM customers c
INNER JOIN addresses a 
ON c.customer_id = a.customer_id;

SELECT c.last_name, c.first_name, o.order_date, p.product_name,
		oi.item_price, oi.discount_amount, oi.quantity
FROM customers c
INNER JOIN orders o 
ON o.customer_id = c.customer_id
INNER JOIN order_items oi
ON oi.order_id = o.order_id
INNER JOIN products p 
ON p.product_id = oi.product_id
ORDER BY last_name, order_date, product_name;

SELECT c.category_name, p.product_id
FROM categories c
LEFT JOIN products p
ON c.category_id = p.category_id
WHERE product_id IS NULL;

SELECT order_id, order_date, "NOT SHIPPED" AS ship_status
FROM Orders
WHERE ship_date IS NULL
UNION
SELECT order_id, order_date, "SHIPPED" AS ship_status
FROM Orders
WHERE ship_date IS NOT NULL
ORDER BY order_date;