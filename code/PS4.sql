-- Create the database
CREATE DATABASE EMP2;
USE EMP2;

-- Create Dept table with primary key
CREATE TABLE Dept (
    deptId INT PRIMARY KEY,
    deptName VARCHAR(10)
);

-- Create Emp table with primary key and foreign key
CREATE TABLE Emp (
    empId INT PRIMARY KEY,
    empName VARCHAR(10) NOT NULL,
    empSal INT,
    empDeptId INT,
    FOREIGN KEY (empDeptId) REFERENCES Dept(deptId)
);

-- Insert records into Dept table
INSERT INTO Dept (deptId, deptName) VALUES
(10, 'HR'),
(20, 'IT'),
(30, 'Finance'),
(40, 'Marketing');

-- Insert records into Emp table
INSERT INTO Emp (empId, empName, empSal, empDeptId) VALUES
(101, 'Alice', 25000, 10),
(102, 'Bob', 18000, 20),
(103, 'Charlie', 15000, 30),
(104, 'David', 12000, 40),
(105, 'Eve', 30000, 10);

-- List employees belonging to department 30, 40, or 10:
SELECT *
FROM Emp
WHERE empDeptId IN (30, 40, 10);

-- List the employee details whose salary is between 10000 and 30000:
SELECT *
FROM Emp
WHERE empSal BETWEEN 10000 AND 30000;

-- List total number of employees:
SELECT COUNT(*) AS total_employees
FROM Emp;

-- List average salary of each department:
SELECT empDeptId, AVG(empSal) AS average_salary
FROM Emp
GROUP BY empDeptId;


-- List employee details in ascending order of salary:
SELECT *
FROM Emp
ORDER BY empSal ASC;