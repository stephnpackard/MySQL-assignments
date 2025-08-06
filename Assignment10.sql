USE my_guitar_shop;
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE;
    
    DECLARE order_id INT(11);
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
	
    START TRANSACTION;
		
        INSERT INTO orders VALUES
			(DEFAULT, 3, NOW(), '10.00', '0.00', NULL, 4,
			'American Express', '378282246310005', '04/2016', 4);
		
        SELECT LAST_INSERT_ID()
        INTO order_id;
        
        INSERT INTO order_items VALUES
			(DEFAULT, order_id, 6, '415.00', '161.85', 1);
            
		INSERT INTO order_items VALUES
			(DEFAULT, order_id, 1, '699.00', '209.70', 1);
            
		IF sql_error = FALSE THEN
			COMMIT;
            SELECT 'The transaction was committed.';
		ELSE
			ROLLBACK;
            SELECT 'The transaction was rolled back.';
		END IF;
	END//
DELIMITER //

CALL test();