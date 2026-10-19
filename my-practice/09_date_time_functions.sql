--DATE PARTITION--
USE SalesDB;

--GET DATE,MONTH,YEAR--
SELECT
OrderID,CreationTime,YEAR(CreationTime) year,
MONTH(CreationTime) month,
DAY(CreationTime) day
FROM Sales.Orders;
--date part--
SELECT ORDERID,DATEPART(MONTH,CreationTime) month,CreationTime
FROM Sales.Orders;
--date name--
SELECT ORDERID,DATENAME(MONTH,CreationTime) month_name ,CreationTime
FROM Sales.Orders;
--date trunc--
SELECT ORDERID,DATETRUNC(HOUR,CreationTime)
FROM Sales.Orders;
--EOMONTH--
SELECT ORDERID,EOMONTH(CreationTime)
FROM Sales.Orders;
--FORMAT--
SELECT ORDERID,FORMAT(CreationTime,'MMMMyyyy')
FROM Sales.Orders;
--
