use european_sales;
-- Analytics Functions;
desc rental;
SELECT * FROM rental;
SELECT * FROM payment;
INSERT INTO payment VALUES(null, 8, 9.9, '2005-11-12');
INSERT INTO payment VALUES(null, 8, 11.3, '2005-11-13');
INSERT INTO payment VALUES(null, 8, 08.3, '2005-11-14');
INSERT INTO payment VALUES(null, 8, 12.3, '2005-11-15');
INSERT INTO payment VALUES(null, 8, 15.3, '2005-11-16');
INSERT INTO payment VALUES(null, 5, 19.3, '2005-11-17');
INSERT INTO payment VALUES(null, 6, 22.3, '2005-11-18');
INSERT INTO payment VALUES(null, 7, 12.3, '2005-11-1');
INSERT INTO payment VALUES(null, 9, 3.3, '2005-11-2');
INSERT INTO payment VALUES(null, 9, 6.3, '2005-11-3');
INSERT INTO payment VALUES(null, 5, 8.3, '2005-11-4');
INSERT INTO payment VALUES(null, 8, 9.3, '2005-11-9');

-- data windows
SELECT quarter(payment_date) quarter,
	month(payment_date) month_nm,
    sum(amount) monthly_sales
FROM payment 
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), month(payment_date)
ORDER BY quarter(payment_date);


SELECT quarter(payment_date) quarter,
	month(payment_date) month_nm,
    sum(amount) monthly_sales,
    max(sum(amount)) over() max_overrall_sales,
    max(sum(amount)) over(partition by quarter(payment_date)) max_quarter_sales
FROM payment 
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), month(payment_date)
ORDER BY quarter(payment_date), month(payment_date);

-- Localized sorting
SELECT quarter(payment_date) quarter,
	month(payment_date) month_nm,
    sum(amount) monthly_sales,
	rank() over( order by sum(amount) desc) sales_rank
FROM payment 
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), month(payment_date)
ORDER BY 1,2;

-- rank for each quarter
SELECT quarter(payment_date) quarter,
	month(payment_date) month_nm,
    sum(amount) monthly_sales,
	rank() over(partition by quarter(payment_date) order by sum(amount) desc) quarter_sales_rank
FROM payment 
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), month(payment_date)
ORDER BY 1,2;

-- Ranking functions
-- row-number
-- rank
-- dense_rank
SELECT customer_id, count(*) num_rentals
FROM rental
GROUP BY customer_id
ORDER BY 2 desc;

SELECT customer_id, monthname(payment_date) payment_month,
count(*) num_payments,
rank() over (partition by monthname(payment_date)
order by count(*) desc) rank_rnk
FROM payment
GROUP BY customer_id, monthname(payment_date)
ORDER BY 2,3 desc;

-- Reporting Functions
SELECT monthname(payment_date) payment_month , amount,
		sum(amount) over (partition by monthname(payment_date)) monthly_total,
		sum(amount) over() grand_total
FROM payment
WHERE amount >= 8
ORDER BY 1;

-- print percentage
SELECT monthname(payment_date) payment_month, 
		sum(amount) month_total,
        round(sum(amount) / sum(sum(amount)) over() * 100, 2) percent_of_total
FROM payment
GROUP BY monthname(payment_date);

-- print with desciption
SELECT monthname(payment_date) payment_month, 
		sum(amount) month_total,
        round(sum(amount) / sum(sum(amount)) over() * 100, 2) percentage_of_total,
        CASE sum(amount) WHEN max(sum(amount)) over() THEN 'Highest'
			WHEN min(sum(amount)) over() THEN 'Lowest'
			ELSE 'Middle'
		END descriptor
FROM payment
GROUP BY monthname(payment_date);

-- Window Frames
SELECT yearweek(payment_date) payment_week,
	sum(amount) week_total,
    sum(sum(amount)) over(order by yearweek(payment_date) rows unbounded preceding) rolling_sum
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT date(payment_date), sum(amount),
	avg(sum(amount)) over (order by date(payment_date)
    range between interval 3 day preceding
    and interval 3 day following) 7_day_avg
FROM payment
WHERE payment_date BETWEEN '2005-05-1' AND '2005-09-01'
GROUP BY date(payment_date)
ORDER BY 1;


-- Lag and Lead
SELECT yearweek(payment_date) payment_week,
	sum(amount) week_total,
    lag(sum(amount), 1) over (order by yearweek(payment_date)) prev_wk_tot,
    lead(sum(amount), 1) over (order by yearweek(payment_date)) next_wk_tot
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

-- USE THE lag function to generate the percentage difference from the prior week:
SELECT yearweek(payment_date) payment_week,
	sum(amount) week_total,
    round((sum(amount) - lag(sum(amount), 1)
	over (order by yearweek(payment_date)))
    / lag(sum(amount),1)
    over (order by yearweek(payment_date))
    * 100, 1) pct_diff
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

-- Column Value Concatenation 
SELECT * FROM film;
SELECT * FROM actor; 
SELECT f.title, group_concat(a.first_name order by a.first_name separator ', ') actors
FROM actor a
INNER JOIN film f
ON a.film_id = f.film_id
GROUP BY f.title
HAVING count(*) > 0;

-- test my knowledge
CREATE TABLE Sales_Fact (
year_no year,
month_no smallint(2),
tot_sale int(6) );

SELECT year_no, month_no, tot_sale,
	rank() over( order by tot_sale desc) rank_total
FROM Sales_Fact
GROUP BY tot_sale
ORDER BY 3 desc;


SELECT year_no, month_no, tot_sale,
    lag(tot_sale) over (order by month_no) prev_month_tot_sales
FROM Sales_Fact
WHERE year_no = 2020
GROUP BY tot_sale
ORDER BY 1, 2;