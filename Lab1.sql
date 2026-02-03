#1.	Create a database named dbemp and switch to it.
create database dbemp;
use dbemp;
#2.	Create an employee table with appropriate data types 
#and constraints for employee details.
create table employee(
		EmployeeID varchar(20) NOT NULL PRIMARY KEY,
        FirstName varchar(20),
        LastName varchar(20),
        Gender char(1),
        DateofBirth DATE,
        Designation varchar(50),
        DepartmentName varchar(20),
        ManagerId varchar(20),
        JoinedDate DATE,
        Salary decimal(10,0)
);
#3.	Insert at least two employee records into the employee table.
insert into employee (
EmployeeID,FirstName,LastName,Gender,DateofBirth,Designation,
DepartmentName,ManagerId,JoinedDate,Salary)
values (
'0009','Season','Maharjan','M','1996-04-02','Engineer',
'Software Engineering', '0005','2022-04-02','5000000'
),(
'0010','Ramesh','Rai','M','2000-04-02','Manager',
'Software Engineering', '0003','2022-04-02','1000000'
);
select * from employee;

#4. Update the hender of an employee whose emmployee 
use dbemp;
update employee
set Gender = 'M'
Where EmployeeID = '0009';

#5. Display the first name, current date, date of birth, and age of employee who ae older than 30 years.
select Firstname, curdate() as currentDate,
DateofBirth,
timestampdiff(year, DateofBirth, curdate()) as Age
from employee
where timestampdiff(year, DateofBirth, curdate())> 25;

#6. Write a query to find the oldest employee.
select * from employee
where DateofBirth = (select MIN(DateofBirth)
from employee);
#7 yongest employee
select * from employee
where DateofBirth = (select max(DateofBirth)
from employee);
#8 Display the maximum salary department-wise 
select DepartmentNaame, max(Salary) as Maxsalary
from employee Group by departmentName;
#9 list tthe employees whon act as managers.
select * from employee;
select FirstName from employee where
EmployeeID in (Select ManagerID from employee);
#10 11 Display the details of the most recently joined emplyoee
select * from employee;
use dbemp;
insert INTO employee (
EmployeeID, FirstName, LastName, Gender, DateofBirth,
Designation, DepartmentName, ManagerId, JoinedDate, Salary
)
VALUES
('0012','Anil','Karki','M','1998-09-18',
'Accountant','Finance','0010','2024-02-10',700000);
select * from employee;

