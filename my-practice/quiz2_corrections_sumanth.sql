USE SalesDB;
-- Q3: How many rows does Customers LEFT JOIN Orders return? (I said 5)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o ON c.CustomerID = o.CustomerID;
--no.of rows are 11 it returns all the rows from sales.customers without common values from sales.orders--
-- My note: 11 rows. A join gives one row per match: Jossef 3 + Kevin 3 + Mary 3
-- + Mark 1 = 10, plus Anna once with NULLs because LEFT JOIN keeps her.
-- I said 5 because I counted customers instead of matches.
-- Q4: Anna's COUNT(*) after the LEFT JOIN (I said she is not in the result)
SELECT c.FirstName, COUNT(*) AS count_rows, COUNT(o.OrderID) AS count_orders
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName;
--my note:count(*) will count rows of null too,count(col) will skip null--

-- Q6: Rows from the employee/manager self join (I said 3)
SELECT e.FirstName AS Employee, m.FirstName AS Manager
FROM Sales.Employees AS e
INNER JOIN Sales.Employees AS m ON e.ManagerID = m.EmployeeID;
--my note:it returns 4 rows,only frank is dropped because managerid is null--
-- Q7: Customers EXCEPT Employees (I said Jossef, Mark, Frank)
SELECT FirstName, LastName FROM Sales.Customers
EXCEPT
SELECT FirstName, LastName FROM Sales.Employees;
--it results jossef,mark,anna, except returns value from first table that are not in second table--
-- Q10: CASE for Anna's NULL score with no ELSE (I said Error)
SELECT FirstName, Score,
       CASE WHEN Score >= 500 THEN 'High'
            WHEN Score < 500  THEN 'Low'
       END AS Band
FROM Sales.Customers;
--it shows null not an error as NO ELSE CASE returns null--

--q13--
SELECT 7 / 2 AS int_div, 7 / 2.0 AS dec_div;
--when divided by decimal it returns decimal not INT--


-- Q14: DATEDIFF with the dates swapped (I said 15)
SELECT OrderID, OrderDate, ShipDate,
       DATEDIFF(day, ShipDate, OrderDate) AS reversed_days
FROM Sales.Orders
WHERE OrderID = 3;
--AS SHIPDATE-ORDER DATE IT RETURNS -15 DAYS--
-- ===== Part B =====

-- Q16: Every customer's FirstName and total Sales,
--      0 for customers with no orders, highest first.
-- Expected: Mary 125, Jossef 110, Mark 90, Kevin 55, Anna 0.
SELECT c.FirstName, COALESCE(SUM(o.Sales), 0) AS TotalSales
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o ON  c.CustomerID=O.CustomerID
GROUP BY c.CustomerID, c.FirstName
ORDER BY TotalSales DESC;
--I WROTE COUNT(*) WHICH COUNTS TOTAL ROWS,FOR TOTAL SALES WE SHOULD USE SUM--
--I HAVENT JOINED SALES.ORDERS--

-- Q17: OrderID, Product name and DeliverySpeed:
--      'Fast' if shipped within 5 days, otherwise 'Slow'.
-- Expected: Slow for orders 3, 7 and 8; Fast for the rest.
SELECT o.OrderID, p.Product,
       CASE WHEN DATEDIFF(day, o.OrderDate, o.ShipDate) <= 5 THEN 'Fast'
            ELSE 'Slow' END AS DeliverySpeed
FROM Sales.Orders o
INNER JOIN Sales.Products p ON p.ProductID = o.ProductID;
---- What I got wrong: Product is in Sales.Products so I needed a INNER join,
-- I wrote =< instead of <=, and used 'FAST' instead of 'Fast'.