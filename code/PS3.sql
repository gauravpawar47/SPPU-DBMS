-- Create the database
CREATE DATABASE EMP1;
USE EMP1;

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
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

-- Insert records into Emp table
INSERT INTO Emp (empId, empName, empSal, empDeptId) VALUES
(101, 'Alice', 5000, 2),
(102, 'Bob', 4500, 1),
(103, 'Charlie', 5500, 3);

-- Add column deptLoc to Dept table
ALTER TABLE Dept
ADD COLUMN deptLoc VARCHAR(10);

-- Add unique constraint to deptLoc column
ALTER TABLE Dept
ADD CONSTRAINT unique_deptLoc UNIQUE (deptLoc);

-- Insert values including the new deptLoc column
UPDATE Dept SET deptLoc = 'BLR' WHERE deptId = 1;
UPDATE Dept SET deptLoc = 'PUN' WHERE deptId = 2;
UPDATE Dept SET deptLoc = 'DEL' WHERE deptId = 3;