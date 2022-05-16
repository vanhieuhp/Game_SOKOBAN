create database european_sales character set latin1;
-- defined store up to 2GB of data // varchar(max);
USE european_sales;
CREATE TABLE person(
	person_id SMALLINT UNSIGNED,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    eye_color ENUM('BR', 'BL', 'GR'), 
    birth_date DATE,
    street VARCHAR(20),
    city VARCHAR(20),
    state VARCHAR(20),
    country VARCHAR(20),
    postal_code VARCHAR(20),
    CONSTRAINT pk_person PRIMARY KEY (person_id)
);
desc person;

CREATE TABLE favorite_food
(	person_id SMALLINT UNSIGNED,
	food VARCHAR(20), 
    CONSTRAINT pk_favorite_food PRIMARY KEY (person_id, food),
    CONSTRAINT fk_fav_food_person_id FOREIGN KEY(person_id)
    REFERENCES person(person_id)
);
desc favorite_food;

set foreign_key_checks = 0;
ALTER TABLE person
	MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;
set foreign_key_checks = 1;

INSERT INTO person
	(person_id, first_name, last_name, eye_color, birth_date)
	VALUES (null, 'William', 'Turner', 'BR', '1972-05-27');

SELECT person_id, first_name, last_name, eye_color, birth_date
FROM person;

INSERT INTO favorite_food(person_id, food)
VALUES (1, 'pizza');
INSERT INTO favorite_food(person_id, food)
VALUES (1, 'nachos');
INSERT INTO favorite_food(person_id, food)
VALUES (1, 'cookies');

SELECT food FROM favorite_food WHERE person_id = 1 ORDER BY food;

INSERT INTO person
	(person_id, first_name, last_name, eye_color, birth_date, 
    street, city, state, country, postal_code)
    VALUES (null, 'Susan', 'Smith', 'BL', '1975-11-02', 
    '23 Maple St', 'Arlington', 'VA', 'USA', '20220');

-- UPDATE DATA
UPDATE person
SET street = '1225 Tremont St.',
	city = 'Boston',
    country = 'USA',
    postal_code = '02138'
WHERE person_id = 1;

-- DELETE 
DELETE FROM person
WHERE person_id = 2;

CREATE TABLE customer(
	customer_id SMALLINT UNSIGNED NOT NULL ,
    CONSTRAINT pre_customer_id_key PRIMARY KEY(customer_id),
    store_id	TINYINT(3) UNSIGNED NOT NULL,
    first_name	VARCHAR(45) NOT NULL,
	last_name 	VARCHAR(45) NOT NULL, 
    email		VARCHAR(50),
    address_id	SMALLINT(5) UNSIGNED NOT NULL,
    active		TINYINT(1) NOT NULL,
    create_date	DATETIME  NULL,
    last_update	TIMESTAMP null);
    
INSERT INTO customer VALUES (
	NULL, 1, 'sandra', 'Martin', 'sandra@gmail.com',
    1, 0, null, null);
INSERT INTO customer VALUES (
	NULL, 2, 'Judith', 'Cox', 'judith@gmail.com',
    2, 0, null, null);
INSERT INTO customer VALUES (
	NULL, 3, 'Sheila', 'Wells', 'sheila@gmail.com',
    3, 0, null, null);
INSERT INTO customer VALUES (
	NULL, 4, 'Erica', 'Matthews', 'erica@gmail.com',
    4, 0, null, null);
INSERT INTO customer VALUES (
	NULL, 5, 'Heidi', 'Larson', 'heidi@gmail.com',
    5, 0, null, null);
INSERT INTO customer VALUES (
	NULL, 6, 'Penny', 'Neal', 'penny@gmail.com',
    6, 0, null, null);
INSERT INTO customer VALUES (
	NULL, 7, 'Kenneth', 'Gooden', 'kenneth@gmail.com',
    7, 0, null, null);
INSERT INTO customer VALUES (
	NULL, 8, 'Harry', 'Martin', 'harry@gmail.com',
    8, 0, null, null);
    
ALTER TABLE customer
	MODIFY customer_id SMALLINT UNSIGNED AUTO_INCREMENT;

select * from customer;
drop table customer;
desc customer;

CREATE TABLE language(
	language_id SMALLINT UNSIGNED, 
	name 		VARCHAR(20),
	last_update DATE,
    CONSTRAINT 	key_language_id PRIMARY KEY (language_id)
);
desc language;


alter table language 
	modify language_id smallint unsigned auto_increment;

select language_id, name from language;

INSERT INTO language (language_id, name)
	values 	(null, 'English');
INSERT INTO language (language_id, name)
	values 	(null, 'Italian');
INSERT INTO language (language_id, name)
	values 	(null, 'Japanese');
INSERT INTO language (language_id, name)
	values 	(null, 'Mandarin');
INSERT INTO language (language_id, name)
	values 	(null, 'French');
INSERT INTO language (language_id, name)
	values 	(null, 'German');
    
SELECT language_id,
	'COMMON' language_usage,
    language_id * 3.1415927 lang_pi_value,
    upper(name) language_name
    FROM language;

SELECT version(), user(), database();

-- Derived (subquenry - generated ) tables
SELECT concat(cust.last_name, ', ', cust.first_name) full_name
	FROM 
    (SELECT first_name, last_name, email
    FROM customer
    WHERE  first_name = 'Judith') cust;
    
-- Temporary tables
CREATE TEMPORARY TABLE actors_j
	(actor_id smallint(5),
    first_name varchar(45),
    last_name varchar(45)
    );
    
CREATE TABLE actor (
	actor_id smallint(5),
    first_name varchar(40),
    last_name varchar(45),
    CONSTRAINT actor_id_key PRIMARY KEY(actor_id)
    );

INSERT INTO actor VALUES(1, 'Warren', 'Jackman');
INSERT INTO actor VALUES(2, 'Jane', 'Johansson');
INSERT INTO actor VALUES(3, 'Mathhew', 'Jackman');
INSERT INTO actor VALUES(4, 'Ray', 'Jackman');
INSERT INTO actor VALUES(5, 'Elon', 'Musk');
INSERT INTO actor VALUES(6, 'Albert', 'Johansson');
INSERT INTO actor VALUES(7, 'Woody', 'Jocovich');
INSERT INTO actor VALUES(8, 'Kirk', 'Jadon');
INSERT INTO actor VALUES(9, 'Bruno', 'Fesnaldes');
INSERT INTO actor VALUES(10, 'Harry', 'Macggui');

INSERT INTO actors_j
SELECT	actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE 'J%';

SELECT  * FROM actors_j;

CREATE VIEW cust_cs AS
SELECT customer_id, first_name, last_name, active
FROM customer;

SELECT first_name, last_name
FROM cust_cs
WHERE active = 0;

-- Table links
SELECT customer.firstname, customer.lastname, time(rental.rental_date) rental_time
FROM customer
INNER JOIN rental
ON customer.customer_id = rental.customer_id
WHERE date(rental.rental_data) = '2005-06-14';

-- Defining Table Aliases

CREATE TABLE film(
	film_id smallint unsigned not null auto_increment,
    title varchar(100) not null, 
    rating tinyint(2) not null,
    rental_duration tinyint(3),
    count tinyint(3),
    CONSTRAINT film_id_key PRIMARY KEY(film_id)
    );
drop table film;
INSERT INTO film VALUES (
	null, 'Blanket beverly', 4, 12, 7);
INSERT INTO film VALUES (
	null, 'Borrowers Bedazzled', 8, 0, 7);
INSERT INTO film VALUES (
	null, 'Bride Intrigue', 8, 5, 7);
INSERT INTO film VALUES (
	null, 'Citizen Shrek', 7, 12, 11);
INSERT INTO film VALUES (
	null, 'Coldblooded  Darling', 9, 22, 22);
INSERT INTO film VALUES (
	null, 'Control Anthem', 6, 0, 9);
INSERT INTO film VALUES (
	null, 'Cruelty Unforgiven', 6, 2, 9);
INSERT INTO film VALUES (
	null, 'Darn Forrester', 9, 4, 6);
INSERT INTO film VALUES (
	null, 'Desperate Trainspotting', 7, 7, 6);
INSERT INTO film VALUES (
	null, 'Empire Malkovich', 7, 22, 12);
INSERT INTO film VALUES (
	null, 'Dracula Crystal', 5, 0, 2);
INSERT INTO film VALUES (
	null, 'Graduate Lord', 5, 3, 21);
INSERT INTO film VALUES (
	null, 'Married', 4, 12, 15);
INSERT INTO film VALUES (
	null, 'Muscle Bright', 9, 3, 8);
INSERT INTO film VALUES (
	null, 'Spiking Element', 8, 1, 3);

SELECT title, rating, rental_duration 
FROM film
WHERE rating = 'G' OR rental_duration >= 7;

SHOW TABLES;
CREATE TABLE rental (
	customer_id smallint unsigned not null,
    rental_time_day tinyint(3),
    CONSTRAINT rental_fk_key FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
    );
drop table rental;
INSERT INTO rental VALUES (1, 56);
INSERT INTO rental VALUES (2, 36);
INSERT INTO rental VALUES (3, 33);
INSERT INTO rental VALUES (4, 3);
INSERT INTO rental VALUES (5, 1);
INSERT INTO rental VALUES (6, 8);
INSERT INTO rental VALUES (7, 10);
INSERT INTO rental VALUES (8, 11);

SELECT * FROM rental;
desc rental;

SELECT c.first_name, c.last_name, r.rental_time_day
    FROM customer c
    INNER JOIN rental r
    ON c.customer_id = r.customer_id
    WHERE  r.rental_time_day > 3
    ORDER BY c.last_name;

desc customer;
SELECT customer_id, first_name, last_name 
FROM customer
WHERE last_name = 'Martin' or last_name = 'Wells';

SELECT c.email, r.rental_time_day
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE r.rental_time_day > 0
ORDER BY 2 desc;













































