/*
	CRUD
    
    INSERT
    DELETE
	SELECT
	UPDATE
    
    object
    CREATE
    DROP
    ALTER
*/

select * from employees;

desc employees;

select '이름: ', 20, first_name
from employees;

select first_name as "이름" , last_name as "성"
from employees;

select first_name as "이 름" , last_name as "성", salary * 12 as 연봉
from employees;

select concat('이름 : ', last_name, first_name) as '전체이름'
from employees;


-- 조건절
/*
	대소비교, 판정
    =, !=, >, <, >=, <=, <>
*/

select first_name, salary
from employees
where first_name = 'John';

select first_name, salary
from employees
where first_name != 'John';

select first_name
from employees
where first_name >= 'John';

select hire_date, first_name
from employees
-- where hire_date < '1991-01-01'; -- date형과 문자열은 다른 오브젝트이지만 문자열로 비교 가능
where hire_date < date('1991-01-01');

select first_name, last_name from employees where manager_id is null;

select * from employees where manager_id is not null and salary >= 10000;

select * from employees where (first_name = 'John' or first_name = 'Den') and salary > 6000;

/*
	ALL, ANY, IN, EXISTS, BETWEEN
    and	 or	  or

*/

select * from employees where salary = all(select salary from employees where salary = 8000); -- all 거의 사용 안함

-- all - and, any - or
select first_name, last_name, salary
from employees
where salary = any( select salary from employees where job_id = 'IT_PROG');

-- exists
select first_name, salary, job_id from employees a where exists ( select 1 from dual where a.job_id = 'IT_PROG');


-- between
select * from employees where salary >= 3200 and salary <= 9000;
select first_name, salary from employees where salary between 3200 and 9000;
select first_name, salary from employees where salary not between 3200 and 9000; -- salary < 3200 or salary > 9000

-- like
select * from employees where first_name like 'G_ra_d'; -- _ 언더바는 한 문자를 의미, 즉 어느 문자가 와도 상관없다는 뜻

select * from employees where first_name like 'K%y'; -- %는 글자수에 제한이 없음을 의미

select * from employees where first_name like '%a%';

-- order by -> sorting 올림, 내림

select * from employees order by salary desc;

select * from employees order by hire_date desc;

select employee_id, first_name, manager_id from employees order by manager_id is null; -- null은 나중에 출력(오름차순)
select employee_id, first_name, manager_id from employees order by manager_id is null desc; -- null 제일 먼저 출력(내림차순)

select * from employees order by commission_pct is null desc;

select * from employees order by commission_pct is null desc, salary desc;

select first_name, salary * 12 as 연봉
from employees
order by 연봉 desc;


-- 그룹 묶는 기능
select distinct department_id from employees order by department_id asc;

-- group by
select department_id
from employees 
group by department_id
order by department_id;

/*
	그룹 함수
	count
    sum
    avg
    max
    min

*/

select count(employee_id), count(*), sum(salary), avg(salary), max(salary), min(salary)
from employees
where job_id = 'IT_PROG';

/*
	ifnull(대상이 되는 컬럼, 출력하고 싶은 값) == NVL(Oracle)
    
    대상이 되는 컬럼이 null일 경우, 출력하고 값을 리턴한다.
*/
select first_name, ifnull(commission_pct, 0)
from employees;

-- truncate
select department_id, sum(salary), max(salary), truncate(avg(salary), 0)
from employees
group by department_id;

select department_id, job_id
from employees
group by department_id, job_id
order by department_id;

-- group by -> 조건
-- having
select job_id, sum(salary)
from employees
group by job_id
having sum(salary) >= 100000;

select job_id, count(*), sum(salary), avg(salary)
from employees
where salary >= 5000
group by job_id
having sum(salary) > 20000;

select department_id, count(*)
from employees
group by department_id
having count(*) > 30;

