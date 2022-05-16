use european_sales;

-- Working with Sets

SELECT 1 num, 'abc' str
UNION 
SELECT 9 num, 'xyz' str;

-- combine 2 tables and can contain duplicate
SELECT 'CUST' typ, c.first_name, c.last_name
FROM customer c
UNION ALL
SELECT 'ACTR' typ, a.first_name, a.last_name
FROM actor a;

-- don't contain duplicate
SELECT 'CUST' typ, c.first_name, c.last_name
FROM customer c
UNION 
SELECT 'ACTR' typ, a.first_name, a.last_name
FROM actor a;

-- use order by to sort
SELECT a.first_name fname, a.last_name lname
FROM actor a
WHERE a.first_name LIKE 'J%'
UNION 
SELECT C.first_name, c.last_name
FROM customer c
WHERE C.first_name LIKE 'J%'
ORDER BY fname;

SELECT a.first_name fname, a.last_name lname
FROM actor a
WHERE a.last_name LIKE 'J%'
UNION
SELECT c.first_name, c.last_name
FROM actor c
WHERE c.last_name LIKE 'J%'
ORDER BY fname













