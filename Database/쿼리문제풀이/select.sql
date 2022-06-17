-- 연습문제 2

-- 1
select employee_id, first_name, job_id, salary
from employees
where salary >= 6000;

-- 2
select employee_id, first_name, job_id, salary, department_id
from employees
where job_id = 'ST_MAN'; -- MySQL은 대소문자 가리지 않지만 되도록이면 맞춰주는 것이 좋다.

-- 3
select employee_id, first_name, job_id, salary, hire_date, department_id
from employees
where hire_date > '1999-01-01';

select employee_id, first_name, job_id, salary, hire_date, department_id
from employees
where hire_date > DATE('1999-01-01');

-- 4
select employee_id, first_name, job_id, salary, department_id
from employees
where salary between 3000 and 5000;

-- 5
select employee_id, first_name, job_id, salary, hire_date
from employees
where employee_id in (145, 152, 203);

select employee_id, first_name, job_id, salary, hire_date
from employees
where employee_id = 145 or employee_id = 152 or employee_id = 203; 


-- 6
select employee_id, first_name, job_id, salary, hire_date, department_id
from employees
where hire_date like '2000%';

-- 7
select employee_id, first_name, job_id, salary, (salary + (salary * commission_pct)) as bonus, department_id
from employees
where commission_pct is null;

-- 8
select employee_id, first_name, job_id, salary, hire_date, department_id
from employees
where salary >= 7000 and job_id = 'ST_MAN';

-- 9
select employee_id, first_name, job_id, salary, hire_date, department_id
from employees
where salary >= 10000 or job_id = 'ST_MAN';

-- 10
select employee_id, first_name, job_id, salary, department_id
from employees a
where job_id not in ('ST_MAN', 'SA_MAN', 'SA_REP');

select employee_id, first_name, job_id, salary, department_id
from employees a
where not exists (select 1 from dual where a.job_id = 'ST_MAN' or a.job_id = 'SA_MAN' or a.job_id = 'SA_REP');

-- 11
select employee_id, first_name, job_id, salary
from employees
where (job_id = 'AD_PRES' and salary >= 12000) or job_id = 'SA_MAN';

-- 12
select employee_id, first_name, job_id, salary
from employees
where (job_id = 'AD_PRES' or job_id = 'SA_MAN') or salary >= 12000;





