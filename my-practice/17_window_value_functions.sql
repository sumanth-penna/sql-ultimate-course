--LEAD AND LAG--
USE SalesDB;

SELECT OrderID, OrderDate, Sales,
       LAG(Sales,1,0)  OVER (ORDER BY OrderDate) AS PrevSales,
       LEAD(Sales) OVER (ORDER BY OrderDate) AS NextSales
FROM Sales.Orders;
--with partition by--
SELECT CustomerID, OrderID, OrderDate,
       LAG(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS PrevOrder,
       DATEDIFF(day,
                LAG(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate),
                OrderDate) AS DaysSincePrev
FROM Sales.Orders
ORDER BY CustomerID, OrderDate;
--month over month change--
SELECT OrderMonth, MonthSales,
       LAG(MonthSales) OVER (ORDER BY OrderMonth)              AS PrevMonth,
       MonthSales - LAG(MonthSales) OVER (ORDER BY OrderMonth) AS Change
FROM (
    SELECT MONTH(OrderDate) AS OrderMonth, SUM(Sales) AS MonthSales
    FROM Sales.Orders
    GROUP BY MONTH(OrderDate)
) AS m;
/* TASK 1:
   Analyze the Month-over-Month Performance by Finding the Percentage Change in Sales
   Between the Current and Previous Months
*/

SELECT
    *,
    CurrentMonthSales - PreviousMonthSales AS MoM_Change,
    ROUND(
        CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT)
        / PreviousMonthSales * 100, 1
    ) AS MoM_Perc
FROM (
    SELECT
        MONTH(OrderDate)                                 AS OrderMonth,
        SUM(Sales)                                       AS CurrentMonthSales,
        LAG(SUM(Sales)) OVER (ORDER BY MONTH(OrderDate)) AS PreviousMonthSales
    FROM Sales.Orders
    GROUP BY MONTH(OrderDate)
) AS MonthlySales;


  -- Find the Lowest and Highest Sales for Each Product,and determine the difference between the current Sales and the lowest Sales for each Product
*/--
SELECT
    OrderID,
    ProductID,
    Sales,
    FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) AS LowestSales,
    LAST_VALUE(Sales) OVER (
        PARTITION BY ProductID
        ORDER BY Sales
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    ) AS HighestSales,
    Sales - FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) AS SalesDifference
FROM Sales.Orders;

--show sales,difference from the previous orders sales
SELECT OrderID, OrderDate, Sales,
       LAG(Sales) OVER (ORDER BY OrderDate)         AS PrevSales,
       Sales - LAG(Sales) OVER (ORDER BY OrderDate) AS ChangeFromPrev
FROM Sales.Orders;
--  Each order's Sales and that customer's FIRST order Sales
SELECT CustomerID, OrderID, OrderDate, Sales,
       FIRST_VALUE(Sales) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS FirstOrderSales
FROM Sales.Orders
ORDER BY CustomerID, OrderDate;