-- MYSQL Data Quality Portfolio

-- DELETE Table
drop table Temp_Table;

-- Create Temporal Table
CREATE TEMPORARY TABLE Temp_Table (
     id int primary key, orderid int, name varchar(50), salary decimal(10,2), load_Date date);
     
     insert into Temp_Table values
     (1, 1,'jose',50000,'2026-07-07'),
     (2, 1,'maria',62000,'2026-07-08'),
	 (3, 2, null,null,'2026-07-09'),
     (4, 2, null,null,'2026-07-10'),
	 (5, 1,'jose',-1,'2026-07-10'),
     (6, 1,'jose',150000,'2026-07-10'),
     (7, 1,'jose',700000,'2026-07-10'),
     (8, 1,'jose',700000,'2026-07-10');
;


-- LIST Temporal table
select *
from Temp_Table;

-- Null check
select *
from Temp_Table
where name is null or salary is null;

-- Uniqueness check
select orderid, count(*)
from Temp_Table
group by orderid
having count(*) > 1;

-- Data Freshness Check
select max(load_Date) 
from Temp_Table;

-- Range Validation
select *
from Temp_Table
where salary <= 0 or  salary > 100000;

-- Date Consistency Check, Curdate substracted 1 day, load_date should be less than curdate
select *
from Temp_Table
where curdate() - interval 3 day < load_Date;

-- Volume Check
select count(*)
from Temp_Table
where load_Date = curdate() - interval 3 day;

-- Outlier Detection using subquery, this query doesn't work at least the temp table be converted to regular table

-- Covert temporal table to regular table
CREATE TABLE Temp_Copy AS
SELECT * FROM Temp_Table;

-- Sample using the converted table and subquery select if salary is greater than AVG(Salary) (Outlier Detection)
select *
from Temp_Copy t
where t.salary > (
  select avg(salary)
  from (select salary from Temp_Copy) as x);
  
-- Sample using the converted table and CTE (Common Table Expression) select if salary is greater than AVG(Salary) (Outlier Detection)
WITH cte AS (
    SELECT AVG(salary) AS avg_salary
    FROM (SELECT salary FROM Temp_Copy) AS x
)
SELECT *
FROM Temp_Copy
WHERE salary > (SELECT avg_salary FROM cte);

-- setting a parameter to select salary greater than @avg10 (Outlier Detection)
SET @avg10 = 70000;

SELECT *
FROM Temp_Copy
WHERE salary > @avg10;

-- Referential Integrity
CREATE TEMPORARY TABLE Temp_Order (
     id int primary key, orderid int, name varchar(50), salary decimal(10,2), load_Date date);
     
     insert into Temp_Order values
     (1, 1,'jose',50000,'2026-07-07'),
     (2, 1,'maria',62000,'2026-07-08'),
	 (3, 2, null,null,'2026-07-09');
     
drop table Temp_Customer;

CREATE TEMPORARY TABLE Temp_Customer (
     id int, orderid int, name varchar(50), salary decimal(10,2), load_Date date, age varchar (2), status varchar (15));
     
     insert into Temp_Customer values
     (1, 1,'jose',50000,'2026-07-07','30','high'),
     (2, 1,'maria',62000,'2026-07-08','25','low'),
	 (3, 2, null,null,'2026-07-09','40','medium');
     
select * from Temp_Order;
select * from Temp_Customer;

-- the id in Temp_Order should appear in Temp_Customer to assure data integrity
select o.id 
from Temp_Order o
left join Temp_Customer c
on o.id = c.id
where c.id is null;

-- Data Type Validation using regular expressions to the age column to determine if this column contains something different to integer
SELECT *
FROM Temp_Customer
WHERE age REGEXP '^[0-9]+$' = 0;

-- Accepted Values Check, this query select status values not valid assuming the values in the IN are correct.
select *
from Temp_Customer
where status not in ('Grande', 'Madiano', 'Pequeno');

-- MYSQL Window Functions
-- Covert temporal table to regular table
CREATE TABLE Temp_Copy AS
SELECT * FROM Temp_Customer;

-- Row_Number
SELECT 
    id,
    ROW_NUMBER() OVER (ORDER BY age) AS rn
FROM Temp_Copy;

-- Rank/Dense_Rank
SELECT 
    id,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM Temp_Copy;

-- Aggregate Window Functions
SELECT 
    id,
    salary,
    AVG(salary) OVER () AS avg_salary,
    SUM(salary) OVER () AS total_salary
FROM Temp_Copy;

-- Partitioned Window Functions
SELECT 
    orderid,
    salary,
    AVG(salary) OVER (PARTITION BY orderid) AS dept_avg_salary
FROM Temp_Copy;

-- Running Totals
SELECT 
    id,
    salary,
    SUM(salary) OVER (ORDER BY id) AS running_total
FROM Temp_Copy;

-- Moving Average
SELECT 
    id,
    salary,
    AVG(salary) OVER (
        ORDER BY id
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM Temp_Copy;
