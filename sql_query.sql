create schema SQL_project;
use SQL_project;
create table retail_sales(
transactions_id	int Primary key,
sale_date	Date,
sale_time	Time,
customer_id int,
gender	varchar(15),
age int,	
category varchar(15),	
quantiy	int,
price_per_unit	float,
cogs float,
total_sale float
)
select * from retail_sales;

-- count the number of rows--
select count(*)from retail_sales;


-- DATA CLEANING--
-- To find Null Values --
delete from retail_sales 
where transactions_id	is NULL or
sale_date	is NULL or
sale_time	is NULL or
customer_id is NULL or
gender	is NULL or
age is NULL or	
category is NULL or	
quantiy is NULL or
price_per_unit is NULL or
cogs is NULL or 
total_sale is NULL;

-- DATA EXPLORATION--

--- How Many sales we have ---
select count(*) as total_sales From retail_sales;

-- How Many unique customers we have--
select count(distinct(customer_id)) from retail_sales;

-- how many category(names) we have--
select distinct category from retail_sales;
  
  -- DATA ANALYSIS--
  -- 1--Write a Sql Querry to retrieve all colums for sales made on "05-11-2022'
  select * from retail_sales
  where sale_date='05-11-2022';
  
  -- 2-- Write A sql querry to retrieve all transactions where the category is'Clothing' and Quantity is more or equal to 4 in the month of november-2022
  select * from retail_sales
  where category= 'Clothing' and quantiy>=4 and sale_date BETWEEN '01-11-2022' AND '30-11-2022';

  -- 3-- write a sql Query to calculate the total Sales for each category
  select category,sum(total_sale) as net_sale from retail_sales
  group by category;

-- 4--write a sql query to find the average age of customers who purchased items from the "Beauty" Category 
select avg(age) as avg_age from retail_sales
where category="Beauty";

-- 5--write a sql query to find all transactions where the total_sale is greater than 1000
select * from retail_sales
where total_sale>1000

-- 6-- write a sql query to find the total number of transactions(transaction-id)made by each gender in each category
 select category ,gender,count(transactions_id) as total_sales from retail_sales
group by category,gender; 

-- 7-- write a sql query to calculate the average sale for each month.Find out best selling month in each year
SELECT 
  year,
  month,
  total_sales
FROM (
    SELECT 
      EXTRACT(YEAR FROM STR_TO_DATE(sale_date, '%Y-%m-%d')) AS year,
      EXTRACT(MONTH FROM STR_TO_DATE(sale_date, '%Y-%m-%d')) AS month,
      AVG(total_sale) AS total_sales,
      RANK() OVER (
          PARTITION BY EXTRACT(YEAR FROM STR_TO_DATE(sale_date, '%Y-%m-%d'))
          ORDER BY AVG(total_sale) DESC
      ) AS rnk
    FROM retail_sales
    GROUP BY 1,2
) AS t1
WHERE rnk = 1;
 
 -- 8--write a query to find the top 5 customers based on highest total sales
 select customer_id,sum(total_sale) as sales from retail_sales
 group by customer_id
 order by sales desc
 limit 5;
 
 -- 9-- write a sql querry to find the number of unique customers who purchased items from each category
select category,count(distinct(customer_id)) from retail_sales
group by category;

--- END OF PROJECT---