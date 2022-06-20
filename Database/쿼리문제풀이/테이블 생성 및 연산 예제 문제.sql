-- 1. 운동부 TABLE을 작성하라.

-- TEAM : 팀 아이디, 지역, 팀 명, 개설 날짜, 전화번호, 홈페이지
create table team (
	team_id int primary key,
    location varchar(20),
    team_name varchar(30),
    birth_date date,
    phone_number varchar(30),
    page_url varchar(50)
);

desc team;


-- PLAYER : 선수번호, 선수 명, 등록일, 포지션, 키, 팀 아이디
create table player (
	player_id int primary key,
    player_name varchar(20),
    register_date date,
    player_position varchar(20),
    player_height double,
    team_id int,
	foreign key (team_id) references team(team_id)
);

desc player;


-- 3개의 TEAM을  등록합니다.
insert into team values (1, '서울', 'AAA', '2000-10-10', '02-111-1111', 'www.aaa.com');
insert into team values (2, '인천', 'BBB', '2002-08-04', '032-322-0984', 'www.bbb.com');
insert into team values (3, '성남', 'CCC', '2005-07-29', '032-325-4562', 'www.ccc.com');

select * from team;


-- 3 개의 TEAM에 선수를 3 ~ 9명을 등록(추가)합니다.
insert into player values (1, '손흥민', '2007-09-01', '공격수', 186.7, 1);
insert into player values (2, '박지성', '2005-10-11', '미드필더', 176.5, 2);
insert into player values (3, '기성용', '2010-02-17', '미드필더', 188.9, 3);
insert into player values (4, '황희찬', '2011-05-01', '공격수', 180.7, 1);
insert into player values (5, '황의조', '2007-06-01', '공격수', 180.2, 2);
insert into player values (6, '김민재', '2007-07-01', '수비수', 178.2, 3);

-- 선수를 입력하면 그 선수의 팀 명과 전화번호, 홈페이지가 출력되도록 합니다. 
select team_name, phone_number, page_url
from team t, player p
where t.team_id = p.team_id
and p.player_name = '손흥민';

-- JOIN 해 보도록 합니다. 

-- 팀명으로 팀원들이 출력되도록 합니다. 
select p.*
from team t, player p
where t.team_id = p.team_id
and team_name = 'AAA';



-- 2. 온라인 마켓 TABLE을 작성하라.

-- PRODUCT(상품) : 상품번호, 상품명, 상품가격, 상품설명
create table product (
	product_id int primary key,
    product_name varchar(50),
    product_price int,
    product_explain varchar(100)
);

desc product;


-- CONSUMER(소비자) : 소비자 ID, 이름, 나이
create table consumer (
	consumer_id int primary key,
    consumer_name varchar(30),
    consumer_age int
);

desc consumer;

-- CART(장바구니) : 장바구니 번호, 소비자 ID, 구입일, 상품번호, 수량
create table cart (
	cart_id int primary key,
    consumer_id int,
    purchase_date date,
    product_id int,
    count int,
    foreign key(consumer_id) references consumer(consumer_id),
    foreign key(product_id) references  product(product_id)
);

desc cart;


-- 상품 테이블에 상품을 등록합니다(개수는 5가지이상).
insert into product values (1, '텀블러', 20000, '스타벅스 텀블러');
insert into product values (2, '필통', 7000, '남색 핉통');
insert into product values (3, '줄노트', 6000, '필기용 노트');
insert into product values (4, '제스트림 볼펜', 3500, '검은색 볼펜');
insert into product values (5, '슬리퍼', 10000, '흰색 크록스 슬리퍼');
insert into product values (6, '마스크', 5000, '흰 마스크 5개');
insert into product values (7, '머리끈', 1000, '검은색 꽈배기 머리끈');
insert into product values (8, '충전기', 25000, '아이폰 전용 충전기'); 

select * from product;

-- 소비자를 등록합니다. (10명이상)
insert into consumer values (1, 'aaa', 20);
insert into consumer values (2, 'bbb', 23);
insert into consumer values (3, 'ccc', 22);
insert into consumer values (4, 'ddd', 23);
insert into consumer values (5, 'eee', 25);
insert into consumer values (6, 'fff', 24);
insert into consumer values (7, 'ggg', 27);
insert into consumer values (8, 'hhh', 26);
insert into consumer values (9, 'iii', 28);
insert into consumer values (10, 'jjj', 27);
insert into consumer values (11, 'kkk', 25);
insert into consumer values (12, 'lll', 26);
insert into consumer values (13, 'mmm', 23);
insert into consumer values (14, 'nnn', 24);
insert into consumer values (15, 'ooo', 20);
insert into consumer values (16, 'ppp', 21);

select * from consumer;

-- 소비자가 쇼핑한 상품을 추가합니다.
insert into cart values (1, 1, '2022-05-01', 4, 2);
insert into cart values (2, 2, '2022-02-24', 1, 1);
insert into cart values (3, 3, '2022-06-04', 2, 1);
insert into cart values (4, 4, '2022-04-18', 3, 3);
insert into cart values (5, 4, '2022-02-22', 6, 10);
insert into cart values (6, 5, '2022-03-10', 7, 5);
insert into cart values (7, 6, '2022-05-04', 8, 2);
insert into cart values (8, 7, '2022-04-03', 7, 4);
insert into cart values (9, 8, '2022-04-02', 2, 1);
insert into cart values (10, 14, '2022-03-01', 1, 3);
insert into cart values (11, 16, '2022-01-16', 4, 8);
insert into cart values (12, 15, '2022-06-01', 5, 4);
insert into cart values (13, 15, '2022-03-14', 2, 5);
insert into cart values (14, 12, '2022-02-11', 7, 3);
insert into cart values (15, 11, '2022-02-01', 5, 2);

select * from cart;

-- 쇼핑한 상품을 출력합니다.
select p.*
from cart c, product p
where c.product_id = p.product_id
and consumer_id = 1;


-- 소비자와 기간을 입력하면, 그 기간동안 구입한 물품이 출력됩니다.
select p.*
from cart c, consumer cm, product p
where c.consumer_id = cm.consumer_id
and c.product_id = p.product_id
and cm.consumer_id = 1
and c.purchase_date between '2022-04-01' and '2022-06-20';

