-- Create the database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS University;
USE University;

-- Create the Student table
CREATE TABLE Student (
    stud_id INT PRIMARY KEY,
    deptnm VARCHAR(50),
    sem INT,
    name VARCHAR(100),
    yr INT,
    credits INT
);

-- Create the Teaches table
CREATE TABLE Teaches (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(100),
    salary DECIMAL(10, 2),
    deptnm VARCHAR(50)
);

-- Insert records into Student table
INSERT INTO Student (stud_id, deptnm, sem, name, yr, credits) VALUES
(1, 'Comp', 3, 'John Doe', 2022, 30),
(2, 'Comp', 2, 'Jane Smith', 2023, 24),
(3, 'Mech', 1, 'Will Johnson', 2024, 15);

-- Insert records into Teaches table
INSERT INTO Teaches (teacher_id, teacher_name, salary, deptnm) VALUES
(1, 'Dr. Brown', 5000, 'Comp'),
(2, 'Dr. Green', 3000, 'Mech'),
(3, 'Dr. Black', 1500, 'Comp');

-- Update records on Student table (change department name 'Comp' to 'IT')
UPDATE Student
SET deptnm = 'IT'
WHERE deptnm = 'Comp';

-- Find the department that has the highest average salary
SELECT deptnm
FROM Teaches
GROUP BY deptnm
ORDER BY AVG(salary) DESC
LIMIT 1;

-- Delete the records of all teachers with salary below 2000
DELETE FROM Teaches
WHERE salary < 2000;

-- Find the sum of salary of each department
SELECT deptnm, SUM(salary) AS total_salary
FROM Teaches
GROUP BY deptnm;