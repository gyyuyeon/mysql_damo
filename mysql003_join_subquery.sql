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

select e.employee_id, d.department_id, d.department_name
FROM employees e inner join departments d
on e.department_id = d.department_id;
 
 select *
 from employees e inner join departments d
 on e.department_id = d.department_id;
 
 
select e.employee_id, d.department_id, d.department_name
FROM employees e inner join departments d
on e.department_id = d.department_id;
 
select e.employee_id, d.department_id, d.department_name
FROM employees e , departments d
where e.department_id = d.department_id;

-- employees와 jobs테이블에서 사원번호(employee_id),
-- 업무번호(job_id), 업무명(job_title)을 검색하시오.

-- mysql oracle 에서 이렇게 ansi 에선 where
select e.employee_id , j.job_id, j.job_title
from employees e inner join jobs j
on e.job_id = j.job_id;
 
 -- job_id가 'FI_MGR'인 사원이 속한
 -- 급여(salary)의 최소값(min_salary), 최대값(max_salary)을 출력하시오.
 
-- ansi?
select e.salary , j.min_salary, j.max_salary
from employees e inner join jobs j
on e.job_id = j.job_id
where j.job_id ='FI_MGR';

-- mysql?
select e.salary , j.min_salary, j.max_salary
from employees e , jobs j
where e.job_id = j.job_id
and j.job_id ='FI_MGR';

select *    -- jobs 안에 전부 확인
from jobs;

-- 부서가 'Seattle'에 있는 부서에서 근무하는
-- 직원들의  first_name, hire_date, department_name, city
-- 출력하는 SELECT을 작성하시오.

select e.first_name, e.hire_date, d.department_name, l.city
	from employees e inner join departments d on e.department_id = d.department_id 
					 inner join locations l   on d.location_id = l.location_id
    where l.city = 'Seattle';
    
select e.first_name, e.hire_date, d.department_name, l.city
	from employees e, departments d, locations l  
    where e.department_id = d.department_id 
		and d.location_id = l.location_id
		and l.city = 'Seattle';
    
-- 20번 부서의 이름과 그 부서에 근무하는 사원의 이름(first_name)을 출력하시오.
select d.department_name,e.first_name
from departments d inner join employees e
	on d.department_id = e.department_id
    where d.department_id =20;

select d.department_id,d.department_name,e.first_name
from departments d, employees e
	where d.department_id = e.department_id
    and d.department_id =20;
    
-- 1400, 1500번 위치의 도시이름과 그 곳에 있는 부서의 이름을 출력하시오.
select l.city, d.department_name
from locations l inner join departments d
on l.location_id = d.location_id
where l.location_id in(1400,1500);

/*=================================================================
3. outer join
  한 테이블에는 데이터가 있고 다른 반대쪽에는 데이터가 없는 경우에
  데이터가 있는 테이블의 내용을 모두 가져오는 조건이다.
  ===============================================================*/
select *
from employees e left outer join departments d  -- 공통적인게 없는건 그냥 null로 채워서 다가지고 옴  ceo null
on e.department_id = d.department_id;   -- 나머진 컬럼값 가지고옴
	
select e.first_name, e.salary, d.department_name
from employees e left outer join departments d  
on e.department_id = d.department_id; 

select e.first_name, e.salary, d.department_name
from employees e right outer join departments d  -- 사원이 배정이 되지않는 부서정보도
on e.department_id = d.department_id; 

/*
select e.first_name, e.salary, d.department_name
from employees e full outer join departments d  -- 지원이 안됨
on e.department_id = d.department_id;*/


/*=================================================
4. self join
 하나의 테이블을 두개의 테이블로 설정해서 사용하는 조인방법이다.
 하나의 테이블에 같은데이터가 두개의 컬럼에 다른 목적으로 저장되여 있는 경우
 employees, employee_id, manager_id
====================================================*/
-- 사원번호  사원명 관리자명
-- 10     홍길동  null
-- 20     김민재   10
-- 30     이정진   10
-- 40     이옥순   20

select employee_id , first_name, manager_id
from employees
where employee_id =200;

select employee_id , first_name, manager_id
from employees
where employee_id =101;

select employee_id , first_name, manager_id
from employees
where employee_id =100;

select employee_id , first_name, manager_id
from employees e
where employee_id =108;

select employee_id , first_name, manager_id
from employees e, employees m
where employee_id =101;

select e.employee_id 사원번호 , e.first_name 사원명, e.manager_id 관리자번호, m.first_name 관리자명
from employees e inner join employees m
on e.manager_id = m.employee_id
where e.employee_id =108;

/*------------------------------------------------------
 4. Nature Join
 반드시 두 테이블 간의 동일한 이름, 타입을 가진 컬럼이 필요하다.
조인에 이용되는 컬럼은 명시하지 않아도 자동으로 조인해 사용된다.
동일한 이름을 갖는 컬럼이 있지만 데이터 타입이 다르면 에러가 발생한다.
조인하는 테이블 간의 동일 컬럼이 SELECT절에 기술되도 테이블 이름을 생략해야 한다.
--------------------------------------------------------*/
-- 두 테이블에서 일치하는 컬럼이 하나이므로 정상적으로 처리를 한다. -107
select e.first_name, j.job_id, j.job_title -- 일치하는 컬럼명이 하나만 있어야 한다 이거처럼
from employees e natural join jobs j;

-- 두 테이블에서 일치하는 컬럼이 두개이므로 정상적으로 처리를 못 한다. -32
select e.first_name, d.department_id, d.department_name   -- 일치하는 컬럼명이 하나만 있어야 하는데 두개있음
from employees e natural join departments d;

-- 두테이블의 컬럼명이 같으면 using을 이용해서 사용할 수 있다.
select e.first_name, d.department_id, d.department_name   -- 일치하는 컬럼명이 하나만 있어야 하는데 두개있음
from employees e inner join departments d
-- on e.department_id = d.department_id; -- 106
using(department_id); -- 위에거랑 같지만 권장하진 않음
