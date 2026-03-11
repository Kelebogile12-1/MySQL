
USE HR_DB;


SELECT Department, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Department;


SELECT Department, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department;


SELECT Department, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department;


SELECT YEAR(HireDate) AS HireYear, COUNT(*) AS EmployeesHired
FROM Employees
GROUP BY YEAR(HireDate);

SELECT MAX(Salary) AS HighestSalary FROM Employees;
SELECT MIN(Salary) AS LowestSalary FROM Employees;
SELECT AVG(Salary) AS AverageSalary FROM Employees;


SELECT COUNT(DISTINCT Department) AS DistinctDepartments FROM Employees;

SELECT Department, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 1;


SELECT Department, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department
HAVING AVG(Salary) > 60000;


SELECT *
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

SELECT *
FROM Employees
WHERE HireDate > (SELECT MIN(HireDate) FROM Employees);

SELECT *
FROM Employees
WHERE Salary > (SELECT MAX(Salary) - 10000 FROM Employees);


SELECT *
FROM Employees
WHERE Department IN (SELECT Department FROM Employees WHERE Salary > 70000);


SELECT e1.*
FROM Employees e1
WHERE EXISTS (
    SELECT 1
    FROM Employees e2
    WHERE e2.Department = e1.Department AND e2.Salary > e1.Salary
);


SELECT *
FROM Employees e
WHERE EXISTS (
    SELECT 1
    FROM Employees
    WHERE Bonus IS NOT NULL AND Department = e.Department
);


CREATE OR REPLACE VIEW EmployeeSummary AS
SELECT CONCAT(FirstName, ' ', LastName) AS FullName, Department, Salary
FROM Employees;


SELECT Department, AVG(Salary) AS AvgSalary
FROM (SELECT * FROM Employees) AS SubEmployees
GROUP BY Department;


WITH DeptSummary AS (
    SELECT Department, SUM(Salary) AS TotalSalary, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY Department
)
SELECT e.EmployeeID, e.FirstName, e.LastName, ds.TotalSalary, ds.AvgSalary
FROM Employees e
JOIN DeptSummary ds ON e.Department = ds.Department
WHERE ds.AvgSalary > 60000;


SELECT * FROM Employees WHERE Department='IT'
UNION
SELECT * FROM Employees WHERE Department='HR';

SELECT * FROM Employees WHERE Department='IT'
UNION ALL
SELECT * FROM Employees WHERE Department='HR';


SELECT * FROM Employees e1
WHERE Department='IT' AND EmployeeID NOT IN (
    SELECT EmployeeID FROM Employees WHERE Department='HR'
);


SELECT * FROM Employees e1
WHERE Department='IT' AND EmployeeID IN (
    SELECT EmployeeID FROM Employees WHERE Department='HR'
);


SELECT EmployeeID, FirstName, LastName, Department, Salary,
       RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
FROM Employees;


SELECT EmployeeID, FirstName, LastName, HireDate,
       ROW_NUMBER() OVER (ORDER BY HireDate) AS RowNum
FROM Employees;


SELECT EmployeeID, FirstName, Department, Salary,
       LAG(Salary) OVER (PARTITION BY Department ORDER BY Salary) AS PrevSalary,
       LEAD(Salary) OVER (PARTITION BY Department ORDER BY Salary) AS NextSalary
FROM Employees;


SELECT EmployeeID, Department, Salary,
       SUM(Salary) OVER (ORDER BY Salary) AS RunningTotalSalary
FROM Employees;


SELECT EmployeeID, Department, Salary,
       SUM(Salary) OVER (PARTITION BY Department) AS DeptTotalSalary
FROM Employees;


SELECT
    SUM(CASE WHEN Department='IT' THEN Salary ELSE 0 END) AS IT_Salary,
    SUM(CASE WHEN Department='HR' THEN Salary ELSE 0 END) AS HR_Salary,
    SUM(CASE WHEN Department='Finance' THEN Salary ELSE 0 END) AS Finance_Salary,
    SUM(CASE WHEN Department='Marketing' THEN Salary ELSE 0 END) AS Marketing_Salary
FROM Employees;


SELECT Department, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department WITH ROLLUP;



DROP PROCEDURE IF EXISTS GetEmployeesByDept;
DELIMITER $$
CREATE PROCEDURE GetEmployeesByDept(IN deptName VARCHAR(50))
BEGIN
    SELECT * FROM Employees WHERE Department = deptName;
END $$
DELIMITER ;

-- Execute procedure
CALL GetEmployeesByDept('IT');
CALL GetEmployeesByDept('HR');

DROP PROCEDURE IF EXISTS LoopExample;
DELIMITER $$
CREATE PROCEDURE LoopExample()
BEGIN
    DECLARE counter INT DEFAULT 1;
    WHILE counter <= 5 DO
        SELECT CONCAT('Iteration ', counter) AS Message;
        SET counter = counter + 1;
    END WHILE;
END $$
DELIMITER ;

CALL LoopExample();


SET @dept = 'IT';
SET @sql = CONCAT('SELECT * FROM Employees WHERE Department = ''', @dept, '''');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



DROP PROCEDURE IF EXISTS SafeInsertEmployee;
DELIMITER $$
CREATE PROCEDURE SafeInsertEmployee(
    IN eID INT, IN fName VARCHAR(50), IN lName VARCHAR(50),
    IN mail VARCHAR(100), IN dept VARCHAR(50), IN sal DECIMAL(10,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Could not insert employee. Check data or duplicate ID.' AS ErrorMessage;
    END;

    INSERT INTO Employees(EmployeeID, FirstName, LastName, Email, Department, Salary)
    VALUES (eID, fName, lName, mail, dept, sal);
END $$
DELIMITER ;

-- Test error handling
CALL SafeInsertEmployee(6, 'Tom', 'Wilson', 'tom.wilson@example.com', 'Finance', 65000);
CALL SafeInsertEmployee(1, 'Duplicate', 'Test', 'dup@example.com', 'IT', 50000);  -- triggers handler
