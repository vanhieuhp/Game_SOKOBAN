-- Querying Multiple Tables
use european_sales;

desc customer;

CREATE TABLE address (
	address_id smallint(5) unsigned not null auto_increment,
    address varchar(50) not null,
    CONSTRAINT address_id_key PRIMARY KEY(address_id)
    );

ALTER TABLE address 
add test_id smallint(5) not null;
INSERT INTO address VALUES (1, '47 MySakila Drive');        
INSERT INTO address VALUES (null, '12 NewYork City');    
INSERT INTO address VALUES (null, '262 Le Trong Tan');    
INSERT INTO address VALUES (null, '73 Ngo Quyen Hai Phong');    
INSERT INTO address VALUES (null, '25 Tran Quoc Toan');        
INSERT INTO address VALUES (null, '67 DongYang Bac King');    
INSERT INTO address VALUES (null, '2005 Arsenal London');    
INSERT INTO address VALUES (null, '23 Barcenona');    

-- at least use
SELECT c.first_name, c.last_name, a.address
FROM customer c JOIN address a;

SELECT * FROM CUSTOMER;
desc customer;

ALTER TABLE customer 
ADD CONSTRAINT fk_key_address FOREIGN KEY(address_id_key) REFERENCES address(address_id);

UPDATE customer SET address_id_key = 1 WHERE customer_id = 1;
UPDATE customer SET address_id_key = 2 WHERE customer_id = 2;
UPDATE customer SET address_id_key = 3 WHERE customer_id = 3;
UPDATE customer SET address_id_key = 1 WHERE customer_id = 4;
UPDATE customer SET address_id_key = 2 WHERE customer_id = 5;
UPDATE customer SET address_id_key = 2 WHERE customer_id = 6;
UPDATE customer SET address_id_key = 4 WHERE customer_id = 7;
UPDATE customer SET address_id_key = 4 WHERE customer_id = 8;
UPDATE customer SET address_id_key = 3 WHERE customer_id = 9;
UPDATE customer SET address_id_key = 3 WHERE customer_id = 10;

SELECT c.first_name, c.last_name, a.address
FROM customer c JOIN address a
ON c.address_id_key = a.address_id;

-- same with the previous query
SELECT c.first_name, c.last_name, a.address
FROM customer c JOIN address a
USING (address_id);



-- The ANSI JOIn SYntax
SELECT c.first_name, c.last_name, a.address
FROM customer c, address a
WHERE c.address_id =  a.address_id;


desc rental;
SELECT c.first_name, c.last_name, r.rental_time_day
FROM customer c INNER JOIN address a ON c.address_id_key = a.address_id
INNER JOIN rental r ON c.customer_id = r.customer_id;


SELECT c.first_name, c.last_name, r.rental_time_day, a.address
FROM customer c INNER JOIN address a ON c.address_id_key = a.address_id
INNER JOIN rental r ON c.customer_id = r.customer_id;

