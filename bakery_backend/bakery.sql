
DROP USER 'bakery_calc'@'localhost';
CREATE USER 'bakery_calc'@'localhost' IDENTIFIED BY 'y3myChfMa0oop0rz5RiOPDdTq93eBLK5RonWpDbrurbLr';

DROP DATABASE bakery_calc;
CREATE DATABASE bakery_calc;

GRANT all privileges ON bakery_calc.* to 'bakery_calc'@'localhost';

USE bakery_calc;

CREATE TABLE users (
	id VARCHAR(45) PRIMARY KEY NOT NULL, 
	username TEXT NOT NULL, 
	password TEXT, 
	type TEXT, 
	firstname TEXT, 
	lastname TEXT
);

CREATE TABLE sessions (
	session_id VARCHAR(45) PRIMARY KEY NOT NULL, 
	user_id VARCHAR(45) NOT NULL
);

CREATE TABLE inventory (
	batter_type TEXT, 
	quantity DOUBLE
);

CREATE TABLE customers (
	id VARCHAR(45) PRIMARY KEY NOT NULL, 
	firstname TEXT, 
	lastname TEXT, 
	phone_number TEXT, 
	street TEXT, 
	city TEXT, 
	state TEXT, 
	zip TEXT
);

CREATE TABLE order_details (
	order_number INT NOT NULL, 
	batter_type TEXT, 
	cake_type TEXT, 
	quantity INT
);

CREATE TABLE orders (
	order_number INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
	customer_id VARCHAR(45), 
	order_notes TEXT, 
	order_date DATETIME
);

CREATE TABLE baked_goods (
	id INT PRIMARY KEY NOT NULL, 
	name TEXT, 
	shape TEXT, 
	batter_type TEXT, 
	batter_per_batch DOUBLE, 
	quantity INT
); 

#Temporary User


