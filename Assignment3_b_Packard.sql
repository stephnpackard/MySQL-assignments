USE my_web_db;
INSERT INTO users (first_name, last_name, email_address) VALUES
	('John', 'Smith', 'johnsmith@gmail.com'),
    ('Jane', 'Doe', 'janedoe@yahoo.com');
    
USE my_web_db;
SELECT *
FROM users;
    
USE my_web_db;
INSERT INTO products (product_name) VALUES
	('Local Music Vol 1'),
    ('Local Music Vol 2');
    
USE my_web_db;
INSERT INTO downloads (user_id, download_date, filename, product_id) VALUES
	(1, NOW(), 'pedals_are_falling.mp3', 2),
    (2, NOW(), 'turn_signal.mp3', 1),
    (2, NOW(), 'one_horse_town.mp3', 2);

USE my_web_db;
SELECT *
FROM downloads;

USE my_web_db;
SELECT u.email_address, u.first_name, u.last_name,
	d.download_date, d.filename, p.product_name
FROM downloads d
INNER JOIN users u
	ON u.user_id = d.user_id
INNER JOIN products p
	ON p.product_id = d.product_id
ORDER BY u.email_address DESC;