show databases;
use european_sales;    

SELECT first_name, last_name,
	CASE 
		WHEN active = 1 then 'ACTIVE'
		ELSE 'INACTIVE'
	END activity_type
FROM customer;

-- Searched case Expressions
SELECT category.name,
	CASE 
		WHEN category.name IN ('Children', 'Family', 'Sports', 'Animation')
			THEN 'All ages'
		WHEN category.name IN ('Horror')
			THEN 'Adult'
		WHEN category.name in ('Music', 'Games')
			THEN 'Teen'
		ELSE 'Other'
	END type
FROM category;

SELECT c.last_name, c.first_name,
	CASE 
		WHEN active = 1 THEN 0
	ELSE
		(SELECT SUM(p.amount) FROM payment p
        WHERE p.customer_id = c.customer_id)
	END num_payments
    FROM  customer c;


SELECT MONTHNAME(p.payment_date) payment_month,
SUM(p.amount)
FROM payment p
WHERE p.payment_date BETWEEN '2005-05-1' AND '2005-09-01'
GROUP BY MONTHNAME(p.payment_date);

-- checking for Existence
SELECT a.first_name, a.last_name,
	CASE 
		WHEN EXISTS(SELECT 1 FROM film f
					WHERE f.film_id = a.film_id
                    AND rating > 6) THEN 'Y'
		ELSE 'N'
	END actor_rating
FROM actor a;

SELECT * FROM  actor;

desc actor;
desc film;

-- Division - by - Zero Errors
SELECT c.first_name, c.last_name, sum(p.amount) tot_payments, count(*) num_payments, 
sum(p.amount) /
	CASE WHEN count(p.amount) = 0 then 1
		ELSE count(p.amount)
    END avg_payment
FROM customer c
LEFT OUTER JOIN payment p
ON c.customer_id = p.customer_id
AND c.customer_id BETWEEN 4 AND 10
GROUP BY c.first_name, c.last_name;

-- Test My knowledge
-- exercise 11-1
SELECT * FROM language;
SELECT name,
	CASE 
		WHEN name IN ('English', 'Italian', 'French', 'German') THEN 'Latin1'
		WHEN name IN ('Japanese', 'Mandarin') THEN 'uft8'
	ELSE 'Unknown'
    END language
FROM language;

-- Exercise 2
CREATE TABLE rating (
rating char(5) not null, 
count smallint unsigned not null);

-- matrix
SELECT CASE WHEN r.rating = 'PG' then r.count ELSE 0 END pg,
CASE WHEN r.rating = 'G' then r.count ELSE 0 END g,
CASE WHEN r.rating = 'NC-17' then r.count ELSE 0 END nc_17,
CASE WHEN r.rating = 'PG-13' then r.count ELSE 0 END pg_13,
CASE WHEN r.rating = 'R' then r.count ELSE 0 END r
FROM rating r;
