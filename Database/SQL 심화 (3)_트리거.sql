/*
	trigger : 촉발하다. == callback
    before, after
    function처럼 호출하는게 아닌 자동호출되는 것이 트리거!
    
    delimiter // 
		create trigger 트리거명
			(before | after)	(insert | update | delete)
            on 테이블명
            for each row
		begin
			쿼리문
        end;
    
    //
    delimiter ;
    
*/

-- 저장(검사) 테이블
create table deptUpdate(
	oldname varchar(30),
    newname varchar(30)
);

delimiter //
create trigger trigger_test
	before update
    on departments
    for each row
begin
	insert into deptUpdate(oldname, newname)
    values (old.department_name, new.department_name); -- old.department_name : 변경되기 전 이름
end;
//
delimiter ;

update departments
set department_name = '총괄본부'
where department_id = 300;

select * from deptUpdate;

