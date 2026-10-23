USE SalesDB;
-- Q1: Customers with no score, then customers with a score
SELECT CustomerID, FirstName, Score
FROM Sales.Customers
WHERE Score IS NULL;

SELECT CustomerID, FirstName, Score
FROM Sales.Customers
WHERE Score IS NOT NULL;

-- ISNULL and COALESCE give the same result for two arguments
SELECT FirstName,
       Score,
       ISNULL(Score, 0)    AS score_isnull,
       COALESCE(Score, 0)  AS score_coalesce
FROM Sales.Customers;