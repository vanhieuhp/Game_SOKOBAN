-- Filtering
 
SHOW databases;
use information_schema;  show tables;
use mysql; show tables;
use performance_schema; show tables;
use sys; show tables;

USE european_sales;

SELECT customer_id, rental_time_day
FROM rental
WHERE rental_time_day BETWEEN 10 AND 20;

desc rental;
desc film;

-- Range conditions
SELECT film_id, title, count
FROM film
WHERE count BETWEEN 20 AND 25;

-- String ranges
desc customer;
SELECT * FROM customer;
INSERT INTO customer VALUES(
	null, 9, 'John', 'Farnsworth', 'john@gmail.com', 9, 0, null, null);
INSERT INTO customer VALUES(
	null, 10, 'Alexander', 'Fennell', 'alexander@gmail.com', 10, 0, null, null);
INSERT INTO customer VALUES(
	null, 11, 'Melinda', 'Fernandez', 'Melinda@gmail.com', 11, 0, null, null);
INSERT INTO customer VALUES(
	null, 12, 'Field', 'Vicki', 'Field@gmail.com', 12, 0, null, null);
INSERT INTO customer VALUES(
	null, 13, 'Cindy', 'Fisher', 'cindy@gmail.com', 13, 0, null, null);
INSERT INTO customer VALUES(
	null, 14, 'Myrlte', 'Fleming', 'myrlte@gmail.com', 14, 0, null, null);
INSERT INTO customer VALUES(
	null, 15, 'Julia', 'Flores', 'julia@gmail.com', 15, 0, null, null);
INSERT INTO customer VALUES(
	null, 16, 'Crystal', 'Ford', 'crystal@gmail.com', 16, 0, null, null);
INSERT INTO customer VALUES(
	null, 17, 'Raul', 'Fortier', 'raul@gmail.com', 17, 0, null, null);
INSERT INTO customer VALUES(
	null, 18, 'Phyllis', 'Foster', 'phyllis@gmail.com', 18, 0, null, null);
INSERT INTO customer VALUES(
	null, 19, 'jack', 'Foust', 'jack@gmail.com', 19, 0, null, null);
INSERT INTO customer VALUES(
	null, 20, 'Fowler', 'Hooly', 'Fowler@gmail.com', 20, 0, null, null);
INSERT INTO customer VALUES(
	null, 21, 'Juan', 'Fraley', 'juan@gmail.com', 21, 0, null, null);
INSERT INTO customer VALUES(
	null, 22, 'Beth', 'Franklin', 'beth@gmail.com', 22, 0, null, null);
INSERT INTO customer VALUES(
	null, 23, 'Glenda', 'Frazier', 'glenda@gmail.com', 23, 0, null, null);
    
SELECT last_name, first_name, email
FROM customer
WHERE last_name BETWEEN 'Fa' AND 'Fr';   

SELECT last_name, first_name, email
FROM customer
WHERE last_name BETWEEN 'Fa' AND 'Frb';

-- Matching conditions
SELECT last_name, first_name
FROM customer
WHERE left(last_name, 1) = 'F';

-- Using wildcards
SELECT last_name, first_name
FROM customer
WHERE last_name LIKE '_A_t%S';

SELECT last_name, first_name
FROM customer
WHERE last_name LIKE 'F%' OR last_name LIKE 'Y%';

-- same previous

SELECT last_name, first_name
FROM customer
WHERE last_name REGEXP '^[Y]';

-- Null: that four-letter word
DESC customer;
SELECT email
FROM customer
WHERE create_date is NULL;

-- payment table and exercise
CREATE TABLE payment (
	payment_id smallint unsigned not null auto_increment,
    customer_id smallint unsigned not null,
    amount float(3) not null,
	payment_date date not null,
    CONSTRAINT payment_id_key PRIMARY KEY(payment_id),
	CONSTRAINT customer_id_payment_fk FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);


desc payment;
INSERT INTO payment VALUES (101, 4, 8.99, '2005-08-18');
INSERT INTO payment VALUES (null, 4, 1.99, '2005-08-19');
INSERT INTO payment VALUES (null, 4, 2.99, '2005-08-20');
INSERT INTO payment VALUES (null, 4, 6.99, '2005-08-21');
INSERT INTO payment VALUES (null, 4, 4.99, '2005-08-22');
INSERT INTO payment VALUES (null, 4, 2.99, '2005-08-23');
INSERT INTO payment VALUES (null, 4, 1.99, '2005-08-24');
INSERT INTO payment VALUES (null, 5, 0.99, '2005-08-29');
INSERT INTO payment VALUES (null, 5, 6.99, '2005-08-31');
INSERT INTO payment VALUES (null, 5, 1.99, '2005-08-31');
INSERT INTO payment VALUES (null, 5, 3.99, '2005-06-15');
INSERT INTO payment VALUES (null, 5, 2.99, '2005-06-16');
INSERT INTO payment VALUES (null, 6, 4.99, '2005-06-18');
INSERT INTO payment VALUES (null, 6, 7.99, '2005-06-18');
INSERT INTO payment VALUES (null, 6, 15.99, '2005-06-20');
INSERT INTO payment VALUES (null, 6, 11.99, '2005-07-08');
INSERT INTO payment VALUES (null, 6, 2.99, '2005-07-08');
INSERT INTO payment VALUES (null, 7, 4.99, '2005-07-09');
INSERT INTO payment VALUES (null, 7, 5.99, '2005-07-09');
INSERT INTO payment VALUES (null, 7, 1.99, '2005-07-09');

SELECT *FROM payment;
    
SELECT payment_id, customer_id
FROM payment
WHERE customer_id <> 5 AND NOT (amount > 6 OR date (payment_date) = '2005-06-19');   

SELECT payment_id, customer_id
FROM payment
WHERE customer_id <> 4 AND (amount > 5 OR date (payment_date) = '2005-08-18');
    
       
SELECT * FROM payment
WHERE amount IN (1.99, 7.99, 9.99);
   
SELECT amount FROM payment
WHERE amount > 1.98 AND amount < 7.98;
    
    