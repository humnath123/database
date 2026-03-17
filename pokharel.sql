-- Create database
CREATE DATABASE bankdb;

-- Use the database
USE bankdb;

-- Create accounts table
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL
);
INSERT INTO accounts (account_id, account_holder, balance)
VALUES 
(1, 'ram', 50000),
(2, 'shyam', 30000),
(3, 'sita', 20000);
START TRANSACTION;

-- Deduct 5000 from Ram's account
UPDATE accounts
SET balance = balance - 5000
WHERE account_holder = 'ram';

-- Add 5000 to Shyam's account
UPDATE accounts
SET balance = balance + 5000
WHERE account_holder = 'shyam';

COMMIT;
select * from accounts;
START TRANSACTION;

-- Deduct 5000 from Ram's account
UPDATE accounts
SET balance = balance - 10000
WHERE account_holder = 'shyam';

-- Add 5000 to Shyam's account
UPDATE accounts
SET balance = balance + 10000
WHERE account_holder = 'sita';

rollback;
select * from accounts;
START TRANSACTION;

-- Step 1: Deduct 2000 from Ram
UPDATE accounts
SET balance = balance - 2000
WHERE account_holder = 'ram';

-- Create a savepoint
SAVEPOINT after_ram_update;

-- Step 2: Add 2000 to Shyam
UPDATE accounts
SET balance = balance + 2000
WHERE account_holder = 'shyam';

-- Step 3: Add 1000 to Sita
UPDATE accounts
SET balance = balance + 1000
WHERE account_holder = 'sita';

-- Rollback only to the savepoint
ROLLBACK TO after_ram_update;

-- Finalize the transaction
COMMIT;

-- Check results
SELECT * FROM accounts;

-- --triggers
START TRANSACTION;

-- Step 1: Deduct 2000 from Ram
UPDATE accounts
SET balance = balance - 2000
WHERE account_holder = 'ram';

-- Create a savepoint
SAVEPOINT after_ram_update;

-- Step 2: Add 2000 to Shyam
UPDATE accounts
SET balance = balance + 2000
WHERE account_holder = 'shyam';

-- Step 3: Add 1000 to Sita
UPDATE accounts
SET balance = balance + 1000
WHERE account_holder = 'sita';

-- Rollback only to the savepoint
ROLLBACK TO after_ram_update;

-- Finalize the transaction
COMMIT;

-- Check results
SELECT * FROM accounts;
INSERT INTO employee VALUES (1, 'Ram', 8000);
INSERT INTO employee VALUES (2, 'Shyam', 15000);
SELECT * FROM employee;

-- create table salry_log( 
-- log_id int auto_increment primary key,
-- emp_id int,
-- old_salary decimal(10,2),
-- new_salary decimal(10,2),
-- updated_at timestamp default current_timestamp)
#create a before insert trigger on employees that prevents inserting employees whose salary is less than 1000
# delimiter $$  create trigger
# check_salary 
#brefore insert on employees
 #for each 
 #begin
 #if new.salary<10000 then 
 # signal sqlstate'45000'
 #set message_text = 'salary must be aleast 10000';
 #end if
 #end $$
 #Delimiter;
 /* create an after update trigger on employees that records salary charges into the salary_log table
 delimiter $$
 create triggers log_salary_update
 after update on employees 
 for each row
 begin
 insert into salary_log(emp_id, old_salary, new_salary)
values(old.emp_id, old.salary, new.salary);
end$$
Delimiter;
create procedure getEmployees()
Begin
select * from employees;
end
$$
Delimiter;
call getEmployees();
create a stored proccedure that inserts a new employee intp the employees table using parameters
delimiter$$
create procedure addEmployee(int, in p_name varchar(100), 
in p_id,in p_salary decimal(10,2) )
begin
insert into employees values(p_id,p_name,p_salary);
end $$$
Delimitee;
call addEmployee(5,'Hari',20000);
create a stored procedure that updates the salary of an employee based on employee ID.
Delimiter $$
create procedure updateSalary(
in p_id int, in new_salary decimal(10,2))
begin
update employees
set salary = new_salary
where emp_id = p_id;
end $$
Delimiter;
call updateSalary(1,30000);
create a stored procedure that transfers money between two accounts using a transaction.
DELIMITER $$

CREATE PROCEDURE transferMoney(
    IN p_sender_id INT, 
    IN p_receiver_id INT, 
    IN p_amount DECIMAL(10,2)
)
BEGIN
    DECLARE current_balance DECIMAL(10,2);

    -- Start the transaction
    START TRANSACTION;

    -- Check if sender has enough balance
    SELECT balance INTO current_balance 
    FROM accounts 
    WHERE account_id = p_sender_id;

    IF current_balance >= p_amount THEN
        -- Deduct from sender
        UPDATE accounts 
        SET balance = balance - p_amount 
        WHERE account_id = p_sender_id;

        -- Add to receiver
        UPDATE accounts 
        SET balance = balance + p_amount 
        WHERE account_id = p_receiver_id;

        -- If everything is fine, commit changes
        COMMIT;
    ELSE
        -- If insufficient funds, cancel everything
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Transaction failed: Insufficient funds';
    END IF;
END $$

DELIMITER ;

