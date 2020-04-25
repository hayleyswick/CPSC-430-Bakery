CREATE DATABASE bakery_calc;

USE bakery_calc;

CREATE TABLE users (
	id VARCHAR(45) PRIMARY KEY NOT NULL, 
	username TEXT NOT NULL, 
	password TEXT, type TEXT, 
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
	quantity DOUBLE
);

CREATE TABLE orders (
	order_number INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
	customer_id VARCHAR(45), 
	order_notes TEXT, 
	order_date DATE
);

CREATE TABLE baked_goods (
	id INT PRIMARY KEY NOT NULL, 
	name TEXT, 
	shape TEXT, 
	batter_type TEXT, 
	batter_per_batch DOUBLE, 
	quantity INT
); 
