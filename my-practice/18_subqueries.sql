

USE SalesDB;

-- Scalar subquery in WHERE - orders above the average sale
SELECT OrderID, Sales
FROM Sales.Orders
WHERE Sales > (SELECT AVG(Sales) FROM Sales.Orders);.

--  Subquery in FROM - customers whose score is above the average
SELECT FirstName, Score, AvgScore
FROM (
    SELECT FirstName, Score, AVG(Score) OVER () AS AvgScore
    FROM Sales.Customers
) AS t
WHERE Score > AvgScore;

--  Subquery in SELECT - number of orders per customer
SELECT c.CustomerID, c.FirstName,
       (SELECT COUNT(*) FROM Sales.Orders AS o
        WHERE o.CustomerID = c.CustomerID) AS TotalOrders
FROM Sales.Customers AS c;

--  IN - customers who have placed orders
SELECT CustomerID, FirstName
FROM Sales.Customers
WHERE CustomerID IN (SELECT CustomerID FROM Sales.Orders);
--  NOT IN - customers with no orders
SELECT CustomerID, FirstName
FROM Sales.Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Sales.Orders);

--  ANY and ALL - compare products to Accessories prices (10, 15)
SELECT Product, Price
FROM Sales.Products
WHERE Price > ANY (SELECT Price FROM Sales.Products WHERE Category = 'Accessories');

SELECT Product, Price
FROM Sales.Products
WHERE Price > ALL (SELECT Price FROM Sales.Products WHERE Category = 'Accessories');


-- EXISTS - customers who have at least one order
SELECT c.CustomerID, c.FirstName
FROM Sales.Customers AS c
WHERE EXISTS (SELECT 1 FROM Sales.Orders AS o
              WHERE o.CustomerID = c.CustomerID);

--  NOT EXISTS - customers with no orders (the NULL-safe version of Q5)
SELECT c.CustomerID, c.FirstName
FROM Sales.Customers AS c
WHERE NOT EXISTS (SELECT 1 FROM Sales.Orders AS o
                  WHERE o.CustomerID = c.CustomerID);
