-- Create the O_RollCall table (Original Roll Call)
CREATE TABLE O_RollCall (
    roll NUMBER PRIMARY KEY,
    name VARCHAR2(50)
);

-- Insert sample data into O_RollCall table
INSERT INTO O_RollCall (roll, name) VALUES (101, 'John');
INSERT INTO O_RollCall (roll, name) VALUES (102, 'Alice');
INSERT INTO O_RollCall (roll, name) VALUES (103, 'Bob');
INSERT INTO O_RollCall (roll, name) VALUES (104, 'Charlie');
INSERT INTO O_RollCall (roll, name) VALUES (105, 'David');

-- Create the N_RollCall table (New Roll Call)
CREATE TABLE N_RollCall (
    roll NUMBER PRIMARY KEY,
    name VARCHAR2(50)
);

DECLARE
    -- Cursor to select all records from O_RollCall table
    CURSOR crsr_class IS 
        SELECT * FROM O_RollCall;

    -- Cursor to check if the name exists in N_RollCall
    CURSOR crsr_chk(str_name VARCHAR) IS 
        SELECT roll FROM N_RollCall WHERE name = str_name;

    -- Variables to store fetched data
    str_roll N_RollCall.roll%TYPE;
    str_name N_RollCall.name%TYPE;
    v VARCHAR(10);
BEGIN
    -- Open the crsr_class cursor to fetch records from O_RollCall
    OPEN crsr_class;

    LOOP
        -- Fetch data from crsr_class into str_roll and str_name
        FETCH crsr_class INTO str_roll, str_name;
        EXIT WHEN crsr_class%NOTFOUND;  -- Exit loop when no more records are found

        -- Open the crsr_chk cursor to check if the name exists in N_RollCall
        OPEN crsr_chk(str_name);
        FETCH crsr_chk INTO v;

        -- If name exists in N_RollCall, display a message
        IF crsr_chk%FOUND THEN
            dbms_output.put_line('Branch ' || str_name || ' exists');
        ELSE
            -- If name does not exist, insert it into N_RollCall
            dbms_output.put_line('Branch ' || str_name || ' not exist. Inserting into N_RollCall table');
            INSERT INTO N_RollCall (roll, name) VALUES (str_roll, str_name);
        END IF;

        -- Close the crsr_chk cursor
        CLOSE crsr_chk;
    END LOOP;

    -- Close the crsr_class cursor
    CLOSE crsr_class;
END;
/

-- To view the contents of N_RollCall table after execution
SELECT * FROM N_RollCall;