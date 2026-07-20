-- MYSQL Basic Portfolio

-- CREATE A DATABASE
create DATABASE practice_db;

-- Which Database to use
use practice_db;

-- Delete table
drop table employees;

-- Create Table
CREATE table employees (
     id int primary key, name varchar(50), salary decimal(10,2));
     
     insert into employees values
     (1, 'Jose',50000),
     (2, 'Maria',62000);
     
-- Delete Temp table
drop table Temp_Table;

-- Create Temporal Table
CREATE TEMPORARY TABLE Temp_Table AS
select *
from employees;

-- List Table
select * from employees;

-- List Temporal Table
select * from Temp_Table;

-- Add a Column to a Temp Table
alter table Temp_Table
add column Age int;

-- Verify the new column
describe Temp_Table;

-- Disable SAFE Mode in Current Session
set sql_safe_updates = 0;

-- Verift SAFE Mode, 0=Disable, 1=Enable
select @@sql_safe_updates;

-- Add values to age form Temp Table
update Temp_Table
set Age = 
    CASE id
        When 1 then 25 
        when 2 then 35
	End;
    
-- List Temporal Table Using filter (Where)
select * from Temp_Table
where Age = 25;

-- List Temporal Table Using filter (Like)
select * from Temp_Table
where name like 'ma%';

-- List Temporal Table Using filter (Equal)
select * from Temp_Table
where name = 'maria';

-- List Temporal Table Using filter (in)
select * from Temp_Table
where name in ('jose', 'maria');

-- List Temporal Table Using filter (AND, OR NOT)
select * from Temp_Table
where name = 'Maria' and Age = 35;

select * from Temp_Table
where name = 'Maria' and not age = 25;

-- List order by column desc
select * from Temp_Table
order by 3 desc;

-- List with limit
select * from Temp_Table
limit 1;

-- List with distinct
select distinct * from Temp_Table
;

-- List with between
select distinct * from Temp_Table
where age between 25 and 35
;

-- Aggregated
select count(*) as Total_Customers,
		avg(Age) as Average_Age
from Temp_Table;

