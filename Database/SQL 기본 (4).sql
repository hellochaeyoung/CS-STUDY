/*

	view : 가상 테이블
			실체가 없는 테이블 != dual
            다른 테이블에 접근하기 위한 테이블alter
            
	table <----------- view <------------- user
    속도가 빠르다
    한개의 view로 여러 개의 테이블을 검색할 수 있다.
    제한 설정이 가능하다. ----> readonly
    가상 테이블이기 때문에 연산을 수행하면 원본 테이블에 수행된 결과가 반영된다!

*/


create or replace view ub_test01
as
select job_id, job_title, min_salary
from jobs;


insert into ub_test01(job_id, job_title, min_salary) values('DEVELOPER', '개발자', 10000);


select * from jobs;

delete from jobs where job_id = 'DEVELOPER';


create table emp
as
select employee_id, first_name, salary
from employees;

-- view를 생성
create or replace view ub_view(empno, ename, sal)
as
select employee_id, first_name, salary
from emp;

insert into ub_view(empno, ename, sal) values ( 300, '정수동', 11000);

select * from ub_view;
select * from emp;



-- 이렇게 조인을 해둔 뷰를 만들어두면
create or replace view deft_emp_location_view
as
select employee_id, first_name, e.department_id,
	   department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

-- 실무에서 작업할 때 이렇게 매번 조인연산 할 필요 없이 데이터를 조회해볼 수 있다.
select * from deft_emp_location_view where employee_id = 103;
