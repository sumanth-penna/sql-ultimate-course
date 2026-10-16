USE MyDatabase;
--NO JOIN--
SELECT * FROM Customers;
SELECT * FROM
Orders;
--INNER JOIN--
--Get all customers along with their orders, but only for customers who have placed an order --
SELECT customers.id,customers.first_name,orders.order_id,orders.sales
FROM customers
INNER JOIN orders
ON id=customer_id;
-- LEFT JOIN
/* Get all customers along with their orders,
   including those without orders */
   SELECT customers.id,customers.first_name,orders.order_id,orders.sales
FROM customers
LEFT JOIN orders
ON id=customer_id;
--INNER JOIN with first_name, order_id, order_date and sales, sorted by sales, highest first.
SELECT customers.first_name,orders.order_id,orders.order_date,orders.sales
FROM customers
INNER JOIN orders
ON id=customer_id
ORDER BY sales DESC;

--LEFT JOIN: all customers with their country and order_id. Which rows show NULL?
SELECT customers.first_name,customers.country,orders.order_id
FROM customers
LEFT JOIN orders
ON id=customer_id;
-- RIGHT JOIN
/* Get all customers along with their orders,
   including orders without matching customers */
   SELECT c.first_name,c.id,o.order_id,o.sales,o.customer_id
   FROM customers AS c
   RIGHT JOIN orders AS O
   ON c.id=o.customer_id;
   --full join--
   SELECT
    c.id,c.first_name,o.order_id,o.customer_id,o.sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id;
-- Get all customers along with their orders, but only for customers who have placed an order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL
-- LEFT ANTI JOIN
-- Get all customers who haven't placed order
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL;

-- RIGHT ANTI JOIN
--/*Get all orders without matching customes 
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL;
-- CROSS JOIN Generate all possible combinations of customers and orders */
SELECT *
FROM customers
CROSS JOIN orders







