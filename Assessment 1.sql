

-- Step 0: Create the HR database and use it
CREATE DATABASE IF NOT EXISTS HR_DB;
USE HR_DB;

-- Step 1: Create Employees table
DROP TABLE  Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

-- Step 2: Insert sample data
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
(1, 'John', 'Doe', 'HR', 5000, '2020-01-15'),
(2, 'Jane', 'Smith', 'Finance', 5500, '2019-03-10'),
(3, 'Mike', 'Johnson', 'IT', 6000, '2021-06-20'),
(4, 'Emily', 'Davis', 'Marketing', 5200, '2018-09-05'),
(5, 'Chris', 'Brown', 'Sales', 4800, '2022-02-12'),
(6, 'Anna', 'Taylor', 'IT', 5100, '2020-11-01'),
(7, 'Tom', 'Wilson', 'Finance', 5300, '2019-07-23');

-- ==============================================
-- PART A: BASIC TRANSACTION CONTROL
-- ==============================================

-- Task A1: Increase salary and COMMIT
SELECT '--- PART A1: Increase salary and COMMIT ---' AS Step;

START TRANSACTION;

UPDATE Employees
SET Salary = Salary + 1000
WHERE EmployeeID = 1;

-- Check change inside transaction
SELECT EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE EmployeeID = 1;

COMMIT;

-- Verify data permanently saved
SELECT 'After COMMIT A1' AS Phase, EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE EmployeeID = 1;

-- Task A2: Update department and ROLLBACK
SELECT '--- PART A2: Update department and ROLLBACK ---' AS Step;

START TRANSACTION;

UPDATE Employees
SET Department = 'Marketing'
WHERE EmployeeID = 2;

-- Check change inside transaction
SELECT EmployeeID, FirstName, LastName, Department
FROM Employees
WHERE EmployeeID = 2;

ROLLBACK;

-- Verify rollback
SELECT 'After ROLLBACK A2' AS Phase, EmployeeID, FirstName, LastName, Department
FROM Employees
WHERE EmployeeID = 2;

-- ==============================================
-- PART B: SIMULATED ERROR HANDLING
-- ==============================================

-- MySQL does not have TRY/CATCH. We simulate by using transactions.
SELECT '--- PART B1: Transaction with simulated error ---' AS Step;

START TRANSACTION;

-- Valid update
UPDATE Employees
SET Salary = Salary + 500
WHERE EmployeeID = 3;

-- Intentional error: duplicate primary key
-- To avoid stopping script, comment this out for now.
-- INSERT INTO Employees(EmployeeID, FirstName, LastName, Department, Salary, HireDate)
-- VALUES (1, 'Error', 'Test', 'HR', 5000, NOW());

-- Rollback manually to simulate error handling
ROLLBACK;

SELECT 'After B1' AS Phase, EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE EmployeeID = 3;

-- Task B2: Successful transaction with COMMIT
SELECT '--- PART B2: Successful transaction ---' AS Step;

START TRANSACTION;

UPDATE Employees
SET Salary = Salary + 300
WHERE EmployeeID = 4;

UPDATE Employees
SET Department = 'IT'
WHERE EmployeeID = 5;

COMMIT;

SELECT 'After B2' AS Phase, EmployeeID, FirstName, LastName, Department, Salary
FROM Employees
WHERE EmployeeID IN (4,5);

-- ==============================================
-- PART C: SIMULATED XACT_ABORT BEHAVIOR
-- ==============================================

-- Task C1: Transaction with simulated automatic rollback
SELECT '--- PART C1: Simulated XACT_ABORT ON ---' AS Step;

START TRANSACTION;

UPDATE Employees
SET Salary = Salary + 200
WHERE EmployeeID = 6;

-- Intentional error: duplicate primary key (comment out if you want script to run fully)
-- INSERT INTO Employees(EmployeeID, FirstName, LastName, Department, Salary, HireDate)
-- VALUES (1, 'ErrorC1', 'Test', 'HR', 1000, NOW());

ROLLBACK;

SELECT 'After C1' AS Phase, EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE EmployeeID = 6;

-- Task C2: Partial commit example
SELECT '--- PART C2: Partial commit example ---' AS Step;

-- Run update outside transaction
UPDATE Employees
SET Salary = Salary + 200
WHERE EmployeeID = 7;

-- Intentional error: duplicate PK (commented out to prevent script stop)
-- INSERT INTO Employees(EmployeeID, FirstName, LastName, Department, Salary, HireDate)
-- VALUES (1, 'ErrorC2', 'Test', 'HR', 1000, NOW());

SELECT 'After C2' AS Phase, EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE EmployeeID = 7;

-- ==============================================
-- PART D: REFLECTION (SHORT ANSWERS)
-- ==============================================

/*
1. Transactions maintain data consistency and atomicity.
2. Without transactions, partial updates could corrupt HR data.
3. ROLLBACK is used to undo changes when errors or invalid data occur.
*/

SELECT 'Script completed. Review all outputs above.' AS Message;
