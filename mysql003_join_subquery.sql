/*=======================================================
join : 여러개의 테이블에서 원하는 테이블을 추출해주는 쿼리문이다.
모든 제품에서 공통적으로 사용되는 표준(ANSI) join이 있다.
========================================================*/

-- 1. carteian product(카티션 곱) 조인 : 
--   테이블 행의 갯수만큼 출력해주는 조인이다.

select count(*) FROM employees; -- 107
select count(*) FROM departments; -- 27
select 107*27; -- 2889

select e.department_id, d.department_name , e.first_name
from employees e cross join departments d;

/*
 2. inner join
    가장 많이 사용되는 조인방법으로 조인 대상이 되는 두 테이블에서 공통적으로 존재하는 컬럼의 값이
    일치되는 행을 연결하여 결과를 생성하는 방법이다.
 */
 
 select e.department_id, e.first_name, e.job_id, j.job_title
 FROM employees e inner join jobs j
 on e.job_id = j.job_id;
 
 select count(job_id) from employees;
 
 select e.department_id, e.first_name, d.department_name 
 FROM employees e inner join departments d
 on e.department_id = d.department_id;
 
 select count(department_id) from employees;
 
 select e.department_id, e.first_name, e.job_id, j.job_title
 from employees e, jobs j
 where e.job_id = j.job_id;
 
 select department_id, count(*)
 FROM employees
 GROUP BY department_id;
 
 -- employees와 departments테이블에서 사원번호(employee_id),
-- 부서번호(department_id), 부서명(department_name)을 검색하시오.
 
 
 
 
 