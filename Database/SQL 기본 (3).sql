use mydb;

create table tb_test01 (
	col1 varchar(10),
    col2 varchar(20),
    col3 varchar(30)
);


create table tb_test02 (
	id int,
    name varchar(30),
    height decimal(3, 1),
	birth date
);

-- table copy : 데이터를 포함
create table tb_test03
as
select *
from jobs;

drop table tb_test03;

create table if not exists tb_test03
select * from jobs;

create table tb_test03
as
select job_id as jobid, max_salary as maxsal
from jobs;

select * from tb_test03;


-- 데이터 미포함, 테이블 컬럼 같은 정보만
create table if not exists tb_test04
like jobs;

create table tb_test05
select department_id as dnum, sum(salary) as "sum", avg(salary) as "avg"
from employees
group by department_id;



-- object : create, drop, alter
-- data : insert, delete, select, update

alter table tb_test04
rename
to tb_test99;

-- 컬럼 추가
alter table tb_test99
add
newcol1 varchar(30);

alter table tb_test99
add
(col2_new decimal(5, 1), col3_new date);

desc tb_test99;

-- 컬럼 데이터형 수정
alter table tb_test99
modify
newcol1 int;

-- 컬럼명 변경
alter table tb_test99
change
col2_new new_col2 varchar(20);


-- 컬럼 삭제
alter table tb_test99
drop
column newcol1;



-- 데이터 미포함 테이블 생성
create table dept
as
select *
from departments
where 1=2;

desc dept;

-- insert
insert into dept(department_id, department_name, manager_id, location_id)
values(10, '기획부', 100, 101);

insert into dept(department_id, department_name)
values(10, '관리부');

insert into dept(department_id)
values(30);


insert into dept
values(40, '개발부', 130, 103);

-- safe mode 설정 -> default = 1 -> delete, update ( insert, select는 필요없음)
-- 재부팅 시 다시 원래대로 디폴트 값 1로 설정됨, 재설정 필요!
set sql_safe_updates = 0;

-- 삭제
delete from dept where department_name = '경리부';

delete from dept 
where manager_id is null;


-- 수정
update dept
set manager_id = 300
where department_id = 40;


update dept
set manager_id = 500, location_id = 333
where department_name = '개발부';

drop table dept;


/*

	무결성 : constraint
			column을 지정하는 성질, column 설정
            
	primary key : 기본키, null을 허용하지 않는다, 중복허용하지 않는다.  id, 주민등록번호 등
    unique key : 고유키, null을 허용한다. 중복을 허용하지 않는다. email -- null 허용하지 않게 설정할 수 있다!
    foreign key : 외래키, 조인의 목적(테이블과 테이블을 연결), null을 허용 -- 마찬가지로 null을 허용하지 않게 만들수있다
				  외래키로 지정된 컬럼은 연결된 테이블에서 PK나 UK로 설정되어 있어야 한다.
    check : 범위를 지정, 값을 지정. 지정된 값 외에 사용할 수 없다. null은 허용
    not null : null을 허용하지 안흔ㄴ다. 중복을 허용한다.

*/

-- not null
create table tb_test06 (
	col1 varchar(10) not null,
    col2 varchar(20)
);

insert into tb_test06(col1, col2) values('AAA', '111');
insert into tb_test06(col1) values('BBB');
select * from tb_test06;

insert into tb_test06(col2) values('222'); -- error

drop table if exists tb_test06;


-- primary key = unique = not null
create table tb_test06 (
	pk_col varchar(10) primary key,
    col1 varchar(20),
    col2 varchar(30)
);

insert into tb_test06(pk_col, col1, col2)
values('AAA', '111', 'aaa');

select * from tb_test06;

insert into tb_test06(pk_col)
values('BBB');

insert into tb_test06(pk_col)
values('bbb'); -- MySQL은 대소문자 구분 못하므로 에러발생


insert into tb_test06(col1, col2)
values('111', 'aaa');


-- 기본키에 빈문자열 oracle은 안됨. mysql에서는 허용
insert into tb_test06(pk_col, col1, col2)
values('', '111', 'aaa');

drop table if exists tb_test06;

create table tb_test06(
	pk_col varchar(10),
    col1 varchar(20),
    col2 varchar(30),
    primary key(pk_col)
);



create table tb_test06(
	pk_col varchar(10),
    col1 varchar(20),
    col2 varchar(30)
);


desc tb_test06;


-- 기본키 추가
alter table tb_test06
add primary key (pk_col);

-- 기본키 삭제
alter table tb_test06
drop primary key;



create table tb_test07 (
	uk_col varchar(10) unique,
    col1 varchar(20),
    col2 varchar(30)
);


insert into tb_test07(uk_col, col1, col2) values('AAA', 'aaa', '111');

insert into tb_test07(uk_col, col1, col2) values('', 'aaa', '111');


-- null 허용하니까 OK!
insert into tb_test07(col1, col2) values('aaa', '111');

-- 소문자이지만 같은 값이므로 안됨, mysql은 대소문자 구분 안함!
insert into tb_test07(uk_col, col1, col2) values('aaa', 'aaa', '111');



-- 외래키
-- 기본(부모) 테이블(departments)에서 PK, UK로 설정되어 있어야 한다.
-- null을 허용
create table tb_dept(
	department_id varchar(10),
    department_name varchar(20),
    location_id decimal(3),
    primary key(department_id)
);


insert into tb_dept(department_id, department_name, location_id)
values('10', '기획부', 120);

insert into tb_dept(department_id, department_name, location_id)
values('20', '관리부', 150);


insert into tb_dept(department_id, department_name, location_id)
values('30', '개발부', 180);


-- child table : employees
create table tb_emp(
	empno int,
    ename varchar(30),
    department_id varchar(10),
    foreign key(department_id) references tb_dept(department_id),
    primary key(empno)
);

desc tb_emp;

insert into tb_emp(empno, ename, department_id) values (100, '홍길동', '20');
insert into tb_emp(empno, ename, department_id) values (101, '성춘향', '10');
insert into tb_emp(empno, ename, department_id) values (102, '일지매', '30');

insert into tb_emp(empno, ename, department_id) values (105, '임꺽정', null);


select empno, ename, e.department_id, d.department_id, d.department_name
from tb_emp e, tb_dept d
where e.department_id = d.department_id;

-- check
-- 지정된 값만 넣을 수 있다, null을 허용한다, 중복된 값은 당연히 허용
create table tb_check(
	col1 varchar(10),
    col2 int,
    constraint chk_01 check ( col1 in('사과', '배', '바나나') ),
    constraint chk_02 check( col2 > 0 and col2 <= 10 )
);


insert into tb_check(col1, col2) values ('사과', 5);
insert into tb_check(col1, col2) values ('바나나', 5);
