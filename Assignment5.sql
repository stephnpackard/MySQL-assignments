USE my_guitar_shop;
INSERT INTO categories (category_name)
VALUES ('Strings');

USE my_guitar_shop;
UPDATE categories
SET category_name = "Horns"
WHERE category_id = 5;

USE my_guitar_shop;
DELETE FROM categories
WHERE category_id = 5;

USE my_guitar_shop;
INSERT INTO products
			(category_id, product_code, product_name, description, list_price, discount_percent, date_added)
    VALUES 	(4, "dgx_640", "Yamaha DGX 640 88-Key Digital Piano", "Long description to come.", "799.99", "0", NOW());

USE my_guitar_shop;
UPDATE products
SET discount_percent = 35
WHERE product_id = 11;

USE my_guitar_shop;
DELETE FROM products
WHERE category_id = 4;
DELETE FROM categories
WHERE category_id = 4;

USE my_guitar_shop;
UPDATE customers
SET password = 'reset'
LIMIT 100;