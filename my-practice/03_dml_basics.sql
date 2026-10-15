USE MyDatabase;
SELECT * INTO customers_practice
FROM customers;
SELECT * FROM customers_practice;
--add one details of customer--
INSERT INTO customers_practice (id, first_name, country, score)
VALUES (6,'bob','india',1000);
--update--
UPDATE customers_practice
SET score=0
WHERE id=6;
--update--
UPDATE customers_practice
SET country = 'USA'
WHERE score =0;
--delete--
DELETE FROM customers_practice
WHERE id = 6;
--drop--
DROP TABLE customers_practice;
SELECT * FROM customers_practice;
