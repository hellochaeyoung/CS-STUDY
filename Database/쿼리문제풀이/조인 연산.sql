-- 문제1) 사원들의 이름, 부서번호, 부서명을 출력하라
select e.first_name, e.department_id, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id;

-- 문제2) 30번 부서의 사원들의 이름,직업,부서명을 출력하라
select e.first_name, e.job_id, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id
where e.department_id = 30;

-- 문제3) 커미션을 받는 사원의 이름, 직업, 부서번호,부서명을 출력하라
select e.first_name, e.job_id, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.commission_pct is not null;

-- 문제4) 지역번호 2500 에서 근무하는 사원의 이름, 직업,부서번호,부서명을 출력하라
select e.first_name, e.job_id, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 2500;

-- 문제5) 이름에 A가 들어가는 사원들의 이름과 부서이름을 출력하라
select e.first_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.first_name like "%A%";

-- 문제6) 사원이름과 그 사원의 관리자 이름을 출력하라
select concat(em.first_name, " ", em.last_name) as '이름', mgr.first_name as '관리자'
from employees em, employees mgr
where em.manager_id = mgr.employee_id;

-- 문제7) 사원이름과 부서명과 월급을 출력하는데 월급이 6000 이상인 사원을 출력하라
select e.first_name, e.salary, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.salary >= 6000;

-- 문제8) first_name 이 TJ 이란 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하라
select first_name, hire_date
from employees
where hire_date > (select hire_date
				   from employees e
				   where first_name like 'TJ%');
                   
select tj.first_name, tj.hire_date ,e.first_name, e.hire_date
from employees tj, employees e
where tj.first_name = 'TJ' and tj.hire_date < e.hire_date;



-- 문제9) 급여가 3000에서 5000사이인 사원의 이름과 소속부서명 출력하라
select first_name, department_name
from employees e, departments d
where e.department_id = d.department_id
and e.salary between 3000 and 5000;



-- 문제10) ACCOUNTING 부서 소속 사원의 이름과 입사일 출력하라
select * from departments;

select first_name, hire_date
from employees e, departments d
where e.department_id = d.department_id
and d.department_name = 'ACCOUNTING';

-- 문제11) 급여가 3000이하인 사원의 이름과 급여, 근무지를 출력하라
select first_name, salary, street_address, city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and salary <= 3000;




