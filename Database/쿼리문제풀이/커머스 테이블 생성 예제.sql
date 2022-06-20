create database shopping;

use shopping;

create table member (
	member_id char(10),
    phone char(11),
    password varchar(10),
    family_name varchar(50),
    first_name varchar(50),
    address varchar(200)
);

alter table member add primary key (member_id);

desc member;

create table product (
	product_id int primary key,
    product_name varchar(50),
    image varchar(200),
    price char(10),
    product_desc varchar(200)
);

desc product;

create table orders (
	order_id int primary key,
    count int,
    price int,
    order_datetime datetime,
    zipcode char(5),
    address varchar(200),
    member_id char(10),
    product_id int,
    foreign key (member_id) references member(member_id),
    foreign key (product_id) references product(product_id)
);

desc orders;


create table cart_product (
	product_id int,
    member_id char(10),
    count int,
    product varchar(50),
    price int,
    foreign key (product_id) references product(product_id),
    foreign key (member_id) references member(member_id),
    primary key (product_id, member_id)
);

desc cart_product;

create table creditcard (
	card_id char(16) primary key,
    c_company varchar(50),
    c_expiredaste char(5),
    member_id char(10),
    foreign key (member_id) references member(member_id)
);

desc creditcard;

create table destination(
	dest_id int primary key,
    zipcode char(5),
    address varchar(200),
    member_id char(10),
    foreign key (member_id) references member(member_id)	
);

desc destination;

