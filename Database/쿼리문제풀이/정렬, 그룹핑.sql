-- 연습문제 3

-- hr 정렬
-- 1
select employee_id, first_name, job_id, salary, hire_date, department_id
from employees
order by hire_date;

-- 2
select employee_id, first_name, job_id, salary, hire_date, department_id
from employees
order by hire_date desc;


-- 3
select employee_id, first_name, job_id, department_id, salary
from employees
order by department_id asc, salary desc;

-- 4
select employee_id, first_name, hire_date, department_id, job_id, salary
from employees
order by department_id asc, job_id asc, salary desc;



-- hr 그룹핑
-- 1
select avg(salary), max(salary), min(salary), sum(salary)
from employees
where job_id like 'SA%';


-- 2
select count(*), count(commission_pct), avg(commission_pct * salary), count(distinct department_id)
from employees;

-- 3
select department_id, count(*), avg(salary), min(salary), max(salary), sum(salary)
from employees
group by department_id;


-- 4
select department_id, count(*), avg(salary), min(salary), max(salary), sum(salary) as 급여합계
from employees
group by department_id
-- order by sum(salary) desc; 
order by 급여합계 desc;-- alias 사용할 경우 ""는 제외해야 정상 동작


-- 5
select department_id, job_id, count(*), avg(salary), sum(salary)
from employees
group by department_id, job_id
order by department_id;


-- 6
select department_id, count(*), sum(salary)
from employees
group by department_id
having count(*) > 4;


-- 7
select department_id, avg(salary), sum(salary)
from employees
group by department_id
having max(salary) >= 10000;


-- 8
select job_id, avg(salary), sum(salary)
from employees
group by job_id
having avg(salary) >= 10000;


-- 9
select job_id, sum(salary)
from employees
where job_id not like 'SA%'
group by job_id
having sum(salary) > 10000
order by sum(salary) desc;


select job_id, sum(salary)
from (select job_id, salary from employees where job_id not like 'SA%') a
group by job_id
having sum(salary) > 10000
order by sum(salary) desc;



