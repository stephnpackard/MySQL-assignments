USE my_guitar_shop;
SELECT product_code, product_name, list_price, discount_percent
FROM products;

USE my_guitar_shop;
SELECT product_code, product_name, list_price, discount_percent
FROM products
ORDER BY list_price DESC;

USE my_guitar_shop;
SELECT product_name, list_price, date_added
FROM products
WHERE list_price > 500 AND list_price < 2000
ORDER BY date_added DESC;

USE my_guitar_shop;
SELECT p.product_name, p.list_price, p.discount_percent,
		ROUND(p.list_price*(p.discount_percent/100),2) AS discount_amount
FROM (
	SELECT p.product_name, p.list_price, p.discount_percent, ROUND(list_price-(list_price*(discount_percent/100)),2) AS discount_price
    FROM products p
    ORDER BY discount_price DESC
    LIMIT 5
) as p;

USE my_guitar_shop;
SELECT order_id, order_date, ship_date
FROM orders
WHERE ship_date IS NULL;