/*
=============================================================
SQL Practice 2: Intermediate
=============================================================
Before:   the Intermediate quiz on 19 Oct 2026
Database: SalesDB from the SQL Ultimate Course
Run in:   SSMS, connected to your local SQL Server

How to work: same as Practice 1. Write the query, run it, compare
with "Expected", and answer the "Think" questions as comments.
Save as practice_2_intermediate_<yourname>.sql and send it to Anmol.

Topics: JOINs (INNER, LEFT, self join), set operators (UNION,
        INTERSECT), GROUP BY + HAVING, CASE, NULL functions
        (COALESCE/ISNULL), string functions, date functions
=============================================================
*/

USE SalesDB;
GO
   SELECT * FROM Sales.Orders;
   SELECT * FROM Sales.Customers;
   SELECT * FROM Sales.Products;
   SELECT * FROM Sales.Employees;
-- Q1. For every order, show OrderID, the customer's FirstName, the Product name and Sales.
-- Expected: 10 rows.
SELECT o.OrderID, c.FirstName, p.Product, o.Sales
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c ON o.CustomerID = c.CustomerID
INNER JOIN Sales.Products  AS p ON o.ProductID  = p.ProductID;



-- Q2. Which customers have never placed an order? Use a LEFT JOIN.
-- Expected: Anna (CustomerID 5).
SELECT c.CustomerID, c.FirstName
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;



-- Q3. For every order, show OrderID, customer FirstName, Product,
--     and the salesperson's FirstName (SalesPersonID -> Employees).
-- Expected: 10 rows. Order 7's salesperson is Frank.
SELECT o.OrderID, c.FirstName AS Customer, p.Product, e.FirstName AS SalesPerson
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c ON o.CustomerID    = c.CustomerID
INNER JOIN Sales.Products  AS p ON o.ProductID     = p.ProductID
INNER JOIN Sales.Employees AS e ON o.SalesPersonID = e.EmployeeID;






-- Q4. Show total sales per product Category, keeping only categories
--     with total sales above 200.
-- Expected: Accessories 245.
-- Think: why must this filter use HAVING and not WHERE?
SELECT SUM(O.sales) AS total_sales,p.category
FROM Sales.Orders AS o
INNER JOIN Sales.Products AS p
ON o.Productid=p.ProductID
GROUP BY p.Category
HAVING SUM(o.Sales) > 200;
--we use having after groupig so it can check the Sum(o.sales)
--where before grouping as sum doesnot exist --


-- Q5. Show customers who placed 3 or more orders, with their order count.
-- Expected: CustomerID 1, 2, 3 (3 orders each).
SELECT CustomerID,COUNT(*) AS order_count
FROM Sales.Orders
GROUP BY customerID
HAVING Count(*)>=3;




-- Q6. Classify customers by Score using CASE:
--     750 or more = 'High', 500-749 = 'Medium', below 500 = 'Low', no score = 'No Score'.
-- Expected: Jossef Low, Kevin High, Mary High, Mark Medium, Anna No Score.
SELECT FirstName, Score,
    CASE WHEN Score IS NULL THEN 'No Score'
         WHEN Score >= 750  THEN 'High'
         WHEN Score >= 500  THEN 'Medium'
         ELSE 'Low'
    END AS ScoreBand
FROM Sales.Customers;
 


-- Q7. Show each customer's FullName and Score, where a missing LastName
--     shows as just the FirstName and a missing Score shows as 0.
-- Expected: 5 rows; Mary's FullName is 'Mary', Anna's Score is 0.
-- Then: what is the average Score if missing scores count as 0?
-- Expected: 500. Compare with Practice 1 Q14.
SELECT CustomerID,
       FirstName + COALESCE(' ' + LastName, '') AS FullName,
       COALESCE(Score, 0) AS Score
FROM Sales.Customers;

SELECT AVG(COALESCE(Score, 0)) AS Avg_score
FROM Sales.Customers;
-- 500: COALESCE turns Anna's NULL into 0, so she counts (2500 / 5).
-- Practice 1 Q14 gave 625 because AVG skipped her NULL (2500 / 4).





-- Q8. Show each employee's initials, e.g. Frank Lee = 'F.L.'.
--     An employee with no LastName shows just one initial.
-- Expected: F.L., K.B., M., M.R., C.B.
SELECT FirstName, LastName,
       LEFT(FirstName, 1) + '.' + COALESCE(LEFT(LastName, 1) + '.', '') AS Initials
FROM Sales.Employees;
-- LEFT(NULL, 1) is NULL and text + NULL = NULL, so COALESCE replaces that part with ''.



-- Q9. Show employees born before 1980.
-- Expected: Kevin (1972), Michael (1977).
SELECT FirstName,YEAR(Birthdate) AS birthyear
FROM Sales.Employees
WHERE YEAR(BirthDate) < 1980;



-- Q10. For every order, show OrderID, OrderDate, ShipDate and the
--      number of days it took to ship (DATEDIFF).
-- Expected: order 3 took 15 days, order 7 took 12.
SELECT OrderID,OrderDate,ShipDate,DATEDIFF(day,OrderDate,ShipDate) AS NUMBER_OF_DAYS
FROM Sales.Orders;



-- Q11. Show the number of orders per month of OrderDate (use the month name).
-- Expected: January 4, February 4, March 2.
SELECT DATENAME(month, OrderDate) AS OrderMonth,
       COUNT(*) AS OrderCount
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate), MONTH(OrderDate)
ORDER BY MONTH(OrderDate);

-- Q12. Show the average days to ship per month.
-- Expected: January 7.25, February 7.5, March 5.0.
-- Think: if you got 7, 7, 5, why? Fix it.
SELECT DATENAME(month, OrderDate) AS OrderMonth,
       AVG(CAST(DATEDIFF(day, OrderDate, ShipDate) AS DECIMAL(10,2))) AS AvgDaysToShip
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate), MONTH(OrderDate)
ORDER BY MONTH(OrderDate);
-- Without CAST we got 7, 7, 5: DATEDIFF returns INT, so AVG returns INT and drops decimals.
-- CAST to DECIMAL before averaging gives 7.25, 7.50, 5.00.




-- Q13. Which (FirstName, LastName) pairs appear in BOTH Customers and Employees?
--      Use INTERSECT.
-- Expected: Kevin Brown, and Mary with a NULL LastName.
-- Think: Mary matches here, but NULL = NULL is not true in a WHERE. Why the difference?
SELECT FirstName, LastName FROM Sales.Customers
INTERSECT
SELECT FirstName, LastName FROM Sales.Employees;
  -- Set operators treat two NULLs as the same value, so Mary (NULL last name) matches.
  -- In WHERE or JOIN ON, NULL = NULL is unknown, not true, so the row would not match.
-- Q14. How many distinct (FirstName, LastName) pairs are there across
--      Customers and Employees combined? Use UNION.
-- Expected: 8. With UNION ALL: 10. Explain the difference.
SELECT COUNT(*) AS union_count FROM (
    SELECT FirstName, LastName FROM Sales.Customers
    UNION
    SELECT FirstName, LastName FROM Sales.Employees
) AS t;   -- 8

SELECT COUNT(*) AS union_all_count FROM (
    SELECT FirstName, LastName FROM Sales.Customers
    UNION ALL
    SELECT FirstName, LastName FROM Sales.Employees
) AS t;   -- 10
-- UNION removes duplicate rows: Kevin Brown and Mary appear in both tables, so 10 - 2 = 8.
-- UNION ALL keeps every row: 5 + 5 = 10.
-- Q15. Show each employee with their manager's FirstName (self join on ManagerID).
--      --Employees without a manager must still appear.--
-- Expected: Frank -> NULL, Kevin -> Frank, Mary -> Frank,
--           Michael -> Kevin, Carol -> Mary.
SELECT e.FirstName AS Employee,
m.FirstName AS Manager
FROM Sales.Employees AS e
LEFT JOIN Sales.Employees AS m
    ON e.ManagerID = m.EmployeeID;

    -
