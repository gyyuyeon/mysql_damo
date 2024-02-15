/*===============================
테이블 구조 정의
CREATE TABLE table_name(
  column_name datatype,
  column_name datatype
);

자료형(datatype)
varchar - 가변길이 문자를 저장
char - 고정길이 문자를 저장
int-정수저장
decimal(m,n)- 실수저장
date - 날짜 저장
===============================*/

use mywork;
create table student(
name varchar(20),
age int,
avg decimal(5,2),
hire date
);
select*from student;

-- 테이블 구조 확인
desc student;

-- 데이터 삽입
insert into student(name, age, avg, hire)
VALUES('홍길동', 30,97.85,curdate());
select*from student;

insert into student(name, age, avg, hire)
VALUES('김민재', 28,80.2,sysdate());  -- 노란 세모 날짜시간 다넣어서  위에는 날짜만 넣는다고 했는데
select*from student;

insert into student
VALUES('이수리', 30,97.85,curdate());
select*from student;

insert into student(name, age) -- null값으로 빈자리 채워짐
VALUES('세기동', 10);
select*from student;

insert into student -- 명시 안했을때 null을 넣어야함
VALUES('흰둥이', 15,97.85,null);
select*from student;

insert into student(name, age, avg, hire)
VALUES('박차고 나온 세상에', 30,97.85,curdate());
select*from student;

insert into student(name, age, avg, hire)
VALUES('박차고 나온 세상에12312421541`25214', 30,97.85,curdate());  -- 20자 이상이라 안됨
select*from student;

insert into student(name, age, avg, hire)
VALUES('박차고 나온 세상에', 30,9227.85,curdate()); -- 전체길이 5 소숫점 2
select*from student;

insert into student(name, age, avg, hire)
VALUES('박차고 나온 세상에', 30,227.8522,curdate()); -- 전체길이 5 소숫점은 넘으면 2자리까지 반올림
select*from student;

-- create talbe; create view , create index
/*====================================
ALTER 
 객체(테이블)의 구조를 변경해주는 명령어이다.
======================================*/
-- 생성 : CREATE TABLE,  CREATE VIEW, CREATE INDEX
-- 수정 : ALTER TABLE, ALTER VIEW, ALTER INDEX, ALTER USER

-- 테이블에 커럶을 추가한다.
alter TABLE student 
add loc varchar(30);

desc sudent;

SELECT*from student; 

-- 테이블의 컬럼명을 수정한다
alter table student 
rename column avg to jumsu;

alter table student  -- 벗어나는 에러
modify name varchar(3);

alter table student  
modify name varchar(10);

-- 테이블 명 면경
alter table student 
rename to members;

desc members;

/*=======================================
테이블의 내용을 수정하는 명령어이다.
UPDATE 테이블명 
SET 컬럼1=값1, 컬럼2=값2 
WHERE 컬럼=값;
=========================================*/

alter table members
modify name constraint mem_name_pk primary key;

update members
set age= 50
where name = '홍길동';