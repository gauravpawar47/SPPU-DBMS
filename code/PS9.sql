-- Drop tables if they exist
DROP TABLE stud21 CASCADE CONSTRAINTS;
DROP TABLE d_stud CASCADE CONSTRAINTS;


CREATE TABLE stud21 (
    roll NUMBER PRIMARY KEY,
    att NUMBER,
    status VARCHAR2(10)
);


INSERT INTO stud21 (roll, att, status) VALUES (101, 70, 'Active');
INSERT INTO stud21 (roll, att, status) VALUES (102, 80, 'Active');
INSERT INTO stud21 (roll, att, status) VALUES (103, 60, 'Active');
INSERT INTO stud21 (roll, att, status) VALUES (104, 90, 'Active');
INSERT INTO stud21 (roll, att, status) VALUES (105, 50, 'Active');


CREATE TABLE d_stud (
    roll NUMBER,
    att NUMBER
);




DECLARE
    -- Declare the cursor to select students with attendance below 75
    CURSOR crsr_att IS
        SELECT roll, att, status
        FROM stud21
        WHERE att < 75;

    -- Declare variables to store fetched values from the cursor
    mroll stud21.roll%TYPE;
    matt stud21.att%TYPE;
    mstatus stud21.status%TYPE;
BEGIN
    -- Open the cursor
    OPEN crsr_att;

    -- Loop through the cursor rows
    LOOP
        FETCH crsr_att INTO mroll, matt, mstatus;
        
        -- Exit the loop if no more rows are found
        EXIT WHEN crsr_att%NOTFOUND;

        -- If a record is found, update the status and insert into d_stud
        IF crsr_att%FOUND THEN
            -- Update the status for the student in stud21
            UPDATE stud21
            SET status = 'D'
            WHERE roll = mroll;

            -- Insert the roll and attendance into d_stud table
            INSERT INTO d_stud (roll, att)
            VALUES (mroll, matt);
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE crsr_att;
END;
/

SELECT * FROM stud21;
SELECT * FROM d_stud;