/*=========================================================================
데이터 딕셔너리(Data Dictionary)
  데이터베이스를 운영하기 위한 정보들을 모두 특정한 곳에 모아두고 관리하는데 
  이것을 데이터 딕셔너리라고 한다.
  데이터 딕셔너리는  메모리구조와 파일에 대한 구조정보, 
  각 오브젝트들이 사용되는 공간들의 정보, 제약조건 정보,
  사용자에 대한 정보, 권한등에 대한정보들을 관리한다.
===========================================================================*/
-- 현재 생성된 데이터베이스 확인
show DATABASES;

-- information_schema 데이터 베이스 선택
use information_schema;
show tables;

select * from tables;


select * from information_schema.tables;

use mywork;
select * from information_schema.tables;  -- use를 사용하지 않아도 다른 schemas 를 사용할수 있는방법
select * from information_schema.table_constraints; -- 제약조건이 있는 테이블

