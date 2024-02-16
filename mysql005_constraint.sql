/*===============================================
무결성 제약조건
   무결성이 데이터베이스 내에 있는 데이터의 정확성 유지를 의미한다면
   제약조건은 바람직하지 않는 데이터가 저장되는 것을 방지하는 것을 말한다.
   무결성 제약조건 6종류 : not null, unique, primary key, foreign key, check, default
    not null : null를 허용하지 않는다.
    unique : 중복된 값을 허용하지 않는다. 항상 유일한값이다.
    primary key : not null + unique
    foreign key : 참조되는 테이블의 컬럼의 값이 존재하면 허용된다.
    check : 저장 가능한 데이터값의 범위나 조건을 지정하여 설정한 값만을 허용한다.
	default : 기본값을 설정한다.
    =====================================================*/

create table dept1(
code varchar(10) primary key);

create table emp1(
id varchar(10) primary key,
name varchar(20) not null,
loc varchar(10),                      -- 기본적으로 아무거도 안하면 null값들 허용 한다는의미
salary int default 3000
);

-- mywork 데이터 베이스에 생성된 table 확인
select*from information_schema.tables
where table_schema = 'mywork';

-- mywork 데이터 베이스에 생성된 constraints 확인
select*from information_schema.table_constraints
where table_schema = 'mywork';

select*from emp1;
insert into emp1
values('a001','홍길동','지역',5000);
select*from emp1;

insert into emp1(id, name, loc)
values('a002','김민재','서울');
select*from emp1;

create table emp2(
id varchar(10) ,
name varchar(20) not null,
loc varchar(10),                    
salary int default 3000,
code varchar(10),
constraint emp2_id_pk primary key(id),
constraint emp2_code_fk foreign key(code) references dept1(code)
);

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork';

INSERT into dept1
values('p001');
SELECT*from dept1;
SELECT*from emp2;

INSERT into emp2
VALUES('a001','김연아','서울',5000,'p001');
SELECT*from emp2;

-- code는 foreign key로 제약조건이 설정되어 있으므로 null이 가능하다
insert into emp2(id, name, loc, salary)
values('a002', '이수영','경기',8000);
SELECT*from emp2;

insert into emp2(id, name, loc, salary,code) -- 오류 primary 로 설정되어있기 때문에 참조값이나 null값만 가능하다 // p001이거나 null값만 저장가능
values('a003', '진영구','제주',6000,'k001');
SELECT*from emp2;

-- id 컬럼은 primary key 제약조건이 설정되어 있으므로 unique + not null 만 가능하다
insert into emp2(id, name, loc) -- 오류 primary 로 설정된것은 고유값과 null만 가능 // 중복되면 안됨
values('a002', '마이상','대전');

insert into emp2(id, name, loc) -- 
values('a004','홍길동','대구');


insert into emp2(id, name, loc) -- not null 만 아니면 중복도 가능하다
values('a005','홍길동','대치');
SELECT*from emp2;

insert into emp2(id, name, loc) -- null 이라 오루가 난다
values('a006','대치');

-- emp2테이블에 gen 컬럼을 추가한다.
alter table emp2
add gen char(1) check (gen in ('m','w'));
SELECT*from emp2;

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork';

SELECT*from emp2;

insert into emp2
values('a006','전진구','수원',5000,'p001','m');
SELECT*from emp2;

-- 설정되어있는 제약조건을 제거
/*=================================================
제약조건 삭제
 ALTER TABLE table_name
  DROP constraint constraint_name
======================================================*/

-- foreign key 제약조건 삭제
alter Table emp2
drop constraint emp2_code_fk;

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork';

-- foreign key 제약조건 삭제
alter Table emp2
drop constraint emp2_chk_1;

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork'; 

-- primary key 제약조건 삭제 
alter table emp2
drop primary key; --   drop constraints primary key    오류가 뜸

-- salary 컬럼에 설정된 default 값 확인
desc emp2;

-- default 값 제거
alter table emp2 
alter salary drop DEFAULT;

-- name 컬럼에 not null 삭제
alter table emp2
modify column name varchar(20);

/*=======================================================================
제약조건 추가
  ALTER TABLE table_name
       ADD constraint constraint_name constraint_type(column_name)
=========================================================================*/
-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork'; 

-- emp2 테이블의 code 컬럼에 foreign key 제약조건 추가
alter table emp2
add constraint emp2_code_fk foreign key(code) references dept1(code);

-- emp2 테이블의 gen 컬럼에 check 제약조건 추가
alter table emp2
add CONSTRAINT emp2_gen_chk check(gen in('m','w'));

-- emp2 테이블의 id컬럼에 primary key 제약조건 추가
alter table emp2
add constraint emp2_id_pk primary key(id);

-- emp2 테이블의 salary 컬럼에 default 제약조건 추가
ALTER TABLE emp2
modify COLUMN salary int DEFAULT 3000;

-- salary 컬럼에 default 제약조건 확인
desc emp2;

-- emp2 테이블의 name 컬럼에 not null 제약조건 추가
alter table emp2 
modify COLUMN name varchar(20) not null;

-- name 컬럼에  not null 제약조건 확인
desc emp2;

-- emp2 테이블의 name 컬럼에 not null 제약조건 추가

-- emp2 테이블의 bs 컬럼 unique제약조건 추가 -- 내가 삭제를 했던가 unique는 무슨 제약조건이지
alter table emp2 
add bs varchar(10) unique;

SELECT*from emp2;

insert into emp2
values('a007','박다영','광주',7000,'p001','w','ko');
SELECT*from emp2;

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork'; 

-- emp2 테이블 bs컬럼의 unique 제약조건 삭제
alter table emp2
drop CONSTRAINT bs;

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork'; 

-- emp2 테이블 bs컬럼의 unique 제약조건 추가
alter table emp2
add constraint emp_bs_u unique(bs);

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork'; 

-- 두테이블의 데이터 다른거 관계설정
-- =============================================
-- dept1(code), emp2(code)  // primate // foreign

select *from  dept1;
select*from emp2;

-- error -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`mywork`.`emp2`, CONSTRAINT `emp2_code_fk` FOREIGN KEY (`code`) REFERENCES `dept1` (`code`))
delete from dept1   -- 다른 테이블에서 참조중이어서
where code = 'p001';
-- same error
update dept1
set code = 'm001';

insert into dept1
values('p002');
select *from  dept1;

-- dept1테이블의 code 컬럼의 'p002'의 값을 다른 테이블에서 참조를 안하고 있기 때문에 수정이나 삭제가 가능하다
update dept1
set code = 'm001'
where code = 'p002';
select *from  dept1;

-- > 1. 연걸을 끊으면 가능하긴함 // p001
/*==================================================
부모키가 수정,삭제가 되면 참조되는 키도 수정, 삭제가 되도록 cascade를 설정한다.
수정 : ON UPDATE CASCADE
삭제 : ON DELETE CASCADE
=====================================================*/
create table dept2(
code varchar(10),
dname varchar(20)
);
insert into dept2
values('p001','visit');

insert into dept2
values('p002','hello');

alter table dept2
add constraint primary key(code);
-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork'; 

select*from dept2;

drop table if exists emp3;

-- 참조 관계설정 예시테이블 원래  참조하던 dept1은 불가해서 dept2를 만들어서 새로함 
-- 참조를 하는 컬럼은 널값과 참조에 포함 되어있는 것만 가능함
CREATE table emp3(
id varchar(10) primary key ,
name varchar (20) not null,
code varchar(10),
constraint emp3_code_fk foreign key(code) references dept2(code) -- 관계설정
on delete cascade 
on update cascade);

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork'; 

select*from emp3;

insert into emp3
VALUES('a001','홍길동','p001');
select*from emp3;

insert into emp3
VALUES('a002','김민재',null);
select*from emp3;

insert into emp3
VALUES('a003','이수연','p002');
select*from emp3;

-- 부모값이 바뀌면 자식값이 바뀐다
update dept2  
set code = 'm001'
where code = 'p001';
select*from dept2;
select*from emp3;







