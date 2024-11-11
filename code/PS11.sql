-- Create the Borrower table
CREATE TABLE Borrower (
    Rollin INT PRIMARY KEY,  -- Rollin (Student ID)
    name VARCHAR2(30),       -- Name of the student
    dateofissue DATE,        -- Date when the book was issued
    nameofbook VARCHAR2(30), -- Name of the book
    status CHAR(10)          -- Status of the book (e.g., 'Issued', 'Returned')
);

-- Drop the existing Library_Audit table if it exists
DROP TABLE Library_Audit;

-- Create the Library_Audit table
CREATE TABLE Library_Audit (
    Rollin INT,              -- Rollin (Student ID)
    name CHAR(10),           -- Name of the student (limited to 10 chars)
    dateofissue DATE,        -- Date when the book was issued
    nameofbook VARCHAR2(30), -- Name of the book (increased to 30 chars)
    status CHAR(10),         -- Status of the book (e.g., 'Issued', 'Returned')
    ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp of the change
);

-- Insert sample data into Borrower table
INSERT INTO Borrower (Rollin, name, dateofissue, nameofbook, status)
VALUES (101, 'Alice', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'Database Systems', 'Issued');

INSERT INTO Borrower (Rollin, name, dateofissue, nameofbook, status)
VALUES (102, 'Bob', TO_DATE('2024-09-15', 'YYYY-MM-DD'), 'Algorithms', 'Issued');

INSERT INTO Borrower (Rollin, name, dateofissue, nameofbook, status)
VALUES (103, 'Charlie', TO_DATE('2024-08-10', 'YYYY-MM-DD'), 'Operating Systems', 'Issued');

-- Select all records from Borrower table
SELECT * FROM Borrower;

-- Select all records from Library_Audit table
SELECT * FROM Library_Audit;

-- Trigger for After Update on Borrower Table
CREATE OR REPLACE TRIGGER after_update_borrower
AFTER UPDATE ON Borrower
FOR EACH ROW
BEGIN
    -- Insert old values (before the update) into the Library_Audit table
    INSERT INTO Library_Audit (Rollin, name, dateofissue, nameofbook, status, ts)
    VALUES (:OLD.Rollin, :OLD.name, :OLD.dateofissue, :OLD.nameofbook, :OLD.status, CURRENT_TIMESTAMP);
END;
/

-- Trigger for After Delete on Borrower Table
CREATE OR REPLACE TRIGGER after_delete_borrower
AFTER DELETE ON Borrower
FOR EACH ROW
BEGIN
    -- Insert old values (before the delete) into the Library_Audit table
    INSERT INTO Library_Audit (Rollin, name, dateofissue, nameofbook, status, ts)
    VALUES (:OLD.Rollin, :OLD.name, :OLD.dateofissue, :OLD.nameofbook, :OLD.status, CURRENT_TIMESTAMP);
END;
/

-- Update status of the book for Rollin = 101
UPDATE Borrower
SET status = 'Returned'
WHERE Rollin = 101 AND nameofbook = 'Database Systems';

-- Delete the record for Rollin = 101 and nameofbook = 'Database Systems'
DELETE FROM Borrower
WHERE Rollin = 101 AND nameofbook = 'Database Systems';

-- Check the data in Library_Audit table after operations
SELECT * FROM Library_Audit;