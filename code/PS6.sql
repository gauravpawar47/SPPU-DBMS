-- Create the database
CREATE DATABASE EMP4;
USE EMP4;


create table employee(
    emp_name VARCHAR(100), 
    street VARCHAR(100), 
    city VARCHAR(100)
);

create table work(
    name VARCHAR(100), 
    company VARCHAR(100), 
    salary int
);

create table company(
    cname VARCHAR(100), 
    city VARCHAR(100)
);

create table manages(
    name VARCHAR(100), 
    manager VARCHAR(100)
);

insert into employee 
    values('Rohit', 'Pimpri', 'Pune');

insert into work 
    values('Rohit', 'SKF', 20000);

INSERT INTO company 
    VALUES('SKF', 'Pune');

insert into manages 
    values('Rohit', 'Tejas');

insert into employee 
    values('Rahul', 'akurdi', 'Mumbai');

insert into work 
    values('Rahul', 'First Bank Corporation', 20500);

INSERT INTO company 
    VALUES('First Bank Corporation', 'Mumbai');

insert into manages 
    values('Rahul', 'Rohit');

insert into employee 
    values('Pittu', 'AKURDI', 'Pune');

insert into work 
    values('Pittu', 'Small Bank Corporation', 5000);

INSERT INTO company 
    VALUES('Small Bank Corporation', 'Pune');

insert into manages 
    values('Pittu', 'Raj');

-- Select employees from specified cities
select * 
from employee 
where city = 'Pune' 
    or city = 'Mumbai' 
    or city = 'Nashik';

-- Select name from work where salary is greater than the max salary in another company
select name 
from work 
where company = 'First Bank Corporation' 
    and salary > (
        select max(salary) 
        from work 
        where company = 'Small Bank Corporation'
    );

-- Create view that joins employee and manages table
create view my as 
    select emp_name, street, city, manager 
    from employee 
    join manages 
        on emp_name = manages.name;

SELECT * 
FROM my;

-- Update salary in work table
update work 
set salary = (1.15 * salary) 
where company = 'First Bank Corporation' 
    and salary < 20000;