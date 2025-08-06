use my_guitar_shop;
ALTER TABLE customers
ADD Zip_Code INT NOT NULL;



DROP DATABASE IF EXISTS my_web_db;
CREATE DATABASE my_web_db
	DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;
USE my_web_db;

CREATE TABLE users (
	user_id			INT				PRIMARY KEY		AUTO_INCREMENT,
    email_address 	VARCHAR(100)	NOT NULL		UNIQUE,
    first_name		VARCHAR(45)		NOT NULL,
    last_name		VARCHAR(45)		NOT NULL
);

CREATE TABLE products (
	product_id		INT				PRIMARY KEY		AUTO_INCREMENT,
    product_name	VARCHAR(45)		NOT NULL
);

CREATE TABLE downloads (
	download_id		INT				PRIMARY KEY		AUTO_INCREMENT,
    user_id			INT				NOT NULL,
    download_date 	DATETIME 		NOT NULL,
    filename		VARCHAR(50)		NOT NULL,
    product_id		INT				NOT NULL,
    CONSTRAINT downloads_fk_users
		FOREIGN KEY (user_id)
        REFERENCES users (user_id),
	CONSTRAINT downloads_fk_products
		FOREIGN KEY (product_id)
        REFERENCES products (product_id)
);