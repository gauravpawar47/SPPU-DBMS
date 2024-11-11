CREATE TABLE stud_marks (
    roll_no NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    total_marks NUMBER
);

INSERT INTO stud_marks (roll_no, name, total_marks) VALUES (1, 'Alice', 1200);
INSERT INTO stud_marks (roll_no, name, total_marks) VALUES (2, 'Bob', 950);
INSERT INTO stud_marks (roll_no, name, total_marks) VALUES (3, 'Charlie', 850);
INSERT INTO stud_marks (roll_no, name, total_marks) VALUES (4, 'David', 700);
INSERT INTO stud_marks (roll_no, name, total_marks) VALUES (5, 'Eve', 1100);


CREATE TABLE result (
    roll_no NUMBER,
    name VARCHAR2(50),
    grade VARCHAR2(20)
);



-- Creating the procedure
CREATE OR REPLACE PROCEDURE proc_grade(
    temp IN NUMBER, 
    p_roll_no OUT stud_marks.roll_no%TYPE, 
    p_name OUT stud_marks.name%TYPE, 
    p_total OUT stud_marks.total_marks%TYPE
)
AS
BEGIN
    -- Fetching the student details
    SELECT name, total_marks, roll_no 
    INTO p_name, p_total, p_roll_no
    FROM stud_marks
    WHERE roll_no = temp;

    -- Checking the total marks and inserting into the result table
    IF p_total BETWEEN 990 AND 1500 THEN
        INSERT INTO result VALUES (p_roll_no, p_name, 'distinction');
    ELSIF p_total BETWEEN 900 AND 989 THEN
        INSERT INTO result VALUES (p_roll_no, p_name, 'first class');
    ELSIF p_total BETWEEN 825 AND 899 THEN
        INSERT INTO result VALUES (p_roll_no, p_name, 'HSC');
    ELSE
        INSERT INTO result VALUES (p_roll_no, p_name, 'fail');
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Roll no ' || temp || ' not found');
END;
/
-- Anonymous block to execute the procedure
DECLARE
    temp NUMBER := 5; -- Example roll number (replace this with your actual value)
    p_roll_no stud_marks.roll_no%TYPE;
    p_name stud_marks.name%TYPE;
    p_total stud_marks.total_marks%TYPE;
BEGIN
    -- Calling the procedure
    proc_grade(temp, p_roll_no, p_name, p_total);

    -- Optionally, print results for debugging
    dbms_output.put_line('Roll No: ' || p_roll_no);
    dbms_output.put_line('Name: ' || p_name);
    dbms_output.put_line('Total Marks: ' || p_total);
END;
/