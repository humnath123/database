-- Create Database
CREATE DATABASE IF NOT EXISTS w3_practice_db;
USE w3_practice_db;

-- Drop tables if already exist (to avoid errors)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

-- Create Customers Table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50)
);

-- Create Orders Table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    amount INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert into Customers
INSERT INTO customers (customer_name, city, country) VALUES
('Ram', 'Kathmandu', 'Nepal'),
('Sita', 'Pokhara', 'Nepal'),
('John', 'New York', 'USA'),
('Aman', 'Delhi', 'India');

-- Insert into Orders
INSERT INTO orders (customer_id, product, amount) VALUES
(1, 'Laptop', 800),
(1, 'Mouse', 20),
(2, 'Mobile', 500),
(3, 'Keyboard', 50),
(4, 'Monitor', 200);

-- SELECT all customers
SELECT * FROM customers;

-- WHERE condition
SELECT * FROM customers WHERE country = 'Nepal';

-- ORDER BY
SELECT * FROM customers ORDER BY customer_name ASC;

-- UPDATE
UPDATE customers SET city = 'Lalitpur' WHERE customer_name = 'Ram';

-- DELETE
DELETE FROM customers WHERE customer_name = 'Aman';

-- GROUP BY
SELECT country, COUNT(*) AS total_customers
FROM customers
GROUP BY country;

-- INNER JOIN
SELECT 
    c.customer_name, 
    c.country, 
    o.product, 
    o.amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- LEFT JOIN
SELECT 
    c.customer_name, 
    o.product
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- Total order amount by customer
SELECT 
    c.customer_name,
    SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- BETWEEN
SELECT * FROM orders WHERE amount BETWEEN 100 AND 600;

-- LIKE
SELECT * FROM customers WHERE customer_name LIKE 'J%';

-- IN
SELECT * FROM customers WHERE country IN ('Nepal', 'USA');