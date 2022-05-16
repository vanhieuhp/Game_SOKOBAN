show databases;
use european_sales;
SELECT customer_id FROM rental;

SELECT customer_id
FROM rental
GROUP BY customer_id;

show tables;
desc rental;
desc film;

SELECT first_name, count(*)
FROM customer
GROUP BY first_name
ORDER BY 2 desc;


SELECT first_name, count(*)
FROM customer
GROUP BY first_name
HAVING count(*) >= 2;

desc payment;
SELECT amount FROM payment;
SELECT count FROM film;
SELECT MAX(count) max_count,
		MIN(count) min_count,
        AVG(count) avg_count,
        SUM(count) sum_count,
        COUNT(count) num_payments
FROM film;
	
SELECT COUNT(last_name) num_rows,
	COUNT(DISTINCT last_name) num_last_names
    FROM customer;
    
CREATE TABLE number_tbl(val SMALLINT);
INSERT INTO number_tbl VALUES (1);
INSERT INTO number_tbl VALUES (3);
INSERT INTO number_tbl VALUES (5);
SELECT COUNT(*) num_row,
		COUNT(val) num_vals,
        MAX(val) max_val,
        SUM(val) total,
        AVG(val) avg_vals
FROM number_tbl;

INSERT INTO number_tbl VALUES (null);

show tables;
SELECT * FROM actor;
SELECT film_id FROM film;
desc film;
ALTER TABLE actor
ADD CONSTRAINT film_id_actor_fk FOREIGN KEY(film_id) REFERENCES film(film_id);


UPDATE actor SET film_id = '1' WHERE actor_id = '8';
UPDATE actor SET film_id = '11' WHERE actor_id = '8';
UPDATE actor SET film_id = '13' WHERE actor_id = '8';
UPDATE actor SET film_id = '14' WHERE actor_id = '8';
UPDATE actor SET film_id = '12' WHERE actor_id = '7';
UPDATE actor SET film_id = '7' WHERE actor_id = '7';
UPDATE actor SET film_id = '3' WHERE actor_id = '7';
UPDATE actor SET film_id = '2' WHERE actor_id = '8';
UPDATE actor SET film_id = '10' WHERE actor_id = '7';
UPDATE actor SET film_id = '4' WHERE actor_id = '8';
UPDATE actor SET film_id = '5' WHERE actor_id = '8';
UPDATE actor SET film_id = '6' WHERE actor_id = '8';
UPDATE actor SET film_id = '8' WHERE actor_id = '8';
UPDATE actor SET film_id = '9' WHERE actor_id = '7';
UPDATE actor SET film_id = '15' WHERE actor_id = '7';


-- group filter conditions
SELECT fa.actor_id, f.rating, count(*)
FROM actor fa
INNER JOIN film f
ON fa.film_id = f.film_id
WHERE f.rating IN ('7', '8')
GROUP BY fa.actor_id, f.rating
HAVING count(*) > 0;

SELECT * FROM payment;
SELECT c.customer_id, count(*), SUM(p.amount)
FROM customer c
INNER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id;


SELECT c.customer_id, count(*), SUM(p.amount)
FROM customer c
INNER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING SUM(p.amount) > 40;

