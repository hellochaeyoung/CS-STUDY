-- mysql 연습문제1

select *
from employees;

desc employees;

select employee_id, first_name, last_name, job_id
from employees;

select salary+300
from employees;


select employee_id, first_name, salary, (salary + (salary * commission_pct)) as bonus
from employees;


-- 6
select last_name as 이름, salary as 급여
from employees;


-- 7
select last_name as Name, (salary * 12) as 'Annual Salary'
from employees;


-- 9
select concat(first_name, ", ", job_id) as result
from employees;

-- 10
select concat(last_name, " is a ", job_id) as result
from employees;

-- 11
select concat(last_name, ": 1 Year salary = ", salary) as result
from employees;



