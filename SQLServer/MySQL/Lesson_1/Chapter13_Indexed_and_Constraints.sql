show databases;
use european_sales;

ALTER TABLE customer
ADD INDEX idx_email (email);

ALTER TABLE customer
DROP INDEX idx_email;
SELECT DISTINCT email FROM customer;
SELECT  email FROM customer;

SHOW INDEX FROM customer;

-- Unique indexes;
ALTER TABLE customer
ADD UNIQUE idx_email(email);

-- Multicolumn indexes
ALTER TABLE customer
ADD INDEX idx_full_name (last_name, first_name);

-- Types of Indexes
-- B-tree indexes
-- Bitmap indexes: CREATE BITMAP INDEX idx_active ON customer (active);
-- Text Indexes

-- How Indexes Are Used
-- The downside of Indexes
