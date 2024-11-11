CREATE OR REPLACE PROCEDURE proc_fine (
    i_roll_no IN NUMBER,
    name_of_book IN borrower.name_of_book%TYPE,
    return_date IN DATE
) 
AS
    temp NUMBER;
    doi DATE;
    fine NUMBER;
    no_of_days NUMBER;
BEGIN
    --dbms_output.put_line(return_date);
    SELECT TO_DATE(borrower.dateofissue, 'DD-MM-YYYY') 
    INTO doi 
    FROM borrower 
    WHERE borrower.roll_no = i_roll_no 
    AND borrower.name_of_book = name_of_book;
    
    no_of_days := return_date - doi;
    dbms_output.put_line(no_of_days);
    
    IF (no_of_days > 15 AND no_of_days <= 30) THEN
        fine := 5 * no_of_days;
    ELSIF (no_of_days > 30) THEN
        temp := no_of_days - 30;
        fine := 150 + temp * 50;
    END IF;
    
    dbms_output.put_line(fine);
    
    INSERT INTO fine 
    VALUES (i_roll_no, return_date, fine);
    
    UPDATE borrower 
    SET status = 'RETURNED' 
    WHERE borrower.roll_no = i_roll_no;
    
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Book ' || name_of_book || ' not found');
END;
/

DECLARE
    i_roll_no NUMBER := 45; -- Example Roll No
    name_of_book VARCHAR2(25) := 'HARRY POTTER'; -- Example Book Name
    return_date DATE := TO_DATE(SYSDATE, 'DD-MM-YYYY'); -- Current Date
BEGIN
    proc_fine(i_roll_no, name_of_book, return_date);
END;
/