
CREATE DATABASE  HR_DB;
USE HR_DB;


CREATE TABLE IF NOT EXISTS Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    Bonus DECIMAL(10,2) NULL,
    HireDate DATE
);


INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Department, Salary, Bonus, HireDate)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', 'IT', 70000.00, 5000.00, '2020-03-15'),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', 'HR', 55000.00, NULL, '2019-06-20'),
    (3, 'Alice', 'Brown', 'alice.brown@example.com', 'Finance', 60000.00, 3000.00, '2021-01-10'),
    (4, 'Bob', 'Johnson', 'bob.johnson@example.com', 'IT', 80000.00, NULL, '2018-11-05'),
    (5, 'Eve', 'Davis', 'eve.davis@example.com', 'Marketing', 50000.00, 2000.00, '2022-08-25');




SELECT MAX(Salary) AS HighestSalary FROM Employees;


SELECT MIN(Salary) AS LowestSalary FROM Employees;

SELECT AVG(Salary) AS AverageSalary FROM Employees;


SELECT CURDATE() AS CurrentDate;


SELECT EmployeeID, FirstName, LastName, CAST(Salary AS CHAR) AS SalaryChar
FROM Employees;


SELECT EmployeeID, FirstName, LastName, DATE_FORMAT(HireDate, '%M %d, %Y') AS FormattedHireDate
FROM Employees;

SELECT EmployeeID, FirstName, LastName, CONCAT('Salary: $', Salary) AS SalaryString
FROM Employees;


SELECT EmployeeID, FirstName, LastName,
       IF(Salary >= 60000, 'High', 'Low') AS SalaryLevel
FROM Employees;


SELECT EmployeeID, FirstName, LastName,
       IF(Bonus IS NOT NULL, 'Has Bonus', 'No Bonus') AS BonusStatus
FROM Employees;


SELECT EmployeeID, FirstName, LastName, Department,
       CASE 
           WHEN Department = 'IT' THEN 'Tech'
           WHEN Department = 'HR' THEN 'Admin'
           ELSE 'Other'
       END AS DeptCategory
FROM Employees;


SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE Bonus IS NULL;


SELECT EmployeeID, FirstName, LastName,
       IFNULL(Bonus, 0) AS BonusValue
FROM Employees;


SELECT EmployeeID, FirstName, LastName,
       CASE 
           WHEN Bonus IS NULL THEN 'NULL'
           ELSE 'NOT NULL'
       END AS BonusStatus
FROM Employees;
