
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

select *
from employee_demographics
inner join employee_salary
	on employee_id = employee_id;

select *
from employee_demographics
inner join employee_salary
	on employee_demographics.employee_id = employee_salary.employee_id;

select *
from employee_demographics a
inner join employee_salary b
	on a.employee_id = b.employee_id;
    
select a.employee_id, age, occupation
from employee_demographics a
inner join employee_salary b
	on a.employee_id = b.employee_id;
    
select *
from employee_demographics a
left join employee_salary b
	on a.employee_id = b.employee_id;
    
select *
from employee_demographics a
right join employee_salary b
	on a.employee_id = b.employee_id;
    
select emp1.employee_id as emp_santa, emp1.first_name as first_name_santa, emp1.last_name as last_name_santa,
emp2.employee_id as emp_name, emp2.first_name as first_name_emp, emp2.last_name as last_name_emp
from employee_salary emp1
join employee_salary emp2
	on emp1.employee_id + 1 = emp2.employee_id;
    
select *
from employee_demographics a
inner join employee_salary b
	on a.employee_id = b.employee_id
inner join parks_departments pd
	on b.employee_id = pd.department_id;
    
select first_name, last_name
from employee_demographics
union 
select first_name, last_name
from employee_salary;

select first_name, last_name
from employee_demographics
where age > 50
;

select first_name, last_name, 'old' as label
from employee_demographics
where age > 50
;

select first_name, last_name, 'High Paid Employee' as label
from employee_salary
where salary > 70000
;

select first_name, last_name, 'Old Man' as label
from employee_demographics
where age > 40 and gender = 'Male'
union
select first_name, last_name, 'Old Lady' as label
from employee_demographics
where age > 40 and gender = 'Female'
union
select first_name, last_name, 'High Paid Employee' as label
from employee_salary
where salary > 70000
;

select length('sky');

select first_name, length(first_name)
from employee_demographics
order by 2;

select upper('sky'), lower('SKY');

select first_name, upper(first_name)
from employee_demographics;

select trim('            sky                      ');
select ltrim('            sky                      ');
select rtrim('            sky                      ');

select first_name, left(first_name,4), right(first_name,4), substring(first_name,3,2), birth_date, substring(birth_date, 6,2) as birth_month
from employee_demographics;

select first_name, replace(first_name, 'a', 'z')
from employee_demographics;

select locate('x', 'Alexander');

select first_name, locate('An', first_name)
from employee_demographics;

select first_name, last_name, concat(first_name, ' ', last_name) as full_name
from employee_demographics;

select first_name, last_name, age,

case
	when age <= 30 then 'Young'
	when age between 31 and 50  then 'old'
    when age >= 50 then "on death's door"
end as 'Age_Bracket'

from employee_demographics;

select *
from employee_salary;

-- Pay Increase and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

select first_name, last_name, salary,
case
	when salary < 50000 then  salary * 1.05
	when salary > 50000 then  salary * 1.07
end as New_salary,
case
	when dept_id = 6 then salary * 0.10
end as Bonus
from employee_salary;

select employee_id
						from employee_salary
                        where dept_id = 1;
                        
select *
from employee_demographics
where employee_id in (select employee_id
						from employee_salary
                        where dept_id = 1);
                        
select first_name, salary, avg(salary)
from employee_salary
group by first_name, salary;

select first_name, salary, 
(select avg(salary) from employee_salary)
from employee_salary;

select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender;

select *
from
(select gender, avg(age) as Avg_age, max(age) as Max_age, min(age) as min_age, count(age) as count_age
from employee_demographics
group by gender) as agg_table;

select gender, avg(avg_age), avg(Max_age)
from
(select gender, avg(age) as Avg_age, max(age) as Max_age, min(age) as min_age, count(age) as count_age
from employee_demographics
group by gender) as agg_table
group by gender;

select avg(avg_age), avg(Max_age)
from
(select gender, avg(age) as Avg_age, max(age) as Max_age, min(age) as min_age, count(age) as count_age
from employee_demographics
group by gender) as agg_table
;

select gender, avg(salary) as avg_salary
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender;

select gender, avg(salary) over(partition by gender)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

select dem.first_name, dem.last_name, gender, salary, sum(salary) over(partition by gender order by dem.employee_id) as Rolling_Total
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

select dem.first_name, dem.last_name, gender, salary, row_number() over()
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

select dem.first_name, dem.last_name, gender, salary, row_number() over(partition by gender)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

select dem.first_name, dem.last_name, gender, salary, row_number() over(partition by gender order by salary desc) as Numero_Consecutivo
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

select dem.first_name, dem.last_name, gender, salary, 
row_number() over(partition by gender order by salary desc) as Numero_Consecutivo,
rank() over(partition by gender order by salary desc) as rank_number
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

select dem.first_name, dem.last_name, gender, salary, 
row_number() over(partition by gender order by salary desc) as Numero_Consecutivo,
rank() over(partition by gender order by salary desc) as rank_number,
dense_rank() over(partition by gender order by salary desc) as dense_rank_number
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;






    


    



