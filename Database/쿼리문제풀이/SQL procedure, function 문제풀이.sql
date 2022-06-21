-- 1. 사원번호를 입력 받으면 다음과 같이 출력되는 PROCEDURE를 작성하라.
delimiter //
create procedure printEmp(in emp_no int)
	begin
		declare dept_name varchar(50);
        declare emp_name varchar(35);
        
        select d.department_name, e.first_name into dept_name, emp_name
        from employees e, departments d
        where e.department_id = d.department_id
        and e.employee_id = emp_no;
        
        select concat(dept_name, " 부서의 ", emp_name, "사원입니다");
    end;

//
delimiter ;

-- Purchasing 부서의 Alexander사원입니다
select * from employees where first_name = 'Alexander';
call printEmp(115);


-- 2. 사원번호를 입력받고, 소속부서의 최고, 최저연봉 차액을 파라미터로 출력하는 PROCEDURE를 작성하라.
delimiter //
create procedure getGapOfSalaryFromDept(in emp_no int, out salary_gap decimal(8,2))
begin
	declare dept_id int;
	declare max_salary decimal(8, 2);
    declare min_salary decimal(8, 2);
    
    select department_id into dept_id
    from employees
    where employee_id = emp_no;
    
    select max(salary), min(salary) into max_salary, min_salary
    from employees
    where department_id = dept_id
    group by department_id;
    
    set salary_gap = max_salary - min_salary;

end;
//
delimiter ;

drop procedure if exists getGapOfSalaryFromDept;
select * from employees;

call getGapOfSalaryFromDept(103, @result_gap);
select @result_gap;





-- 3. 부서번호를 입력하면 해당 부서에서 근무하는 사원 수를 반환하는 함수를 정의하시오.
delimiter //
create function countEmp(dept_id int) returns int
begin
	declare emp_count int;
    
    select count(*) into emp_count
    from employees
    where department_id = dept_id
    group by department_id;

	return emp_count;
end;
//
delimiter ;

drop function if exists countEmp;
select countEmp(100);
select * from employees;


-- 4. employees 테이블의 사원번호를 입력하면 해당 사원의 관리자 이름을 구하는 함수를 정의하시오.
delimiter //
create function getManagerName(emp_no int) returns varchar(35)
begin
	declare mgr_name varchar(35);
    
    select m.first_name into mgr_name
    from employees e, employees m
    where e.manager_id = m.employee_id
    and e.employee_id = emp_no;

	return mgr_name;
end;

//
delimiter ;

drop function if exists getManagerName;
select * from employees;
select getManagerName(103);


-- 5. employees 테이블을 이용해서 사원번호를 입력하면 급여 등급을 구하는 함수를 정의하시오.

/*
18000 ~ 24000 A, 
12000 ~ 18000 미만 B, 
8000 ~ 12000 미만 C, 
3000 ~ 8000 미만 D, 
그 외에는 F, */

delimiter //
create function getSalaryRank(emp_no int) returns varchar(10)
begin
	declare salary_rk varchar(10);
    declare sal decimal(8,2);
    
    select salary into sal
    from employees
    where employee_id = emp_no;
    
	if sal >= 18000 then
		return 'A';
	elseif sal >= 12000 and sal < 18000 then
		return 'B';
	elseif sal >= 8000 and sal < 12000 then
		return 'C';
	elseif sal >= 3000 and sal < 8000 then
		return 'D';
	else 
		return 'F';
	end if;
    
end;

//
delimiter ;

drop function if exists getSalaryRank;
select getSalaryRank(110);
