
CREATE DATABASE bakery_calc;

USE bakery_calc;

CREATE TABLE users (id VARCHAR(45) PRIMARY KEY NOT NULL, username TEXT, password TEXT);
CREATE TABLE sessions (session_id VARCHAR(45) PRIMARY KEY NOT NULL, user_id VARCHAR(45) NOT NULL);
CREATE TABLE inventory (batterType TEXT, quantity INT);
CREATE TABLE orders (order_number VARCHAR(45) PRIMARY KEY NOT NULL, customer_name TEXT, batter_type TEXT, quantity INT);

