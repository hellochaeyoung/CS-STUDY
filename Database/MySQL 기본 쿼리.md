select * from employees;

select @@autocommit;

set autocommit = true; -- 설정
set autocommit = false; -- 해제

commit;
rollback;



/*
자료형
Java			Oracle						MySQL
int				INTEGER, NUMBER(5)			INT, DECIMAL(5), DECIMAL(5,2)
double			NUMBER						DOUBLE
String			VARCHAR2					VARCHAR
Date			DATE						DATE


*/

-- table 생성
/*
ROW(행), COLUMN(열)

create table 테이블명(
	컬럼명 자료형,
    컬럼명 자료형,
    컬럼명 자료형
    .
    .
    .
)
*/

-- 테이블 정보조회 (스키마가 mydb)
select * from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA='mydb';

-- varchar
create table tb_varchar (
	col1 varchar(10),
    col2 varchar(20),
    col3 varchar(30)
);

insert into tb_varchar values ('ABC', 'ABC', 'ABC'); -- 영문자는 하나당 1바이트
insert into tb_varchar values ('가나다', '가나다', '가나다'); -- 한글 : 3바이트

-- 숫자(정수, 실수)
-- INTEGER
create table tb_integer (
	col1 int,
    col2 integer
);

insert into tb_integer values (123, 456);
insert into tb_integer values ('123', '456'); -- db에서는 문자로 넣어도 ok
select * from tb_integer;


create table tb_decimal (
	col1 decimal, -- 정수, 소수 다 취급
    col2 decimal(5), -- 5자리까지 취급
    col3 decimal(5, 2) -- 5자리, 소수점 2자리까지 취급
);

insert into tb_decimal values (1234.5678, 12345.34, 123.567);
select * from tb_decimal;

-- date
create table tb_date (
	col1 date,
    col2 date
);

--  현재날짜
insert into tb_date values (now(), now()-1);
select * from tb_date;
select now();

select date_format(col1, '%y %m %d'), col2 from tb_date;
select date_format(col1, '%y'), date_format(col1, '%m'), date_format(col1, '%d'), col2 from tb_date;


-- timestamp
create table board(
	num INT NOT NULL auto_increment,
    title VARCHAR(30),
    ymd TIMESTAMP default now(),
    PRIMARY KEY(num)
);

insert into board values ( 1, '타이거즈', default);
insert into board values ( 2, '라이온즈', now());
insert into board values ( 3, '트윈즈', now());
insert into board values ( 4, '이글즈', str_to_date('20220616103506', '%Y%m%d%H%i%s')); -- 문자열을 date형으로!!
select * from board;

select num, title, date_format(ymd, '%y/%m/%d') from board;

select date_format(ymd, '%y %m %d %h %i %s') from board; -- %Y : 년도 4자리, %y : 년도 끝 두자리




