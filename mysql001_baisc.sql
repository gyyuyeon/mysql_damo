/*
VARCHAR, TEXT타입의 데이터 대소문자 구분을 안한다.
대소문자를 구분하려면 VARBINARY 데이터 타입을 사용해야한다.
*/







-- SELECT 입력순서  //한 라인 주석처리할때 하이픈 두번 그리고 한칸 띄기 // 여러줄은 /* 내용 */
/*  기본 명령어들은 대문자로 작성 // 문자열은 홑따움표로 표기
SELECT column_name, column_name, column_name // MYsql에서는 SELECT만 써도 되지만 ORACLE에서는 FROM까지 넣어야 작동
FROM table_name
WHERE column_name='value'
GROUP BY column_name
HAVING column_name='value'
ORDER BY column_name ASC(DESC);
*/

-- SELECT 해석순서 //위에서 부터 우선순위
/*
FROM table_name
WHERE column_name='value'
GROUP BY column_name
HAVING column_name='value'
SELECT column_name, column_name, column_name
ORDER BY column_name ASC(DESC);
*/


-- employee 테이블에서 salary가 3000미만일때
-- first_name, salary 출력해라.

SELECT first_name, salary
FROM employees
WHERE salary <3000; -- WHERE 에서는 비교 또는 논리 연산자 사용 (결과가 논리값으로 나와야함)

-- employee 테이블에서 first_name 컬럼의 값이 'David'일때
-- first_name, salary 출력해라.
SELECT first_name, salary
FROM employees
WHERE first_name = 'David'; -- where에서 = 는 대입이 아니라 같다 // 대소문자 구별 필수 // 홑따움표로 표현

-- employee 테이블에서 first_name 컬럼의 값이 'David'가 아닐때
-- first_name, salary 출력해라.
SELECT first_name, salary
FROM employees
WHERE first_name != 'David';

-- employee 테이블에서 first_name 컬럼의 값이 'David'가 아닐때
-- first_name, salary 출력해라.
SELECT first_name, salary
FROM employees
WHERE first_name <> 'David'; -- <> == !=  같은 표현

-- &&(AND), ||(OR)
-- employee 테이블에서 salary가 3000,9000,17000 일때
-- first_name, salary 출력해라.
SELECT first_name, hire_date ,salary
FROM employees
WHERE SALARY=3000 or SALARY=9000 or SALARY=17000; 

-- in 연산자는 같은 컬럼안에서 해당 값
SELECT first_name, hire_date ,salary
FROM employees
WHERE salary in(3000,9000,17000);

-- employee 테이블에서 salary가 3000이상 5000이하일때
-- first_name, hire_data, salary 출력해라.
SELECT first_name, hire_date ,salary
FROM employees
WHERE salary >= 3000 AND salary <= 5000;

SELECT first_name, hire_date ,salary
FROM employees
WHERE salary BETWEEN 3000 AND 5000;

-- employees 테이블에서 job_id가 'IT_PROG'가 아닐때
-- first_name, hire_data, salary 출력해라.

SELECT first_name, hire_date, salary, job_id
FROM employees
WHERE job_id != 'IT_PROG';

SELECT first_name, hire_date, salary, job_id
FROM employees
WHERE job_id <> 'IT_PROG';

SELECT first_name, hire_date, salary, job_id
FROM employees
WHERE NOT(job_id = 'IT_PROG');

-- employee 테이블에서 salary가 3000,9000,17000 아닐때
-- first_name, salary 출력해라.
SELECT first_name, hire_date ,salary
FROM employees
WHERE NOT(SALARY=3000 or SALARY=9000 or SALARY=17000); 

-- in 연산자는 같은 컬럼안에서 해당 값
SELECT first_name, hire_date ,salary
FROM employees
WHERE salary NOT IN(3000,9000,17000);

-- employee 테이블에서 salary가 3000이상 5000이하가 아닐때
-- first_name, hire_data, salary 출력해라.
SELECT first_name, hire_date ,salary
FROM employees
WHERE NOT(salary >= 3000 AND salary <= 5000);

SELECT first_name, hire_date ,salary
FROM employees
WHERE salary NOT BETWEEN 3000 AND 5000;

-- employyes테이블에서 commission_pct의 값이 null일때
-- first_name, salary, commission_pct값을 출력하라.
SELECT first_name, salary, commission_pct
FROM employees
-- null을 가지고 비교할때는 = 쓰지말고 is null로 해야 데이터를 가지고 옴
WHERE commission_pct is null;  


-- employyes테이블에서 commission_pct의 값이 null이 아닐때
-- first_name, salary, commission_pct값을 출력하라.
SELECT first_name, salary, commission_pct
FROM employees
-- null을 가지고 비교할때는 != 쓰지말고 is not null로 해야 데이터를 가지고 옴
WHERE commission_pct is not null;  

-- employees테이블에서 first_name에 'dre'가 포함될때
-- firtst_name, salary, email을 출력
SELECT first_name, salary, email
FROM employees
WHERE first_name LIKE'%der%';
-- '%문자%' 문자가 포함이 된 // '%문자' 문자로 시작이 되는

-- employees 테이블에서 first_name의 값 중 'A'로 시작하고
-- 두번째 문자는 임의문자이며 'exander'로 끝날때
-- firtst_name, salary, email을 출력
SELECT first_name, salary, email
FROM employees
-- 임의의 문자(wild card)사용시에는 해당 문자의 자리에 _(언더바)사용
WHERE first_name LIKE 'A_exander';

/*
 WHERE절에서 사용된 연산자 3가지 종류
 1 비교연산자 : = > >= < <= != <> 
 2 SQL연산자 : BETWEEN a AND b,  IN, LIKE, IS NULL
 3 논리연산자 : AND, OR, NOT
 
 우선순위
 1 괄호()
 2 NOT연산자
 3 비교연산자, SQL연산자
 4 AND
 5 OR
  */

-- employees 테이블에서 job_id를 오름차순으로
-- first_name, email, job_id를 출력하시오.
SELECT first_name, email, job_id
FROM employees
ORDER BY job_id ASC;
  
SELECT first_name, email, job_id
FROM employees
ORDER BY job_id;
  
-- employees테이블에서 가장 최근 입사 순으로 정렬
-- first_name, salary, hire_date

SELECT first_name, email, hire_date
FROM employees
ORDER BY hire_date DESC;


-- employees테이블에서 업무(job_id)이 'FI_ACCOUNT'인 사원들의 
-- 급여(salary)가 높은순으로 first_name, job_id, salary을 출력하시오.
-- 높은순으로 > DESC 
SELECT first_name, job_id, salary
FROM employees
WHERE job_id = 'FI_ACCOUNT' ORDER BY salary DESC;