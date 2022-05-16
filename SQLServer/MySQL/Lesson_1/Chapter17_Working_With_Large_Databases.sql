use european_sales;
-- Working With Large Databases

-- Partitioning
CREATE TABLE sales
(sale_id INT NOT NULL,
cust_id INT NOT NULL,
store_id INT NOT NULL,
sale_date DATE NOT NULL,
amount DECIMAL(9,2)
)
PARTITION BY RANGE(yearweek(sale_date)) (
PARTITION s1 VALUES LESS THAN (202002),
PARTITION s2 VALUES LESS THAN (202003),
PARTITION s3 VALUES LESS THAN (202004),
PARTITION s4 VALUES LESS THAN (202005),
PARTITION s5 VALUES LESS THAN (202006),
PARTITION s999 VALUES LESS THAN (MAXVALUE)
);

-- use metadata to see my partitioned tables
SELECT partition_name, partition_method, partition_expression
FROM information_schema.partitions
WHERE table_name = 'sales'
ORDER BY partition_ordinal_position;

-- alter table partition
ALTER TABLE sales REORGANIZE PARTITION s999 INTO 
(PARTITION s6 VALUES LESS THAN (202007),
PARTITION S7 VALUES LESS THAN (202008),
PARTITION S999 VALUES LESS THAN (MAXVALUE)
);

SELECT * FROM sales;
INSERT INTO sales VALUES
(5, 5, 1, '2020-01-9', 3242.15);

SELECT concat('# of rows in S1 = ', count(*)) partition_rowcount
FROM sales PARTITION (s1) UNION ALL
SELECT concat('# of rows in S2 = ', count(*)) partition_rowcount
FROM sales PARTITION (s2) UNION ALL
SELECT concat('# of rows in S3 = ', count(*)) partition_rowcount
FROM sales PARTITION (s3) UNION ALL
SELECT concat('# of rows in S4 = ', count(*)) partition_rowcount
FROM sales PARTITION (s4) UNION ALL
SELECT concat('# of rows in S5 = ', count(*)) partition_rowcount
FROM sales PARTITION (s5) UNION ALL
SELECT concat('# of rows in S6 = ', count(*)) partition_rowcount
FROM sales PARTITION (s6) UNION ALL
SELECT concat('# of rows in S7 = ', count(*)) partition_rowcount
FROM sales PARTITION (s7) UNION ALL
SELECT concat('# of rows in S999 = ', count(*)) partition_rowcount
FROM sales PARTITION (s999);

-- List paritioning
SELECT * FROM sales;

CREATE TABLE sales1(
sale_id int not null,
cust_id int not null,
store_id int not null,
sale_date date not null,
geo_region_cd varchar(6) not null,
amount DECIMAL(9,2)
)
PARTITION BY LIST COLUMNS (geo_region_cd)
( PARTITION NORTHAMERICA VALUES IN ('US_NE', 'US_SE', 'US_MW', 
									'US_NW', 'US_SW', 'CAN', 'MEX'),
PARTITION EUROPE VALUES IN ('EUR_E', 'EUR_W'),
PARTITION ASIA VALUES IN ('CHN', 'JPN', 'IND')
);

INSERT INTO sales1
VALUES (1, 1, 1, '2020-01-18', 'US_NE', 2765.15),
(2, 3, 4, '2020-02-07', 'CAN', 5233.23),
(3, 6, 7, '2020-03-11', 'KOR', 4267.12);


-- ADD KOR into partition
ALTER TABLE sales1
REORGANIZE PARTITION ASIA INTO
(PARTITION ASIA VALUES IN ('CHN', 'JPN', 'IND', 'KOR'));

SELECT partition_name, partition_expression, partition_description
FROM information_schema.partitions
WHERE table_name = 'sales1'
ORDER BY partition_ordinal_position;

-- Hash Partitioning

CREATE TABLE sales_hash(
sale_id int not null,
cust_id int not null,
store_id int not null,
sale_date date not null,
amount DECIMAL(9,2)
)
PARTITION BY HASH (cust_id) PARTITIONS 4
( PARTITION H1,
PARTITION H2,
PARTITION H3,
PARTITION H4
);

INSERT INTO sales_hash VALUES
(1, 1, 1, '2020-01-18', 1.1), (2, 3, 4, '2020-02-07', 1.2), 
(3, 17, 5, '2020-01-19', 1.3), (4, 23, 2, '2020-02-08', 1.4), 
(5, 56, 1, '2020-01-20', 1.6), (6, 77, 5, '2020-02-09', 1.7), 
(7, 122, 4, '2020-01-21', 1.8), (8, 153, 1, '2020-02-10', 1.9), 
(9, 179, 5, '2020-01-22', 2.0), (10, 244, 2, '2020-02-11', 2.1), 
(11, 263, 1, '2020-01-23', 2.2), (12, 312, 4, '2020-02-12', 2.3), 
(13, 346, 2, '2020-01-24', 2.4), (14, 389, 3, '2020-02-13', 2.5), 
(15, 472, 1, '2020-01-25', 2.6), (16, 502, 1, '2020-02-14', 2.7);

SELECT concat('# of rows in H1 = ', count(*)) partition_rowcount
FROM sales_hash PARTITION (H1) UNION ALL
SELECT concat('# of rows in H2 = ', count(*)) partition_rowcount
FROM sales_hash PARTITION (H2) UNION ALL
SELECT concat('# of rows in H3 = ', count(*)) partition_rowcount
FROM sales_hash PARTITION (H3) UNION ALL
SELECT concat('# of rows in H4 = ', count(*)) partition_rowcount
FROM sales_hash PARTITION (H4);


-- Composite partitioning 

CREATE TABLE sales_composite(
sale_id int not null,
cust_id int not null,
store_id int not null,
sale_date date not null,
amount DECIMAL(9,2)
)
PARTITION BY RANGE (yearweek(sale_date))
SUBPARTITION BY HASH(cust_id)
	(PARTITION s1 VALUES LESS THAN (202002)
		(SUBPARTITION s1_h1,
        SUBPARTITION s1_h2,
        SUBPARTITION s1_h3,
        SUBPARTITION s1_h4),
	PARTITION s2 VALUES LESS THAN (202003)
		(SUBPARTITION s2_h1,
        SUBPARTITION s2_h2,
        SUBPARTITION s2_h3,
        SUBPARTITION s2_h4),
	PARTITION s3 VALUES LESS THAN (202004)
		(SUBPARTITION s3_h1,
        SUBPARTITION s3_h2,
        SUBPARTITION s3_h3,
        SUBPARTITION s3_h4),
	PARTITION s4 VALUES LESS THAN (202005)
		(SUBPARTITION s4_h1,
        SUBPARTITION s4_h2,
        SUBPARTITION s4_h3,
        SUBPARTITION s4_h4),
	pARTITION s5 VALUES LESS THAN (202006)
		(SUBPARTITION s5_h1,
        SUBPARTITION s5_h2,
        SUBPARTITION s5_h3,
        SUBPARTITION s5_h4),
	PARTITION s999 VALUES LESS THAN (MAXVALUE)
		(SUBPARTITION s999_h1,
        SUBPARTITION s999_h2,
        SUBPARTITION s999_h3,
        SUBPARTITION s999_h4)
);


INSERT INTO sales_composite VALUES
(1, 1, 1, '2020-01-18', 1.1), (2, 3, 4, '2020-02-07', 1.2), 
(3, 17, 5, '2020-01-19', 1.3), (4, 23, 2, '2020-02-08', 1.4), 
(5, 56, 1, '2020-01-20', 1.6), (6, 77, 5, '2020-02-09', 1.7), 
(7, 122, 4, '2020-01-21', 1.8), (8, 153, 1, '2020-02-10', 1.9), 
(9, 179, 5, '2020-01-22', 2.0), (10, 244, 2, '2020-02-11', 2.1), 
(11, 263, 1, '2020-01-23', 2.2), (12, 312, 4, '2020-02-12', 2.3), 
(13, 346, 2, '2020-01-24', 2.4), (14, 389, 3, '2020-02-13', 2.5), 
(15, 472, 1, '2020-01-25', 2.6), (16, 502, 1, '2020-02-14', 2.7);

-- Receive data from partition
SELECT * FROM  sales_composite PARTITION (s3_h4);

-- Partitioning Benefits
-- Clustering: Nhóm lại
-- Sharding
-- Big data
-- Hadoop
-- noSQL and Document Databases
-- Cloud Computing
