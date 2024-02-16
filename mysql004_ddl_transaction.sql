/*==========================================================
SQL의 분류
1 DQL(Data Query Language 데이터 질의어) : 
  데이터를 검색해서 추출할때 사용된다.(select)
2 DML(Data Manipulation Language 데이터 조작어) : 
  데이터는 추가, 수정, 삭제,병합해주는 명령어들이다.
  (insert, update, delete,merge)
3 DDL(Data Definition Language 데이터 정의어 ) : 
  테이블의 구조를 정의, 변경해주는 명령어들이다.
  (create, drop, alter, truncate)
4 DCL(Data Control Language 데이터 제어어) : 
  사용자의 권한을 부여,제거해주는 명령어들이다.(grant ,revoke)
5 TCL(Transaction Control Language 트랜잭션 처리어) : 
  트랜잭션 설정,취소을 처리해주는 명령어들이다
  (commit, rollback, savepoint)
==========================================================*/


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

update members
set age= 50
where name = '홍길동';

select*from members;

/*=============================================
테이블의 내용을 삭제하는 명령어이다.
DELETE
DELETE FROM table_name WHERE column_name = value;
===============================================*/

delete from members 
where name = '박차고 나온 세상에';

/*=================================================================
트랜잭션(Transaction)   -- acid(4가지 기억)
1 트랜잭션 정의
  -한번에 수행되어야 할 데이터베이스의 일련의 Read와
   Write 연산을 수행하는 단위
  -하나의 논리적 기능을 수행하기 위한 작업의 단위로서
  데이터베이스의 일관된 상태를 또 다른 일관된 상태로
  변환시킴
  
  트랜잭션시작-> 수정->삭제->삽입 -> 트랜잭션종료
  하나의 작업이 시작해서 정상적으로 종료될때까지의 과정을 말한다.
  (논리적인 작업단위)
  
  은행(ATM)->기계 카드삽입-> 기계가 카드를 읽음->
  인출금액 입력-> 비밀번호 입력-> 기계에서 출금액 처리
  -> 출금금액 제공-> 카드제공
  
  <트랜잭션 시작>
  -데이터베이스에 처음 접속했을 때
  -하나 또는 여러 개의 DML문이 실행된후 commit 또는 rollback
   문이 실행된 직후
  
   <트랜잭션 종료>
  - commit 또는 rollback문이 실행될때
  - DDL 또는 DCL문이 실행될 때
  - 정상적으로 데이터베이스를 종료할때
  - 비정상적으로 데이터베이스를 종료할때
  
2 트랜잭션 안전성 확보를 위한 ACID
  1) ACID정의 
     -데이터베이스에서 논리적인 작업단위인 트랜잭션이
       안전하게 수행되는 것을 보장하는 특성집합
  2) ACID의 필요성
     -다중 사용자 환경 대응 :동일데이터-다중작업환경에서의
          데이터 처리 정확성 보장
     -안전한 트랜잭션 수행을 통한 데이터베이스 무결성 유지
  3) 트랜잭성 구성요소   
    Atomicity(원자성):
     -트랜잭션은 한 개 이상의 동작을 논리적으로 한 개의
      작업단위(single unit of work)로서 분해가
      불가능한 최소의 단위
     -연산 전체가 성공적으로 처리되거나 또는 한 가지라도
      실패할 경우 전체가 취소되어 무결성을 보장
      (All or Nothing)
    Consistency(일관성):
    -트랜잭션이 실행을 성공적으로 완료하면 언제나 모순 없이
     일관성 있는 데이터베이스 상태를 보존함
    - 테이블의 데이타는 갱신되고 그에 따른 인덱스는 갱신되지 않는 등의 부정합이 있어선 않된다.
    Isolation(고립성,독립성):
    -트랜잭션이 실행 중에 생성하는 연산의 중간 결과를
     다른 트랜잭션이 접근할 수 없음
   -커밋된 트랜잭션은 장애가 발생해도 데이타가 복구되여야 한다는 특성.
   Durability(영속성,지속성,내구성):
    -성공이 완료된 트랜잭션의 결과를 영구적으로 데이터베이스에
     저장됨
========================================================================================*/

-- MySQL 5에서는 트랜잭션 격리 수준
SHOW VARIABLES WHERE VARIABLE_NAME='tx_isolation';

-- MySQL 8에서는 트랜잭션 격리 수준
SHOW VARIABLES WHERE VARIABLE_NAME='transaction_isolation';

commit;

-- 수동으로 트랜잭션 시작
start transaction;
select * from members;
delete from members
where name = '홍길동'; -- 삭제
select * from members;
rollback; -- 취소 + 수동 트랜잭션 취소

-- 자동 트랜잭션 시작
select * from members;

insert into members
VALUES('김연아' , 34 , 100 ,curdate(),'경기');
select * from members;

rollback; -- 현재 상태가 자동트랜잭션 이기때문에 실행되지 않음
select * from members;

/*자동커밋 설정 확인(MYSQL Workbench)
Edit >  Preferences > SQL Editor > SQL Execution
 > New connections use auto commit mode > OK > 재시작*/
 
 -- 현재 상태 확인  1 로 나오면 오토커밋이 활성화 되어 있는것
 select @@AUTOCOMMIT;
 
 -- AUTOCOMMIT 해제
 set AUTOCOMMIT = 0;
 
 delete from members
 where name='김연아';
 select * from members;
 
rollback; -- 오토커밋이 꺼져서 다시 되살아나기 성공
select * from members;
 
 
 
 
 
 
 
 
 




