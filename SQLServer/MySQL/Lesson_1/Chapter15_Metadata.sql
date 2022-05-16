use european_sales;
-- Metadata
SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'european_sales'
ORDER BY 1;

-- Exclude table_type = 'VIEW'
SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'european_sales'
AND table_type = 'BASE TABLE'
ORDER BY 1;


SELECT table_name, is_updatable
FROM information_schema.views
WHERE table_schema = 'european_sales'
ORDER BY 1;


SELECT column_name, data_type,
		character_maximum_length char_max_len,
        numeric_precision num_prcsn, numeric_scale num_scale
FROM information_schema.columns
WHERE table_schema = 'european_sales' AND table_name = 'film'
ORDER BY ordinal_position;

-- a query that retrieves all of the constraints
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'european_sales'
ORDER BY 3, 1;

CREATE TABLE category1 (
	category1_id tinyint unsigned not null auto_increment,
    name varchar(25) not null,
    last_update timestamp not null default current_timestamp
		on update current_timestamp,
	PRIMARY KEY (category1_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

SELECT 'CREATE TABLE category (' create_table_statement
UNION ALL
SELECT cols.txt
FROM 
(SELECT concat(' ', column_name, ' ', column_type,
	CASE WHEN is_nullable = 'NO' THEN 'not null'
		ELSE ''
	END,
    CASE WHEN extra IS NOT NULL AND extra LIKE 'DEFAULT_GENERATED%'
		THEN concat(' DEFAULT', column_default, substr(extra,18))
		WHEN extra IS NOT NULL THEN concat(' ', extra)
        ELSE ''
	END,
    ',') txt
	FROM information_schema.columns
	WHERE table_schema = 'european_sales' AND table_name = 'category1'
	ORDER BY ordinal_position
) cols
UNION ALL
SELECT ')';

SELECT 'CREATE TABLE category (' create_table_statement
UNION ALL
SELECT cols.txt
FROM 
(SELECT concat(' ', column_name, ' ', column_type,
	CASE WHEN is_nullable = 'NO' THEN 'not null'
		ELSE ''
	END,
    CASE WHEN extra IS NOT NULL AND extra LIKE 'DEFAULT_GENERATED%'
		THEN concat(' DEFAULT', column_default, substr(extra,18))
		WHEN extra IS NOT NULL THEN concat(' ', extra)
        ELSE ''
	END,
    ',') txt
	FROM information_schema.columns
	WHERE table_schema = 'european_sales' AND table_name = 'category1'
	ORDER BY ordinal_position
) cols
UNION ALL
SELECT concat(' constraint primary key(')
FROM information_schema.table_constraints
WHERE table_schema = 'european_sales' AND table_name = 'category1'
AND	constraint_type = 'PRIMARY KEY'
UNION ALL
SELECT cols.txt
FROM (SELECT concat(CASE WHEN ordinal_position > 1 THEN '  ,'
	ELSE '    ' END, column_type) txt
	FROM information_schema.key_column_usage
    WHERE table_schema = 'european_sales' AND table_name = 'category1'
	AND constraint_name = 'PRIMARY'
    ORDER BY orinal_position
    ) cols
UNION ALL
SELECT '  )'
UNION ALL
SELECT ')';

-- Deployment Verification
SELECT tbl.table_name,
(SELECT count(*) FROM information_schema.columns clm
WHERE clm.table_schema = tbl.table_schema
	AND clm.table_name = tbl.table_name) num_columns,
(SELECT count(*) FROM information_schema.statistics sta
WHERE sta.table_schema = tbl.table_schema
	AND sta.table_name = tbl.table_name ) num_indexes,
(SELECT count(*) FROM information_schema.table_constraints tc
	WHERE tc.table_schema = tbl.table_schema
	AND tc.table_name = tbl.table_name
    AND tc.constraint_type = 'PRIMARY KEY') num_primary_keys
FROM information_schema.tables tbl
WHERE tbl.table_schema = 'european_sales' AND tbl.table_type = 'BASE TABLE'
ORDER BY 1;

-- Dynamic SQL Genaration
SET @qry = 'SELECT customer_id, first_name, last_name FROM customer';
PREPARE dynsql1 FROM @qry;
EXECUTE dynsql1;
DEALLOCATE PREPARE dynsql1;

SET @qry =  'SELECT customer_id, first_name, last_name, email, active
	FROM customer WHERE customer_id = ?';
PREPARE dynsql2 FROM @qry;
SET @custid = 9;
EXECUTE dynsql2 USING @custid;
DEALLOCATE PREPARE dynsql2;

SELECT concat('SELECT', 
	concat_ws(',', cols.col1, cols.col2, cols.col3, cols.col4,
    cols.col5, cols.col6, cols.col7, cols.col8, cols.col9),
    ' FROM customer WHERE customer_id = ?')
INTO @qry
FROM 
(SELECT 
	max(CASE WHEN ordinal_position = 1 THEN column_name
		ELSE NULL END) col1,
	max(CASE WHEN ordinal_position = 2 THEN column_name
		ELSE NULL END) col2,
	max(CASE WHEN ordinal_position = 3 THEN column_name
		ELSE NULL END) col3,
	max(CASE WHEN ordinal_position = 4 THEN column_name
		ELSE NULL END) col4,
	max(CASE WHEN ordinal_position = 5 THEN column_name
		ELSE NULL END) col5,
	max(CASE WHEN ordinal_position = 6 THEN column_name
		ELSE NULL END) col6,
	max(CASE WHEN ordinal_position = 7 THEN column_name
		ELSE NULL END) col7,
	max(CASE WHEN ordinal_position = 8 THEN column_name
		ELSE NULL END) col8,
	max(CASE WHEN ordinal_position = 9 THEN column_name
		ELSE NULL END) col9
FROM information_schema.columns
WHERE table_schema = 'european_sales' AND table_name = 'customer'
GROUP BY table_name
) cols;

SELECT @qry;
PREPARE dynsql3 FROM @qry;
SET @custid = 20;
EXECUTE dynsql3 USING @custid;
DEALLOCATE PREPARE dynsql3;

SELECT DISTINCT table_name, index_name
FROM information_schema.statistics
WHERE table_schema = 'european_sales';

WITH idx_info AS 
(SELECT s1.table_name, s1.index_name, 
		s1.column_name, s1.seq_in_index,
        (SELECT max(s2.seq_in_index)
        FROM information_schema.statistics s2
        WHERE s2.table_name = s1.table_name
			AND s2.index_name = s1.index_name) num_columns
FROM information_schema.statistics s1
WHERE s1.table_schema = 'european_sales'
AND s1.table_name = 'customer'
)
SELECT concat(
	CASE WHEN	seq_in_index = 1 THEN 
		concat('ALTER TABLE ', table_name, ' ADD INDEX ',
				index_name, '(', column_name)
		ELSE concat(' , ', column_name)
	END,
    CASE WHEN seq_in_index = num_columns THEN ');'
		ELSE ''
	END
    ) index_creation_statement
FROM idx_info
ORDER BY index_name, seq_in_index;

-- other way for exercise
SELECT concat('ALTER TABLE ', table_name, ' ADD INDEX ', index_name, ' (',
		group_concat(column_name order by seq_in_index separator ', '), ');') index_creation_statement
FROM information_schema.statistics
WHERE table_schema = 'european_sales'
	AND table_name = 'customer'
GROUP BY table_name, index_name;
