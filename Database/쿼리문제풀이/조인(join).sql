/*
	Join 조인
	두 개 이상의 테이블을 연결해서 데이터를 검색하는 방법
    보통 두 개 이상의 행(row)들의 공통된 기본키, 외래키를 사용해서 조인한다.
    
    목적 : 현재 테이블에서 상대 테이블의 정보(column)을 산출하기 위한 처리
    
    기본키 : 테이블에서 중복되지 않는 컬럼 
    외래키 : 다른 테이블에서 기본키로 설정되어 있다.
   
   Join의 종류
   inner Join		***
   full outer join
   cross join
   outer join
		 left		***
		 right		***
   self join		***

*/

-- INNER JOIN
-- ansi SQL
select employee_id, first_name, e.department_id, d.department_id, d.department_name
from employees e inner join departments d
	on e.department_id = d.department_id;
    
-- MySQL
select employee_id, first_name, e.department_id, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

select e.employee_id, e.first_name, e.job_id, j.job_id, j.job_title
from employees e, jobs j
where e.job_id = j.job_id 
and e.job_id = 'IT_PROG';

-- 3개 테이블 조인
select employee_id, first_name, e.department_id, department_name, job_title
from employees e, departments d, jobs j 
where e.department_id = d.department_id
and e.job_id = j.job_id;

-- cross join
-- ansi
select e.employee_id, e.first_name, e.department_id, d.department_id
from employees e cross join departments d;

select e.employee_id, e.first_name, e.department_id, d.department_id
from employees e, departments d;


-- left, right outer
select e.employee_id, e.first_name, e.department_id, d.department_id, d.department_name
from employees e left outer join departments d
	on e.department_id = d.department_id;
    
select e.employee_id, e.first_name, e.department_id, d.department_id, d.department_name
from employees e right outer join departments d
	on e.department_id = d.department_id;
    

-- full outer join

select e.employee_id, e.first_name, e.department_id, d.department_id, d.department_name
from employees e left outer join departments d
	on e.department_id = d.department_id
union
select e.employee_id, e.first_name, e.department_id, d.department_id, d.department_name
from employees e right outer join departments d
	on e.department_id = d.department_id;
    
    
    
select e.employee_id, e.first_name, e.department_id, d.department_id, d.department_name
from employees e left outer join departments d
	on e.department_id = d.department_id
where e.department_id is null;


select e.employee_id, e.first_name, e.department_id, d.department_id, d.department_name
from employees e right outer join departments d
	on e.department_id = d.department_id
where e.department_id is null;



select e.employee_id, e.first_name, e.department_id, d.department_id, d.department_name
from employees e left outer join departments d
	on e.department_id = d.department_id
where e.department_id is null
union
select e.employee_id, e.first_name, e.department_id, d.department_id, d.department_name
from employees e right outer join departments d
	on e.department_id = d.department_id
where e.department_id is null;


-- self join : 동일한 테이블을 조인
select emp.employee_id, emp.first_name, emp.manager_id, mgr.employee_id, mgr.first_name
from employees emp, employees mgr
where emp.manager_id = mgr.employee_id;

