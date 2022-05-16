show databases;
use european_sales;

CREATE VIEW customer_vw (customer_id, first_name, last_name, email)
AS 
SELECT customer_id, first_name, last_name, 
concat(substr(email,1,2), '*****', substr(email,-4)) email
FROM customer;

SELECT first_name, last_name, email FROM customer_vw;
desc customer_vw;
-- you are free to use any clauses of the select
SELECT first_name, count(*), min(last_name), max(last_name)
FROM customer_vw
WHERE first_name LIKE 'F%'
HAVING count(*) > 0
ORDER BY 1;

SELECT cv.first_name, cv.last_name, p.amount
FROM customer_vw cv
INNER JOIN payment p
ON cv.customer_id = p.customer_id
WHERE p.amount >= 11
ORDER BY 3;

-- Why use views? Because
-- Date Security
-- Data Aggregation
desc payment;
desc customer;
desc film;


CREATE VIEW film_category AS
SELECT c.name category, f.title
FROM film f
	INNER JOIN category c 
    ON f.category_id = c.category_id
GROUP BY c.name
ORDER BY 1;

SELECT * FROM film_category;

-- Hiding Complexity
-- Join Partitioned Data
-- Updatable Views

-- Update Simple Views
UPDATE customer_vw
SET last_name = 'Smith_Allen'
WHERE customer_id = 1;

SELECT first_name, last_name, email
FROM customer
WHERE customer_id = 1;


desc category;
desc actor;
desc film;
-- Exercise
CREATE VIEW film_category_actor AS
SELECT f.title title, c.name category_name, a.first_name first_name, a.last_name last_name
FROM actor a
INNER JOIN film f 
ON a.film_id = f.film_id
INNER JOIN category c 
ON f.category_id = c.category_id
GROUP BY f.title;

SELECT title, category_name, first_name, last_name
FROM film_category_actor ;
