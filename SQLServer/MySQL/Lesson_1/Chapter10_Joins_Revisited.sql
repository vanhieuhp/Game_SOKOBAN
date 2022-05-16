show databases;
use european_sales;

-- this examples just are true in the case that you have a table inventory. 

SELECT f.film_id, f.title, count(i.inventory_id) num_copies
FROM film f
LEFT OUTER JOIN inventory i
ON f.film_id = i.film_id
GROUP BY f.film_id, f.title;

SELECT * FROM customer;
SELECT * FROM film;
SELECT * FROM actor;
SELECT * FROM rental;
SELECT * FROM payment;

SELECT  p.payment_id, c.customer_id
FROM customer c 
INNER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY p.payment_id;

SELECT  p.payment_id, c.customer_id
FROM customer c 
LEFT OUTER JOIN payment p
ON c.customer_id = p.customer_id 
WHERE c.customer_id BETWEEN 5 AND 10
GROUP BY p.payment_id;


SELECT  p.payment_id, c.customer_id
FROM payment p
RIGHT OUTER JOIN customer c
ON c.customer_id = p.customer_id 
WHERE c.customer_id BETWEEN 5 AND 10
GROUP BY p.payment_id;

desc rental;
SELECT * FROM rental;
INSERT INTO rental VALUES (9, 12);
INSERT INTO rental VALUES (9, 11);
INSERT INTO rental VALUES (10, 3);
INSERT INTO rental VALUES (11, 4);
INSERT INTO rental VALUES (12, 5);
INSERT INTO rental VALUES (12, 6);
INSERT INTO rental VALUES (6, 12);
SELECT  p.payment_id, r.rental_time_day
FROM customer c 
LEFT OUTER JOIN payment p
ON c.customer_id = p.customer_id 
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE c.customer_id BETWEEN 5 AND 10
GROUP BY p.payment_id;

-- CROSS JOIN
show tables;
select * from language;
SELECT c.last_name, l.name
FROM customer c
CROSS JOIN language l;

-- create temporary table which contains number from 0 to 399;
SELECT ones.num + tens.num + hundreds.num
FROM
(SELECT 0 num UNION ALL
SELECT 1 NUM UNION ALL
SELECT 2 NUM UNION ALL
SELECT 3 NUM UNION ALL
SELECT 4 NUM UNION ALL
SELECT 5 NUM UNION ALL
SELECT 6 NUM UNION ALL
SELECT 7 NUM UNION ALL
SELECT 8 NUM UNION ALL
SELECT 9 NUM ) ones
CROSS JOIN 
(SELECT 0 num UNION ALL
SELECT 10 NUM UNION ALL
SELECT 20 NUM UNION ALL
SELECT 30 NUM UNION ALL
SELECT 40 NUM UNION ALL
SELECT 50 NUM UNION ALL
SELECT 60 NUM UNION ALL
SELECT 70 NUM UNION ALL
SELECT 80 NUM UNION ALL
SELECT 90 NUM ) tens
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 100 num UNION ALL
SELECT 200 num UNION ALL
SELECT 300 NUM) hundreds
ORDER BY ones.num + tens.num + hundreds.num;

-- Advanced example with cross join 

SELECT DATE_ADD('2022-01-01', INTERVAL (1) DAY) DT;

SELECT DATE_ADD('2022-01-01',
INTERVAL (ones.num + tens.num + hundreds.num) DAY) dt
FROM 
(SELECT 0 num UNION ALL
SELECT 1 NUM UNION ALL
SELECT 2 NUM UNION ALL
SELECT 3 NUM UNION ALL
SELECT 4 NUM UNION ALL
SELECT 5 NUM UNION ALL
SELECT 6 NUM UNION ALL
SELECT 7 NUM UNION ALL
SELECT 8 NUM UNION ALL
SELECT 9 NUM ) ones
CROSS JOIN 
(SELECT 0 num UNION ALL
SELECT 10 NUM UNION ALL
SELECT 20 NUM UNION ALL
SELECT 30 NUM UNION ALL
SELECT 40 NUM UNION ALL
SELECT 50 NUM UNION ALL
SELECT 60 NUM UNION ALL
SELECT 70 NUM UNION ALL
SELECT 80 NUM UNION ALL
SELECT 90 NUM ) tens
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 100 num UNION ALL
SELECT 200 num UNION ALL
SELECT 300 NUM) hundreds
WHERE DATE_ADD('2022-01-01',
INTERVAL (ones.num + tens.num + hundreds.num) DAY) < '2023-01-01'
ORDER BY 1;

-- Natural JOINS
SELECT c.first_name, c.last_name,(r.rental_time_day)
FROM customer c
NATURAL JOIN rental r;

SELECT * FROM rental;

-- Exercise CHAPTER 10
SELECT p.payment_id, c.customer_id, c.first_name, p.amount
FROM customer c 
LEFT OUTER JOIN payment p
ON c.customer_id = p.customer_id
WHERE c.customer_id 
BETWEEN 4 AND 10
GROUP BY p.payment_id, c.customer_id;
 
 -- display from 1 to 100
SELECT ones.num + tens.num + 1
FROM 
(SELECT 0 num UNION ALL
SELECT 1 num UNION ALL
SELECT 2 num UNION ALL
SELECT 3 num UNION ALL
SELECT 4 num UNION ALL
SELECT 5 num UNION ALL
SELECT 6 num UNION ALL
SELECT 7 num UNION ALL
SELECT 8 num UNION ALL
SELECT 9 num) ones
CROSS JOIN 
(SELECT 0 num UNION ALL
SELECT 10 num UNION ALL
SELECT 20 num UNION ALL
SELECT 30 num UNION ALL
SELECT 40 num UNION ALL
SELECT 50 num UNION ALL
SELECT 60 num UNION ALL
SELECT 70 num UNION ALL
SELECT 80 num UNION ALL
SELECT 90 num) tens
ORDER BY ones.num + tens.num + 1;