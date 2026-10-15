USE MyDatabase;
--COMPARISION OPERATORS--
SELECT * FROM
customers;
--customers with score above 500--
SELECT score,first_name
FROM customers
WHERE score > 500;
--customers from germany and score above 500--
SELECT score,country,first_name
FROM customers
WHERE country = 'Germany' AND score >400;
--between and in--
SELECT first_name,score
FROM customers
WHERE score BETWEEN 350 and 750;
--using in--
SELECT * FROM
customers
WHERE country IN ('Germany','UK');
--LIKE--
SELECT first_name
FROM customers
WHERE first_name LIKE 'M%';
--ENDS WITH N--
SELECT * FROM customers
WHERE first_name LIKE '%N';
--THAT CONTAINS R ANYWHERE--
SELECT * FROM customers
WHERE first_name LIKE '%r%';


