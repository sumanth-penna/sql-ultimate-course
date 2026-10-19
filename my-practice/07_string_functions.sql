USE MyDatabase;
--1.concat--
--concat firstname and country--
SELECT CONCAT(first_name,'-',country) AS FULL_INF0
FROM customers;
--UPPER CASE AND LOWER CASE--
-- First name to lowercase
SELECT
    LOWER(first_name) AS lower_case_name
FROM customers;

--  first name to uppercase
SELECT
    UPPER(first_name) AS upper_case_name
FROM customers;
--TRIM--
--ANY CUSTOMER WHO HAS LEADING OR TRAILING SPACES--
SELECT first_name
FROM customers
WHERE first_name <> TRIM(first_name);
--replace dashn with slash--
SELECT
'123-456-7890'                    AS phone,
REPLACE('123-456-7890', '-', '/') AS clean_phone

-- Replace File Extension from txt to csv
SELECT
'report.txt'                          AS old_filename,
REPLACE('report.txt', '.txt', '.csv') AS new_filename
-- Calculate the length of each customer's first name
SELECT
    first_name,
    LEN(first_name) AS name_length
FROM customers
-- Retrieve the first two characters of each first name
SELECT
    first_name,
    LEFT(TRIM(first_name), 2) AS first_2_chars
FROM customers

-- Retrieve the last two characters of each first name
SELECT
    first_name,
    RIGHT(first_name, 2) AS last_2_chars
FROM customers
SELECT
    first_name,
    SUBSTRING(TRIM(first_name), 2, LEN(first_name)) AS trimmed_name
FROM customers




