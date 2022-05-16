use european_sales;
-- May consist of:
-- A single row with a single column
-- Multiple rows with a single column
-- Multiple rows having multiple columns

-- SIMPLE example
SELECT MAX(customer_id) FROM customer;
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id = (SELECT MAX(customer_id) FROM customer);

-- subquery types
SELECT city_id, city
FROM city
WHERE country_id IN 
(	SELECT country_id
	FROM country
	WHERE country IN ('Canada', 'Mexico'));
    
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN
(SELECT customer_id
FROM payment
WHERE amount = 0);

-- same result as the privious query
SELECT first_name, last_name
FROM customer
WHERE customer_id <> ALL
(SELECT customer_id
FROM payment
WHERE amount = 0);

--
SELECT * FROM actor;
SELECT actor_id, film_id
FROM actor
WHERE (actor_id, film_id) IN 
(SELECT a.actor_id, a.film_id
FROM actor a
	CROSS JOIN film f
WHERE a.last_name = 'Jackman'
AND f.rating > 0);
    
-- Correlated Subqueries: Truy vấn con tương quan
SELECT c.first_name, c.last_name
FROM customer c
WHERE 20 > 
(SELECT count(*) FROM rental r
WHERE c.customer_id = r.customer_id);

SELECT c.first_name, c.last_name
FROM customer c
WHERE 
(SELECT sum(p.amount) FROM payment p
WHERE p.customer_id = c.customer_id)
BETWEEN 15 AND 20;

SELECT sum(amount), customer_id
FROM payment
GROUP BY customer_id;
    
-- Subqueries as Data Sources
SELECT c.first_name, c.last_name, pymnt.num_rentals, pymnt.tot_rentals
FROM customer c
INNER JOIN 
(SELECT customer_id, count(*) num_rentals, SUM(amount) tot_rentals
FROM payment
GROUP BY customer_id) pymnt
ON c.customer_id =  pymnt.customer_id;

SELECT customer_id, SUM(amount) num_rentals, COUNT(*) tot_rentals
FROM payment
GROUP BY customer_id;

-- Data fabrication

SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
UNION ALL 
SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
UNION ALL
SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit;

SELECT pymnt_grps.name, count(*) num_customers
FROM 
(SELECT customer_id, count(*) num_rentals, sum(amount) tot_payments
FROM payment
GROUP BY customer_id
) pymnt
INNER JOIN 
(SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
UNION ALL 
SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
UNION ALL
SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit
) pymnt_grps
ON pymnt.tot_payments
BETWEEN pymnt_grps.low_limit AND pymnt_grps.high_limit
GROUP BY pymnt_grps.name;

-- task - oriented subqueries
SELECT c.first_name, c.last_name, a.address, sum(p.amount) tot_payments, count(*) tot_rentals
FROM payment p
INNER JOIN customer c
ON p.customer_id = c.customer_id
INNER JOIN address a
ON c.address_id_key = a.address_id
GROUP BY c.first_name, c.last_name, a.address;

SELECT c.first_name, c.last_name, a.address, pymnt.tot_payments, pymnt.tot_rentals
FROM 
(SELECT customer_id, count(*) tot_rentals, SUM(amount) tot_payments
FROM payment
GROUP BY customer_id
) pymnt
INNER JOIN customer c
ON c.customer_id = pymnt.customer_id
INNER JOIN address a
ON c.address_id_key = a.address_id;


-- common table expressions
desc actor; desc film;
WITH actors_s AS
(SELECT first_name, last_name, film_id
FROM actor
WHERE last_name LIKE 'J%'
),
actors_s_ps AS
(SELECT s.first_name, s.last_name, f.film_id, f.title
FROM actors_s s
INNER JOIN film f
ON s.film_id = f.film_id
WHERE f.rating > 0
)
select test.first_name, test.last_name, test.title
FROM actors_s_ps test
GROUP BY test.first_name,  test.last_name
ORDER BY 1;

-- Subqueries as Expression Generators : tạo biểu thức

-- test my knowledge
SELECT title FROM film;

SELECT * FROM film;
SELECT f.title, f.film_id, f.rental_duration, tbl.level
FROM film f
INNER JOIN
(SELECT 'Hollywood Star' level, 15 min_time, 99999 max_time
UNION ALL 
SELECT 'Prolific Actor' level, 20 min_time,99999 max_time
UNION ALL
SELECT 'Newcomer' level, 1 min_time, 19 max_time
) tbl
ON f.rental_duration
BETWEEN tbl.min_time AND tbl.max_time
GROUP By f.film_id, tbl.level;




















    
    
    