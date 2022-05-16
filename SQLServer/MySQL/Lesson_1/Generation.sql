CREATE DATABASE Generation;
USE Generation;
CREATE TABLE string_tbl
(	char_fld char(30),
	vchar_fld varchar(30),
    text_fld text
    );
    
INSERT INTO string_tbl (char_fld, vchar_fld, text_fld) 
VALUES ('This is char data', 'This is varchar data', 'This is text data');

UPDATE string_tbl
SET vchar_fld = 'this is piece of extremely long varchar data';

SELECT vchar_fld FROM string_tbl;

-- Strict mode
SELECT @@session.sql_mode;
SET sql_mode = 'ansi';
SHOW WARNINGS;

UPDATE string_tbl
SET text_fld = 'This string didn''t work, but it does now';

SELECT quote( text_fld )
FROM string_tbl;

-- Include special characters
SELECT CHAR(97,98,99,100,101,102,103);

SELECT CONCAT('danke sch', CHAR(148), 'n');
SELECT 'danke sch' + CHAR(148) + 'n';

-- String Manipulating
DELETE FROM string_tbl;
SELECT * FROM string_tbl;

INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES ('This string is 28 characters',
	'This string is 28 characters',
    'This string was 29 characters');
    
-- get length string
SELECT LENGTH(char_fld) char_length,
	LENGTH(vchar_fld) vchar_length,
    LENGTH(text_fld) text_length
FROM string_tbl;

-- find the position of substring at the String
SELECT POSITION('characters' IN vchar_fld)
FROM string_tbl;

SELECT POSITION('har' IN vchar_fld)
FROM string_tbl;

DELETE FROM string_tbl;
INSERT INTO string_tbl (vchar_fld)
VALUES	('abcd'),
		('xyz'),
		('QRSTUV'),
        ('qrstuv'),
        ('12345');
        
SELECT vchar_fld
FROM string_tbl
ORDER BY vchar_fld;

SELECT STRCMP('12345', '12345') 12345_12345,
		STRCMP('abcd', 'xyz') abcd_xyz,
        STRCMP('abcd', 'QRSTUV') abcd_QRSTUV,
        STRCMP('qrstuv', 'QRSTUV') qrstuv_QRSTUV,
        STRCMP('12345', 'xyz') 12345_xyz,
        STRCMP('xyz', 'qrstuv') xyz_qrstuv;

UPDATE string_tbl
SET text_fld = CONCAT(text_fld, ', but now it is longer');
SELECT text_fld
FROM string_tbl;

SELECT LOCATE('is', vchar_fld, 5)
FROM string_tbl;

-- use Replacement
SELECT INSERT('goodbye world', 9, 0, 'cruel ') string;
SELECT INSERT('goodbye world', 1, 7, 'cruel ') string;
SELECT SUBSTRING('goodbye cruel world', 9, 5) string;

-- working with numeric data
SELECT (37 * 59) / (78 - (8 * 6));
SELECT MOD(10,4); -- Remainder
SELECT MOD(22.75, 5);

SELECT POW(2,5); -- POWER 2^5;

SELECT CEIL(72.445), FLOOR(72.445), ROUND(72.445);
SELECT TRUNCATE(72.0909,1), TRUNCATE(72.0909,2), TRUNCATE(72.0909,3);

-- Working with Temporal Data
SELECT @@global.time_zone, @@session.time_zone;
SELECT CAST('2022-01-7 23:35:10' AS DATETIME);
SELECT CAST('2022-01-7' AS DATE) date_field,
	   CAST('108:17:57' AS TIME) time_field;
SELECT current_date(), current_time(), current_timestamp();
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY);
SELECT LAST_DAY('2022-01-7'); -- return 31;
SELECT DAYNAME('2022-01-07'); -- RETURN Friday
SELECT DATEDIFF('2022-06-15', '2022-01-07');

SELECT SUBSTRING('Please find the substring in this string', 17, 9) string;
SELECT ABS(-25.76823), SIGN(-25.76823), ROUND(-25.76823);
SELECT EXTRACT(MONTH FROM CURRENT_DATE);














