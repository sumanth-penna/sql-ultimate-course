USE Mydatabase;
--Get every column and row from customer table
SELECT *
FROM CUSTOMERS;
-- get firstname and country--
SELECT first_name,country 
FROM CUSTOMERS;
--CUSTOMERS FROM USA--
SELECT first_name,country
FROM customers
WHERE country='USA';
--CUSTOMERS WHOSE SCORE IS NOT EQUAL TO 0--
SELECT first_name,score 
FROM customers
WHERE score<>0
--customers with score more than 500--
SELECT score,first_name
FROM customers
WHERE score >= 500
--CUSTOMERS NAME SORTED FROM A TO Z--
SELECT first_name
FROM customers
ORDER BY first_name ASC
--FIRST NAME AND SCORE WHERE SCORE IS SORTED FROM HIGH TO LOW--
SELECT first_name,score
FROM customers
ORDER BY score DESC
-- top 2 customers order by score highest--
SELECT TOP 2 first_name,score
FROM customers
ORDER by score DESC ;
-- Show each country only once
SELECT DISTINCT country
FROM customers;
--CUSTOMERS FROM GERMANY AND SCORE ABOVE 400--
SELECT first_name,country,score
FROM customers
WHERE country = 'Germany' AND SCORE >400;

--PART B orders--
SELECT * 
FROM orders;
--show order_date and sales--
SELECT order_date,sales
FROM orders;
--orders sorted by sales total--
SELECT order_id,sales
FROM orders
ORDER BY sales DESC;
-- top 3 biggest sales--
SELECT TOP 3 order_id,sales
FROM orders
ORDER BY sales DESC;
--UNIQUE CUSTOMER ID--
SELECT DISTINCT customer_id
FROM orders;
--sort by date--
SELECT order_date,customer_id
FROM orders
ORDER BY order_date DESC;
--SELECT DISTINCT CUSTOMER_ID--
SELECT DISTINCT Customer_id,order_id
FROM orders;
--orders with sales greater than 10--
SELECT customer_id,sales
FROM orders
WHERE sales > 10;
--orders place by customer 1--
SELECT sales,customer_id
FROM orders
WHERE customer_id = 1;
--GROUP BY AND AGGREGATES--
SELECT * 
FROM CUSTOMERS;
--TOTAL SCORE OF EACH COUNTRY-
SELECT country,SUM(score) AS total_score
FROM customers
GROUP BY country;
--total scores and total customers--
SELECT SUM(score) AS total_Score,
count(id) as total_count,country
FROM customers
GROUP BY country;
--avg score for each country--
SELECT AVG(score) as avg_score,country
FROM customers
GROUP BY country;
--country avg score whose avg is greater than 430-
SELECT AVG(score) as avg_score,country
FROM customers
GROUP BY country
HAVING  AVG(score) > 430;
--stattic vavlues--
SELECT id,first_name,
'NEW CUSTOMERS' AS customer_type
FROM customers;
