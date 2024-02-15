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

/*-----------------------------------------------------------------------------------------
서브쿼리(subquery)
 하나의 SQL문안에 포함되어 있는 또 다른 SQL문을 말한다.
 서브쿼리는 알려지지 않은 기준을 이용한 검색을 위해 사용한다.
 서브쿼리는 메인쿼리가 서브쿼리를 포함하는 종속적인 관계이다.
 서브쿼리는 메인쿼리의 컬럼을 모두 사용할 수 있지만 메인쿼리는 서브쿼리의 컬럼을 사용할 수 없다. 
 질의 결과에 서브쿼리 컬럼을 표시해야 한다면 조인방식으로 
    변환하거나 함수, 스칼라 서브쿼리(scarar subquery)등을 사용해야 한다. 
 조인은 집합간의 곱(Product)의 관계이다. 
 
외부 쿼리 (메인쿼리)
 :일반 쿼리를 의미합니다.
스칼라 서브쿼리
 :SELECT 절에 쿼리가 사용되는 경우로, 함수처럼 레코드당 정확히 하나의 값만을 반환하는 서브쿼리입니다.
인라인 뷰
 :FROM 절에 사용되는 쿼리로, 원하는 데이터를 조회하여 가상의 집합을 만들어 조인을 수행하거나 가상의 집합을 다시 조회할 때 사용합니다.



서브쿼리를 사용할 때 다음 사항에 주의
  서브쿼리를 괄호로 감싸서 사용한다. 
  서브쿼리는 단일 행(Single Row) 또는 복수 행(Multiple Row) 비교 연산자와 함께 사용 가능하다. 
  단일 행 비교 연산자는 서브쿼리의 결과가 반드시 1건 이하이어야 하고 복수 행 비교 연산자는 서브쿼리의 결과 건수와 상관 없다. 
  서브쿼리에서는 ORDER BY를 사용하지 못한다. 
  ORDER BY절은 SELECT절에서 오직 한 개만 올 수 있기 때문에 ORDER BY절은 메인쿼리의 마지막 문장에 위치해야 한다.
  

서브 쿼리 사용가능한 위치
SELECT, FROM, WHERE, HAVING,ORDER BY 
INSERT문의 VALUES,
UPDATE문의 SET, 
CREATE문

서브쿼리의 종류는 동작하는 방식이나 반환되는 데이터의 형태에 따라 분류할 수 있다.
1 동작하는 방식에 따른 서브쿼리 분류
  Un-Correlated(비연관) : 서브쿼리가 메인쿼리 컬럼을 가지고 있지 않는 형태의 서브쿼리이다.
          메인쿼리에 값(서브쿼리가 실행된 결과)를 제공하기 위한 목적으로  주로 사용한다.
  Correlated(연관) : 서브쿼리가 메인쿼리 칼럼을 가지고 있는 형태의 서브쿼리이다.
          일반적으로 메인쿼리가 먼저 수행되어 읽혀진 데이터를 서브쿼리에서 조건이 맞는지 확인
	  하고자 할 때 주로 사용된다.  (EXISTS서브쿼리는 항상 연관 서브쿼리로 사용된다. 조건을 만족하는 1건만 찾으면
	  추가 검색을 하지 않는다.)
2 반환되는 데이터의 형태에 따른 서브쿼리 종류
  Single Row(단일행 서브쿼리) : 서브쿼리의 실행결과가 항상 1건 이하인 서브쿼리를 의미한다. 
          단일행 서브쿼리는 단일 행 비교 연산자와 함께 사용된다.
	  단일 행 비교 연산자는 =, <, <=, >, >=, <>이 있다.
  Multi Row(다중행 서브쿼리) : 서브쿼리의 실행 결과가 여러 건인 서브쿼리를 의미한다. 
          다중 행 서브쿼리는 다중 행 비교 연산자와 함께 사용된다. 
	  다중 행 비교 연산자에는 in, all, any, some, exists가 있다.
	      in : 메인쿼리의 비교조건('='연산자로 비교할 경우)이 서브쿼리의 결과 중에서
               하나라도 일치하면 참이다.
           any,some : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나 이상이 일치하면
                참이다.
           all : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치하면 참이다.
           exists : 메인 쿼리의 비교 조건이 서브 쿼리의 결과 중에서 만족하는 값이 하나라도
               존재하면 참이다.
  Multi Column(다중칼럼 서브쿼리) : 서브쿼리의 실행 결과로 여러 컬럼을 반환한다.
          메인쿼리의 조건절에 여러 컬럼을 동시에 비교할 수 있다. 
	  서브쿼리와 메인쿼리에서 비교하고자 하는 컬럼 갯수와 컬럼의 위치가 동일해야 한다.
--------------------------------------------------------------------------------- */ 
-- 90번 부서에 근ㄴ무하는 Lex의 부서명을 출력하시오
select department_name
from departments
where department_id = 90;

-- Lex가 근무하는 부서명을 출력하시오
select department_id 
from employees
where first_name = 'Lex';

select department_name
from departments
where department_id = 90;

select d.department_name
from employees e inner join departments d
on e.department_id = d.department_id
where e.first_name = 'Lex';

select department_name
from departments
where department_id = (select department_id 
						from employees
						where first_name = 'Lex');
            
-- 'Lex'와 동일한 업무(job_id)를 가진 사원의 이름(first_name), 
 -- 업무명(job_title), 입사일(hire_date)을 출력하시오.
 
 select e.first_name, j.job_title, e.hire_date
 from employees e inner join jobs j
on e.job_id = j.job_id
where j.job_title = 'Administration Vice President';

select e.first_name, j.job_title, e.hire_date
from employees e inner join jobs j
on e.job_id = j.job_id
where e.job_id = (select job_id 
						from employees
						where first_name = 'Lex');

-- 'IT'에 근무하는 사원이름(first_name), 부서번호을 출력하시오.


select first_name, department_id
from employees 
where department_id = (select department_id 
						from departments
						where department_name ='IT');


-- 'Bruce'보다 급여를 많이 받은 사원이름(first_name), 부서명, 급여를 출력하시오.
select e.first_name, d.department_name, e.salary
from employees e inner join departments d
on e.department_id = d.department_id
where salary > (select salary
				from employees
                where first_name ='Bruce')
order by salary;

-- Steven와 같은 부서에서 근무하는 사원의 이름, 급여, 입사일을 출력하시오.(in)  -- 1개의 행보다 더많은 정보가 리턴(실행안됨)
-- 오류 예제
select first_name, salary, hire_date
from employees
where department_id = ( select department_id
						from employees
                        where first_name = 'Steven');
-- 수정 예제
select first_name, salary, hire_date
from employees
where department_id in (50,90);

-- 수정 예제 최종
select first_name, salary, hire_date
from employees
where department_id in ( select department_id
						from employees
                        where first_name = 'Steven');

-- 부서별로 가장 급여를 많이 받는 사원이름, 부서번호, 급여를 출력하시오.(in)
select department_id, max(salary)
from employees
group by department_id;

select first_name, department_id, salary
from employees
where (department_id, salary) in ( select department_id, max(salary) -- where 자리에선 컬럼이 와야되지 그룹함수가 오면 안된다 max(salary)
										from employees
										group by department_id)
ORDER BY department_id asc;


-- 30소속된 사원들 중에서 급여를 가장 받은 사원보다 더 많은 급여를 받는
-- 사원이름, 급여, 입사일을 출력하시오. (ALL)
-- (서브쿼리에서 max()함수를 사용하지 않는다);

select salary
from employees
where department_id = 30;


-- 모든것에 관하여 만족
select first_name, salary, hire_date
from employees
where salary > all(select salary
				   from employees
				   where department_id = 30);

-- 30소속된 사원들이 받은 급여보다  높은 급여를 받는 
-- 사원이름, 급여, 입사일을 출력하시오. (ANY)
-- (서브쿼리에서 min()함수를 사용하지 않는다);

select first_name, salary, hire_date
from employees
where salary > any(select salary
				   from employees
				   where department_id = 30);
                   
-- 사원이 있는 부서만 출력하시오.
SELECT department_id, department_name
from departments;  -- 27 row

select distinct department_id  -- 중복제거 한번만 select자리에서
from employees;  -- 12개

SELECT department_id, department_name -- 11개
from departments
where department_id in (select distinct department_id
						from employees);


/*-----------------------------------------------------
 상관관계 서브쿼리
 : 서브쿼리에서 메인쿼리의 컬럼을 참조한다.(메인쿼리를 먼저수행한다.)
   서브쿼리는 메인쿼리 각각의 행에 대해서 순서적으로 한번씩 실행한다.
 <아래 쿼리 처리순서>
 1st : 바깥쪽 쿼리의 첫째 row에 대하여 
 2nd : 안쪽 쿼리에서 자신의 속해있는 부서의 MAX salary과
       비교하여 true 이면 바깥의 컬럼값을 반환하고 , 
       false 이면 값을 버린다. 
 3rd : 바깥쪽 쿼리의 두 번째 row에 대하여 마찬가지로 실행하며, 
       이렇게 바깥쪽 쿼리의 마지막 row까지 실행한다. 
	   
https://www.w3resource.com/sql/subqueries/correlated-subqueries-using-aliases.php	   
----------------------------------------------------*/

-- 부서별 최고 급여를 받는 사원을 출력하시오.

select department_id, max(salary)
from employees
group by department_id;

select department_id, salary, first_name, hire_date
from employees
where (department_id, salary) in ( select department_id, max(salary) -- where 자리에선 컬럼이 와야되지 그룹함수가 오면 안된다 max(salary)
										from employees
										group by department_id);

select department_id, salary, first_name, hire_date
from employees e
where salary = (select max(salary)
				from employees
                where department_id = e.department_id)
order by department_id;

select department_id , salary
from employees;

-- 사원이 없는 부서만 출력하시오


select distinct department_id
from employees;  -- 12row

select department_id
from departments;  -- 27row

select department_id, department_name
from departments 
where department_id not in (select distinct department_id
							from employees
                            where department_id is not null);  -- 16

select department_id, department_name
from departments d
WHERE not exists (select 1 
			from employees e
            where e.department_id = d.department_id);  -- 16
        
-- ???/ 
 SELECT 
    DEPARTMENT_ID, DEPARTMENT_NAME
FROM
    departments d
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            employees e
        WHERE
            e.DEPARTMENT_ID = d.DEPARTMENT_ID);           
            
            
-- 관리자가 있는 사원의 정보만 출력하시오
select e.employee_id, e.first_name, e.department_id
from employees e
where  exists ( select 1
				from employees m
				where m.employee_id = e.manager_id);
                
-- 관리자가 없는 사원의 정보만 출력하시오
select e.employee_id, e.first_name, e.department_id
from employees e
where not exists ( select 1
				from employees m
				where m.employee_id = e.manager_id);
                
/*=============================
 WITH ROLLUP
 총합 또는 중간 합계가 필요할때 GROUP by 절과 함께 WITH ROLLUP문을 사용한다.
 ================================*/
 
 select department_id, job_id, count(*) as count
 FROM employees
 GROUP BY department_id, job_id with rollup
 order by department_id desc, job_id desc;
 
 /*=============================
 WITH ROLLUP
 총합 또는 중간 합계가 필요할때 GROUP by 절과 함께 WITH ROLLUP문을 사용한다.
 ================================*/

SELECT department_id, job_id, count(*) as count
FROM employees
GROUP BY department_id, job_id WITH ROLLUP 
ORDER BY department_id DESC, job_id DESC;

/*=================================================================================
 그룹내 순위관련함수
 RANK( ) OVER( ) : 특정 컬럼에 대한 순위를 구하는 함수로 동일한 값에 대해서는 동일한 순위를 준다.  OVER()안에 정렬 기준이 되는 값이 필요
 DENSE_RANK( ) OVER( ) : 동일한 순위를 하나의 건수로 취급한다. OVER()안에 정렬 기준이 되는 값이 필요
 ROW_NUMBER( ) OVER( ) : 동일한 값이라도 고유한 순위를 부여한다.
 ===================================================================================*/
 /* RANK      DENSE_RANK   ROW_NUMBER
90   1         1         1
90   1         1         2
85   3         2         3
80   4         3         4
*/

SELECT job_id, first_name, salary, RANK() OVER(ORDER BY salary DESC)
FROM employees;
 
SELECT job_id, first_name, salary, DENSE_RANK() OVER(ORDER BY salary DESC)
FROM employees;

SELECT job_id, first_name, salary, ROW_NUMBER() OVER(ORDER BY salary DESC)
FROM employees;

SELECT job_id, first_name, salary,  ROW_NUMBER() OVER()
FROM employees;

-- 그룹별로 순위를 부여할 때 사용 : PARTITION BY
SELECT job_id, first_name, salary, RANK() OVER(PARTITION BY job_id ORDER BY salary DESC)
FROM employees;

SELECT job_id, first_name, salary, DENSE_RANK() OVER(PARTITION BY job_id ORDER BY salary DESC)
FROM employees;

-- =============================================================================================
-- 급여가 가장 높은 상위 3명을 검색하시오.
SELECT first_name, salary
FROM employees
ORDER BY salary DESC
limit 3;  -- 개수
 
 select row_number() over(order by salary desc) as rownm, first_name, salary
 from employees
 limit 0, 1;
 
  -- 급여가 가장 높은 상위 4위부터 8위까지 검색하시오.
 select row_number() over(order by salary desc) as rownm, first_name, salary
 from employees
 limit 3, 5;
 
  select row_number() over(order by salary desc) as rownm, first_name, salary
 from employees
 limit 5 offset 3;
 

 -- 월 별 입사자 수를 조회하되 입사자수가 가장 많은 상위 3개만 출력되도록 하시오.
--  <출력:   월     입사자수 >
select month(hire_date), count(*)
from employees
GROUP BY month(hire_date)
order by count(*) desc	
limit 3;


/*==========================================================
with절과 cte
with절은 cte(common table expression)을 표현하기 위한 구문으로 mysql8.0부터 사용할 수 있다.
cte는 기존의 뷰,파생 테이블, 임시 테이블 등으로 사용돠ㅣ던 것을 대신할 수 있다.
cte는 ansi-sql99 표준에서 나온것이다. 기존의 sql ansi-sql92를 기준으로 한다
최근의 DBMS(DataBase Management System)은 대게 ANSI-SQL99와 호환되므로 다른 DBMS에서도 같거나
비슷한 방식으로 응용한다.
CTE는 비재귀적(Non-Recursive) CTE와 재귀적(Recursive) CTE두가지가 있다.

<비재귀적(Non-Recursive)>
WITH CTE_테이블이름(열이름)
AS
(
쿼리문;
)
SELECT 열이름 FROM CTE_테이블 이름;
==========================================================*/
with abc(first_name, salary)
as
(
select first_name, salary
from employees
where department_id = 90
)
select*from abc;

with abc(f, s)
as
(
select first_name, salary
from employees
where department_id = 90
)
select f, s from abc;

/*======================================================================
<재귀적(Recursive)>
WITH recursive CTE_테이블이름(열이름)
AS
(
쿼리문;
)
SELECT 열이름 FROM CTE_테이블 이름;
https://mariadb.com/kb/en/recursive-common-table-expressions-overview/
==========================================================*/
-- 매니저 -> 사원 107 row
with recursive cte (employee_id, manager_id, level, first_name) as(
SELECT employee_id, manager_id, 1, first_name
from employees
WHERE MANAGER_ID is null
UNION all
SELECT e.employee_id, e.manager_id, cte.level + 1, e.first_name  -- steven을 직송상사로 둔 사원의 empoyee_id 를 
from employees e
inner join cte on e.MANAGER_ID = cte.EMPLOYEE_ID
)
SELECT EMPLOYEE_ID, level, concat(repeat(' ',3 * (level - 1)),first_name) As name
from cte
ORDER BY EMPLOYEE_ID;

SELECT EMPLOYEE_ID, MANAGER_ID, FIRST_NAME
FROM employees
where MANAGER_ID is null
UNION all
SELECT e.employee_id, e.manager_id, e.first_name
from employees e;

-- 1. steven를 직속 상사로 두고있는 사람들 
SELECT e.employee_id, e.manager_id, e.first_name
from employees e
inner join employees m on e.manager_id = m. employee_id 
where e.manager_id=100;

-- 사원 -> 매니저 is not null 208 row 
with recursive cte (employee_id, manager_id, level, first_name) as(
SELECT employee_id, manager_id, 1, first_name
from employees
WHERE MANAGER_ID is not null
UNION all
SELECT e.employee_id, e.manager_id, cte.level + 1, e.first_name 
from employees e
inner join cte on e.MANAGER_ID = cte.EMPLOYEE_ID
)
SELECT EMPLOYEE_ID, level, concat(repeat(' ',3 * (level - 1)),first_name) As name
from cte
ORDER BY EMPLOYEE_ID;
