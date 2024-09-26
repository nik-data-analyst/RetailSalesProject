-- SQL retail sales anlysis - P1
CREATE DATABASE sql_project_p1; 


-- CREATE TABLE
drop table if exists retail_sales;
CREATE TABLE retail_sales 
			(
			    transactions_id	INT	PRIMARY KEY,
				sale_date	DATE,
				sale_time	TIME,
				customer_id	INT,
				gender	 VARCHAR (15),
				age			INT,		
				category	VARCHAR(15),
				quantiy		INT,
				price_per_unit	FLOAT,
				cogs	FLOAT,
				total_sale	FLOAT

			);					

SELECT * FROM retail_sales
LIMIT 10

SELECT 
	COUNT (*)
FROM retail_sales

--
SELECT * FROM retail_sales
where transactions_id IS NULL

SELECT * FROM retail_sales
where sale_date IS NULL

SELECT * FROM retail_sales
where sale_time IS NULL

SELECT * FROM retail_sales
where customer_id IS NULL

SELECT * FROM retail_sales
where gender IS NULL

SELECT * FROM retail_sales
where age IS NULL

SELECT * FROM retail_sales
where transactions_id IS NULL
		OR
		sale_date IS NULL
		OR
		sale_time IS NULL
		OR
		customer_id IS NULL
		OR
		AGE IS NULL
		OR
		category IS NULL	
		OR
		quantiy IS NULL	
		OR
		price_per_unit IS NULL
		OR
		cogs IS NULL
		OR
		total_sale IS NULL
		
-- DATA CLEANING 
DELETE FROM retail_sales
where transactions_id IS NULL
		OR
		sale_date IS NULL
		OR
		sale_time IS NULL
		OR
		customer_id IS NULL
		OR
		AGE IS NULL
		OR
		category IS NULL	
		OR
		quantiy IS NULL	
		OR
		price_per_unit IS NULL
		OR
		cogs IS NULL
		OR
		total_sale IS NULL;

-- DATA EXPLORATION

-- how many sales we have?
SELECT COUNT(*) AS total_sales from retail_sales

--how many unique customers we have?
SELECT COUNT (DISTINCT customer_id) AS total_sales from retail_sales

--how many categories we have?
SELECT DISTINCT category  from retail_sales

-- DATA ANALYSIS & BUSINESS KEY PROBLEMS

1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
 SELECT *
 FROM retail_sales
 where sale_date = '2022-11-05'

 

2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
 select 
 	*
FROM retail_sales
where category = 'Clothing'
	AND
	TO_CHAR (sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4

	


3.Write a SQL query to calculate the total sales (total_sale) for each category.
 SELECT 
 	category,
	SUM(TOTAL_SALE) AS net_sale,
	COUNT(*) as total_orders
 FROM retail_sales
 group by 1

4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 SELECT
	ROUND(AVG(age),2) AS avg_age
from retail_sales
where category = 'Beauty'


5.Write a SQL query to find all transactions where the total_sale is greater than 1000.
 SELECT * FROM retail_sales
 WHERE total_sale > '1000'


6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 SELECT 
 	category,
	gender,
	COUNT(*) as total_trans
from retail_sales
GROUP BY
	category,
	gender
order by 1


7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
	SELECT * FROM
	(

		SELECT 
		EXTRACT(YEAR FROM sale_date) as year,
		EXTRACT(MONTH FROM sale_date) as month,
		AVG(total_sale) as avg_sale,
		rank() over (partition by extract (year from sale_date) ORDER BY AVG(total_sale)DESC)
	FROM retail_sales
	group by 1,2
	) AS T1
	WHERE RANK=1
	--order by 1,3 desc




8.Write a SQL query to find the top 5 customers based on the highest total sales
	SELECT
		customer_id,
		sum(total_sale) as total_sale
		from retail_sales
		group by 1
		order by 2 DESC
		limit 5



9.Write a SQL query to find the number of unique customers who purchased items from each category.

	select
	 category,
	COUNT(DISTINCT customer_id) as CNT_UNIQUE_CS
	from retail_sales
	GROUP BY category



10.Write a SQL query to create each shift and number of orders (Example Morning<12, Afternoon Between 12 & 17, Evening >17).

WITH hourly_sale
AS
(
	SELECT *,
		case 
		when EXTRACT(HOUR FROM sale_time) <12 then 'MORNING'
		when EXTRACT(HOUR FROM sale_time)  BETWEEN 12 AND 17 THEN 'AFTERNOON'
		else 'EVENING'
	end as shift
	FROM retail_sales
)
SELECT
	shift,
	COUNT(*) AS total_orders
	FROM hourly_sale
GROUP BY shift

--END OF PROJECT--


