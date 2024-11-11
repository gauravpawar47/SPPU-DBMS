-- Create the database
CREATE DATABASE EMP3;
USE EMP3;

-- Create the employee table
CREATE TABLE employee (
    employee_name VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50),
    PRIMARY KEY (employee_name)
);

-- Create the works table
CREATE TABLE works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary INT,
    PRIMARY KEY (employee_name, company_name),
    FOREIGN KEY (employee_name) REFERENCES employee(employee_name)
);

-- Create the company table
CREATE TABLE company (
    company_name VARCHAR(50),
    city VARCHAR(50),
    PRIMARY KEY (company_name)
);

-- Create the manages table
CREATE TABLE manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50),
    PRIMARY KEY (employee_name, manager_name)
);

-- Insert records into employee table
INSERT INTO employee (employee_name, street, city) VALUES
('Alice', '123 Main St', 'New York'),
('Bob', '456 Elm St', 'Los Angeles'),
('Charlie', '789 Maple Ave', 'Chicago'),
('David', '101 Oak St', 'New York'),
('Eve', '202 Pine St', 'Chicago');

-- Insert records into company table
INSERT INTO company (company_name, city) VALUES
('First Bank Corporation', 'New York'),
('Tech Solutions', 'Los Angeles'),
('Finance Corp', 'Chicago'),
('Marketing Experts', 'New York'),
('Innovatech', 'San Francisco');

-- Insert records into works table
INSERT INTO works (employee_name, company_name, salary) VALUES
('Alice', 'First Bank Corporation', 12000),
('Bob', 'Tech Solutions', 15000),
('Charlie', 'Finance Corp', 18000),
('David', 'Marketing Experts', 14000),
('Eve', 'First Bank Corporation', 9000);

-- Insert records into manages table
INSERT INTO manages (employee_name, manager_name) VALUES
('Alice', 'David'),
('Bob', 'Charlie'),
('Charlie', 'Bob'),
('David', 'Eve'),
('Eve', 'Alice');

-- Find names, street addresses, and cities of residence for all employees who work for 'First Bank Corporation' and earn more than $10,000
SELECT e.employee_name, e.street, e.city
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'First Bank Corporation' AND w.salary > 10000;

-- Find names of all employees who live in the same cities as the companies for which they work
SELECT DISTINCT e.employee_name
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
JOIN company c ON w.company_name = c.company_name
WHERE e.city = c.city;

-- Find average salary of employees of 'First Bank Corporation'
SELECT AVG(salary) AS average_salary
FROM works
WHERE company_name = 'First Bank Corporation';

-- Give employees of 'First Bank Corporation' a 15% raise if their salary is less than $20,000
UPDATE works
SET salary = salary * 1.15
WHERE company_name = 'First Bank Corporation' AND salary < 20000;