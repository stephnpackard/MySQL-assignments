/*1*/
USE my_guitar_shop;
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE product_count INT;
    
    SELECT COUNT(product_id)
    INTO product_count
    FROM products;
    
    IF product_count >= 7 THEN
		SELECT 'The number of products is greater than or equal to 7.' AS message;
	ELSE
		SELECT 'The number of products is less than 7';
	END IF;
END//

DELIMITER //

CALL test();


/*2*/
USE my_guitar_shop;
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE product_count INT;
    DECLARE price_avg DECIMAL(10,2);
    
    SELECT COUNT(product_id)
    INTO product_count
    FROM products;
    
    SELECT AVG(list_price)
    INTO price_avg
    FROM products;
    
    IF product_count >= 7 THEN
		SELECT product_count AS product_count,
				price_avg AS price_avg;
	ELSE 
		SELECT "The number of products is less than 7" AS message;
	END IF;
    
END//

DELIMITER //

CALL test();


/*3*/
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN

	DECLARE i INT DEFAULT 1;
    DECLARE s VARCHAR(400) DEFAULT '';
    
    WHILE i < 10 DO
		IF (MOD(10,i) = 0) THEN
			SET s = CONCAT(s, ' ', i);
		END IF;
        SET i = i + 1;
	END WHILE;
    
    SELECT s AS message;
         
END//

DELIMITER //

CALL test();

/*4*/
USE my_guitar_shop;
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN

	DECLARE row_not_found TINYINT DEFAULT FALSE;
	DECLARE product_name_var VARCHAR(255);
	DECLARE list_price_var DECIMAL(10,2);
	DECLARE s VARCHAR(400) DEFAULT '';

	DECLARE results_cursor CURSOR FOR
		SELECT product_name, list_price
		FROM products
		WHERE list_price > 700
		ORDER BY list_price DESC;
         
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET row_not_found = TRUE;
    
	OPEN results_cursor;
	
	WHILE row_not_found = FALSE DO
		FETCH results_cursor INTO product_name_var, list_price_var;
		SET s = CONCAT(s,'"',product_name_var,'"',',','"',list_price_var,'"','|');
	END WHILE;
	
	CLOSE results_cursor;

	SELECT s as message;

END//

DELIMITER //

CALL test();

/*5*/
USE my_guitar_shop;
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN

	DECLARE duplicate_entry_for_key TINYINT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR 1062
		SET duplicate_entry_for_key = TRUE;
        
	INSERT INTO categories (category_name)
    VALUES ('Guitars');
    
    IF duplicate_entry_for_key = TRUE THEN
		SELECT 'Row was not inserted - duplicate entry.'
			AS message;
	ELSE
		SELECT '1 row was inserted.' AS message;
	END IF;

END//

DELIMITER //

CALL test();