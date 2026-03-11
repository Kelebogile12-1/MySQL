

-- Task A1: Increase salary with COMMIT
SELECT '--- PART A1: Increase salary and COMMIT ---';

START TRANSACTION;

UPDATE Employees
SET Salary = Salary + 1000
WHERE EmployeeID = 1;

-- Verify inside transaction
SELECT 'Inside TX A1' AS Phase, EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE EmployeeID = 1;

COMMIT;

-- Verify permanently saved
SELECT 'After COMMIT A1' AS Phase, EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE EmployeeID = 1;


-- Task A2: Update department with ROLLBACK
SELECT '--- PART A2: Update department and ROLLBACK ---';

START TRANSACTION;

UPDATE Employees
SET Department = 'Marketing'
WHERE EmployeeID = 2;

-- Verify inside transaction
SELECT 'Inside TX A2' AS Phase, EmployeeID, FirstName, LastName, Department
FROM Employees
WHERE EmployeeID = 2;

ROLLBACK;

-- Verify rollback
SELECT 'After ROLLBACK A2' AS Phase, EmployeeID, FirstName, LastName, Department
FROM Employees
WHERE EmployeeID = 2;


-------------------
/**************** PART B: SIMULATED ERROR HANDLING ****************/

-- Task B1: Simulate error with duplicate PK (MySQL has no TRY/CATCH)
SELECT '--- PART B1: Simulated error transaction ---';

START TRANSACTION;

-- Valid update
UPDATE Employees
SET Salary = Salary + 500
WHERE EmployeeID = 3;

-- Simulate error: insert duplicate primary key
INSERT INTO Employees(EmployeeID, FirstName, LastName, Department, Salary, HireDate)
SELECT EmployeeID, 'Error','Test','HR',5000,NOW()
FROM Employees
WHERE EmployeeID = 1; -- duplicate PK triggers error

-- Check for error
-- In MySQL Workbench, execution will stop and rollback is needed manually
ROLLBACK;

SELECT 'After B1' AS Phase, EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE EmployeeID = 3;


-- Task B2: Successful transaction
SELECT '--- PART B2: Successful transaction ---';

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


-------------------
/**************** PART C: SIMULATED XACT_ABORT ****************/

-- MySQL does not have XACT_ABORT, but we can simulate behavior using ROLLBACK on errors
SELECT '--- PART C1: Simulated XACT_ABORT ON ---';

START TRANSACTION;

-- Valid update
UPDATE Employees
SET Salary = Salary + 200
WHERE EmployeeID = 6;

-- Intentional error: duplicate PK
INSERT INTO Employees(EmployeeID, FirstName, LastName, Department, Salary, HireDate)
SELECT EmployeeID, 'ErrorC1','Test','HR',1000,NOW()
FROM Employees
WHERE EmployeeID = 1;

-- Rollback manually since MySQL stops execution on duplicate PK
ROLLBACK;

SELECT 'After C1' AS Phase, EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE EmployeeID = 6;


-- Task C2: Simulated XACT_ABORT OFF
-- In MySQL, partial changes before an error may remain if not in a transaction
SELECT '--- PART C2: Simulated XACT_ABORT OFF ---';

-- Here, we execute updates outside a transaction to show partial commit
UPDATE Employees
SET Salary = Salary + 200
WHERE EmployeeID = 7;

-- Intentional error: duplicate PK, execution stops here, but previous update is already applied
INSERT INTO Employees(EmployeeID, FirstName, LastName, Department, Salary, HireDate)
SELECT EmployeeID, 'ErrorC2','Test','HR',1000,NOW()
FROM Employees
WHERE EmployeeID = 1;

-- Check what changed
SELECT 'After C2' AS Phase, EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE EmployeeID = 7;


-------------------
/**************** PART D: REFLECTION ****************/
-- 1. Transactions maintain data consistency and atomicity.
-- 2. Without transactions, partial updates could corrupt HR data.
-- 3. ROLLBACK is used to undo changes when errors or invalid data occur.

SELECT 'Script completed. Review SELECT outputs for verification.';

