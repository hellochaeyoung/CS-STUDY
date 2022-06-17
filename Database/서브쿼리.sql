/*

	sub Query
    Query 안의 Query
    
    select 단일row, 단일 column
    from   다중 row, 다중 column
    where  다중 row, 다중 column

*/

-- select
/* 오류 발생, 서브 쿼리에는 단일 컬럼만 가능!!
select employee_id, first_name,
	(select last_name, salary
    from employees
    where employee_id = 100)
from employees;

오류 발생 - 조회된 데이터가 아예 없으면 안됨
select employee_id, first_name,
	(select last_name
    from employees
    where employee_id = 100)
from employees;

즉, 서브쿼리는 무조건 단일 행, 단일 컬럼이어야함!!!
*/

/* 그룹 함수이기 때문에 하나의 값만 출력됨, 만약 모든 사람의 이름과 같이 조회하고 싶다면
select first_name, sum(salary)
from employees;
*/

-- 이렇게 서브쿼리를 이용!!
select first_name,
	(select sum(salary) from employees)
from employees;

-- 이렇게 서브 쿼리는 활용도가 높다!!
select department_id, first_name, salary,
	(select avg(salary) from employees)
from employees
where department_id = 30;


-- from

-- 100번 부서에 속하면서 급여가 8000 보다 큰 직원 조회
select employee_id, first_name, salary
from (select department_id, employee_id, first_name, salary
	  from employees
	  where department_id = 100) a -- MySQL은 서브 쿼리할 때 무조건 alia 아무거나 붙여줘야 한다!
where salary > 8000;


-- 부서 번호 50, 급여 6000 이상인 사원

select empno, ename, sal
from
	(select employee_id as empno, first_name as ename, salary as sal
	 from employees
	 where department_id = 50) a
where sal >= 6000;


-- 업무별로 급여의 합계, 인원수, 사원명, 월급

select job_id, count(*), first_name, salary
from employees
group by job_id;

select employee_id, first_name, job_id, 급여합계, 인원수
from (select employee_id, first_name, job_id, sum(salary) as 급여합계,  count(*) as 인원수
	  from employees
	  group by job_id) a;
      


-- where 

-- 평균 급여보다 많이 받는 상황
select employee_id, first_name, salary
from employees
where salary > (select avg(salary)
				from employees);

-- 부서 번호가 90인 사원의 업무명
select job_id, first_name, department_id
from employees
where job_id in (select job_id
				 from employees
				 where department_id = 90);
                 

-- 부서별로 가장 급여를 적게 받는 사원의 급여와 같은 급여를 받는 사원
select department_id, employee_id, first_name, salary
from employees
where salary in (select min(salary)
				from employees
				group by department_id);


-- 부서별로 가장 급여를 적게 받는 사원의 급여
select department_id, employee_id, first_name, salary
from employees
where (department_id, salary) in (select department_id, min(salary)
								  from employees
								  group by department_id)
order by department_id;                                  

-- 부서별로 가장 급여를 많이 받는 사원의 급여
select department_id, employee_id, first_name, salary
from employees
where (department_id, salary) in (select department_id, max(salary)
								  from employees
								  group by department_id)
order by department_id;          



-- 특수 쿼리
-- substr('문자열', 시작인덱스(1~), 글자수)
	-- substr('hello world', 1, 5) -> hello, java와 다르게 1부터 시작, 5개 글자수만큼 자름
-- case

select employee_id, first_name, phone_number,
	case substr(phone_number, 1, 3) 
		when '515' then '서울'
		when '590' then '부산'
        when '650' then '광주'
        else '기타'
	end as 지역
from employees;


-- over() 함수
-- group by를 보강하기 위해서 나온 함수
-- select 절에서만 사용

select department_id, count(*), first_name
from employees
group by department_id;

-- PARTITION BY == SELECT절 안에 GROUP BY
select first_name, salary, department_id,
	count(*)over(partition by department_id)
from employees;


-- 순위함수
/*
	rank()			1 2 3 3 5 6
    dense_rank()    1 2 3 3 4 5
    row_numer()		1 2 3 4 5 6
    rownum(oracle) -> @rownum:=@rownum+1 ( mysql)
    
*/

select employee_id, first_name, salary,
	rank()over(order by salary desc) as "RANK",
    dense_rank()over(order by salary desc) as "DENSE_RANK",
    row_number()over(order by salary desc) as "ROW_NUMBER"
from employees;


select @rownum:=@rownum+1, employee_id, first_name
from employees
where (@rownum:=0)=0 and @rownum < 10;


select @rownum:=@rownum+1, employee_id, first_name
from employees, (select @rownum:=0) rnum
where @rownum < 10;

/* 오류 발생, where -> from -> select 순으로 실행되기 때문에
select @rownum:=@rownum+1, employee_id, first_name
from employees, (select @rownum:=0) rnum
where @rownum > 10 and @rownum <= 20;
*/

select rnum, employee_id, first_name, salary
from
	(select @rownum:=@rownum+1 as rnum, employee_id, first_name, salary
	from employees, (select @rownum:=0) r
	order by salary desc) a
where rnum between 10 and 20; 



