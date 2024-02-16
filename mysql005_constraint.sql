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

insert into emp2(id, name, loc, salary,code) -- primary 로 설정되어있기 때문에 참조값이나 null값만 가능하다 // p001이거나 null값만 저장가능
values('a003', '진영구','제주',6000,'k001');

