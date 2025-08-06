/*1*/
USE my_guitar_shop;
DROP PROCEDURE IF EXISTS insert_category;

DELIMITER //

CREATE PROCEDURE insert_category
(
	category_name_param		varchar(255)
)
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE;
		
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
	
    START TRANSACTION;
	
    INSERT INTO categories (category_name)
    VALUES	(category_name_param);
    
    IF sql_error = FALSE THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
END//

DELIMITER //

CALL insert_category('horns');
CALL insert_category('woodwinds');


/*2*/
USE my_guitar_shop;
DROP FUNCTION IF EXISTS discount_price;

DELIMITER //

CREATE FUNCTION discount_price (
	product_id_param	INT
)
RETURNS DECIMAL(10,2)
    DETERMINISTIC READS SQL DATA
	BEGIN
    
    DECLARE discount_price DECIMAL(10,2);
    
    SELECT ROUND((list_price - (list_price * (discount_percent * .01))),2) 
    INTO discount_price
    FROM products
    WHERE product_id = product_id_param;
    
    RETURN(discount_price);
END//

DELIMITER //



/*3*/
USE my_guitar_shop;
DROP FUNCTION IF EXISTS item_total;

DELIMITER //

CREATE FUNCTION item_total
(
	product_id_param	INT 
)
RETURNS DECIMAL(10,2)
DETERMINISTIC READS SQL DATA
BEGIN
	DECLARE item_total DECIMAL(10,2);
	DEClARE discount_p DECIMAL(10,2);
    
    SET discount_p = discount_price(product_id_param);
    
    SELECT (COUNT(*) * discount_p)
    INTO item_total
    FROM order_items
    WHERE product_id = product_id_param;
    
    RETURN(item_total);
END//

DELIMITER //
	
    
/*4*/
DELIMITER //

CREATE TRIGGER products_before_update
	BEFORE UPDATE ON products
    FOR EACH ROW
BEGIN
	IF ((NEW.discount_percent > 100) OR (NEW.discount_percent < 0)) THEN
		SIGNAL SQLSTATE 'HY000'
			SET MESSAGE_TEXT =
				'Discount percentage must be more than 0 and less than 100.';
	ELSEIF ((NEW.discount_percent > 0) AND (NEW.discount_percent < 1)) THEN
		SET NEW.discount_percent = (NEW.discount_percent * 100);
	END IF;
END//

DELIMITER //

UPDATE products
SET discount_percent = 30
WHERE product_id = 1;

/*5*/
USE my_guitar_shop;
CREATE TABLE Products_Audit (
	audit_id			INT(11)			PRIMARY KEY		AUTO_INCREMENT,
	product_id 			INT(11),
    category_id			INT(11),
    product_code		VARCHAR(10),
    product_name		VARCHAR(255),
    description			TEXT,
    list_price			DECIMAL(10,2),
    discount_percent	DECIMAL(10,2),
    date_updated		DATETIME
);

/*6*/
DELIMITER //

CREATE TRIGGER products_after_update
	AFTER UPDATE ON products
	FOR EACH ROW
BEGIN
	INSERT INTO products_audit 
		(product_id, category_id,
        product_code, product_name,
        description, list_price,
        discount_percent, date_updated)
        VALUES
		(OLD.product_id, OLD.category_id, 
        OLD.product_code, OLD.product_name,
        OLD.description, OLD.list_price,
        OLD.discount_percent, NOW());
END//
	
UPDATE products
SET discount_percent = 30
WHERE product_id = 1;

/*7*/
DELIMITER //

CREATE EVENT daily_delete_audit_rows
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO BEGIN
	DELETE FROM products_audit
    WHERE date_updated < NOW() - INTERVAL 1 WEEK;
END//

DROP EVENT daily_delete_audit_rows;

show events;