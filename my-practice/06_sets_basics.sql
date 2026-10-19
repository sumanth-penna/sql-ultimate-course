USE SalesDB;
SELECT * FROM Sales.Customers;
SELECT * FROM Sales.Employees;


--select data from employees and customers--
SELECT
    FirstName,
    LastName
FROM Sales.Customers
UNION
SELECT
    FirstName,
    LastName
FROM Sales.Employees;
--COMBINE DATA USING UNION ALL--
SELECT
    FirstName,
    LastName
FROM Sales.Customers
UNION ALL
SELECT
    FirstName,
    LastName
FROM Sales.Employees;
--EMPLOYEES WHO ARE NOT CUSTOMERS--
SELECT
    FirstName,
    LastName
FROM Sales.Employees
EXCEPT
SELECT
    FirstName,
    LastName
FROM Sales.Customers;
--CUSTOMERS WHO ARE NOT EMPLOYEES--
SELECT
    FirstName,
    LastName
FROM Sales.Customers
EXCEPT
SELECT
    FirstName,
    LastName
FROM Sales.Employees;
--employees whonn are also customers--
SELECT
    FirstName,
    LastName
FROM Sales.Employees
INTERSECT
SELECT
    FirstName,
    LastName
FROM Sales.Customers;
