-- Create Employees Table
CREATE TABLE employees (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(50),
    salary NUMBER,
    department VARCHAR2(50)
);

-- Create Departments Table
CREATE TABLE departments (
    dept_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dept_name VARCHAR2(50)
);

-- Insert Data into Departments
INSERT INTO departments (dept_name) VALUES ('IT');
INSERT INTO departments (dept_name) VALUES ('HR');
INSERT INTO departments (dept_name) VALUES ('Finance');

-- Insert Data into Employees
INSERT INTO employees (name, salary, department) VALUES ('Ram', 50000, 'IT');
INSERT INTO employees (name, salary, department) VALUES ('Hari', 45000, 'HR');
INSERT INTO employees (name, salary, department) VALUES ('Sita', 55000, 'Finance');

COMMIT;

-- Select All Employees
SELECT * FROM employees;

-- Select Employees with Salary greater than 48000
SELECT name, salary
FROM employees
WHERE salary > 48000;

-- Update Salary
UPDATE employees
SET salary = 60000
WHERE name = 'Ram';

COMMIT;

-- Delete an Employee
DELETE FROM employees
WHERE name = 'Hari';

COMMIT;

-- Join Query
SELECT e.name, e.salary, d.dept_name
FROM employees e
JOIN departments d
ON e.department = d.dept_name;

-- String Concatenation
SELECT name || ' works in ' || department AS info
FROM employees;

-- Current Date
SELECT SYSDATE FROM dual;

-- Limit Rows
SELECT *
FROM employees
FETCH FIRST 2 ROWS ONLY;

-- Simple Calculation
SELECT 10 + 20 FROM dual;




