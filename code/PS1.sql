-- Create branch_master table
CREATE TABLE branch_master (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL
);

-- Create employee_master table with self-referencing foreign key
CREATE TABLE employee_master (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(100),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employee_master(emp_id)
);

-- Insert records into branch_master table
INSERT INTO branch_master (branch_id, branch_name) VALUES (1, 'Sales');
INSERT INTO branch_master (branch_id, branch_name) VALUES (2, 'Marketing');
INSERT INTO branch_master (branch_id, branch_name) VALUES (3, 'HR');
INSERT INTO branch_master (branch_id, branch_name) VALUES (4, 'Finance');

-- Insert records into employee_master table
INSERT INTO employee_master (emp_id, first_name, middle_name, last_name, department, manager_id) VALUES (1, 'John', 'A.', 'Doe', 'Sales', NULL);
INSERT INTO employee_master (emp_id, first_name, middle_name, last_name, department, manager_id) VALUES (2, 'Jane', 'B.', 'Smith', 'Marketing', 1);
INSERT INTO employee_master (emp_id, first_name, middle_name, last_name, department, manager_id) VALUES (3, 'Jim', 'C.', 'Brown', 'HR', 1);
INSERT INTO employee_master (emp_id, first_name, middle_name, last_name, department, manager_id) VALUES (4, 'Jake', 'D.', 'White', 'Finance', 2);

-- Create an index on first_name and last_name columns
CREATE INDEX idx_emp_name ON employee_master (first_name, last_name);

-- Create a view employee_details with corrected concatenation for Oracle
CREATE VIEW employee_details AS
SELECT 
    emp_id, 
    first_name || ' ' || middle_name || ' ' || last_name AS full_name, 
    department, 
    manager_id
FROM 
    employee_master;

-- Select data from the view to confirm it works
SELECT * FROM employee_details;