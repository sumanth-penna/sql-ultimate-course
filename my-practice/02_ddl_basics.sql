USE MyDatabase;

--Part 1: persons table (CREATE, ALTER, DROP) =====

DROP TABLE IF EXISTS persons;

CREATE TABLE persons (
    id INT NOT NULL,
    person_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    phone VARCHAR(15) NOT NULL,
    CONSTRAINT pk_persons PRIMARY KEY (id)
);

-- Add a new column
ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL;

-- Remove a column
ALTER TABLE persons
DROP COLUMN phone;

-- Delete the whole table
DROP TABLE persons;

-- Part 2: employees table =====

DROP TABLE IF EXISTS employees;

-- Create the employees table
CREATE TABLE employees (
    employee_id INT NOT NULL,
    company VARCHAR(50) NOT NULL,
    phone VARCHAR(10) NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (employee_id)
);

-- Insert one row 
INSERT INTO employees (employee_id, company, phone)
VALUES (1, '123XYZ', '1234556990');

-- Check the data
SELECT * FROM employees;

-- Add a new optional column
ALTER TABLE employees
ADD area VARCHAR(20);

-- The new column is NULL for the existing row
SELECT * FROM employees;
