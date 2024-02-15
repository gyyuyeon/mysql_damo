/*-----------------------------------------------------------
       문제
 -------------------------------------------------------------*/
-- 1) department_id가 60인 부서의 도시명을 알아내는 SELECT문장을 기술하시오

select city
from locations
where location_id = (select location_id
					from departments
                    where department_id = 60);

-- 따로 따로 
select department_id, location_id
from departments;

select city
from locations
where location_id = 1400;
    
-- 2)사번이 107인 사원과 부서가같고,167번의 급여보다 많은 사원들의 사번,이름(first_name),급여를 출력하시오.
 
 select employee_id, first_name, salary, department_id
 from employees
 where department_id = (select department_id
								from employees
                                where employee_id = 107 ) and
 salary > (select salary
								from employees
                                where employee_id = 167 ); 
                                
-- 따로따로
select employee_id, first_name, salary
 from employees
 where department_id = (select department_id
								from employees
                                where employee_id = 107 );
 
 select employee_id, first_name, salary
 from employees
 where salary = (select salary
								from employees
                                where employee_id = 167 );
              
-- 3) 급여평균보다 급여를 적게받는 사원들중 커미션을 받는 사원들의 사번,이름(first_name),급여,커미션 퍼센트를 출력하시오.
 
-- exists
select employee_id, first_name, salary, commission_pct
from employees e
where salary < (select avg(salary)
				from employees) and exists (select 1
											from employees m
											where e.commission_pct = m.commission_pct);

-- is not null                
 select employee_id, first_name, salary, commission_pct
from employees e
where salary < (select avg(salary)
				from employees) and commission_pct is not null
                order by salary desc;
                
                
-- 4)각 부서의 최소급여가 20번 부서의 최소급여보다 많은 부서의 번호와 그부서의 최소급여를 출력하시오.

select department_id, min(salary)
from employees

where salary > any (select salary
					from employees
                    where department_id = 20)
GROUP BY department_id;

-- teacher
select department_id, min(salary)
from employees
GROUP BY department_id
order by min(salary) asc; -- 20 6000

select department_id, min(salary)
from employees
GROUP BY department_id
having min(salary) > (select min(salary)
					from employees
                    where department_id = 20)
order by min(salary) asc;

-- 5) 사원번호가 177인 사원과 담당 업무가 같은 사원의 사원이름(first_name)과 담당업무(job_id)하시오.   

select first_name, job_id
from employees
where job_id = (select job_id
				from employees
                where employee_id = 177);
                
-- 6) 최소 급여를 받는 사원의 이름(first_name), 담당 업무(job_id) 및 급여(salary)를 표시하시오(그룹함수 사용).

select first_name, job_id, salary
from employees
where salary = (select min(salary)
				from employees);
                
                
			
-- 7) 각 부서의 최소 급여를 받는 사원의 이름(first_name), 급여(salary), 부서번호(department_id)를 표시하시오.
 
 -- 잘못품
select first_name, salary, department_id
from employees
where salary = (select min(salary)
				from employees);

-- teacher
select department_id, min(salary)
from employees
GROUP BY department_id;

select first_name, salary, department_id
from employees
where (department_id, salary) in (select department_id, min(salary)
								from employees
								group by department_id);
                

-- 8)담당 업무가 프로그래머(IT_PROG)인 모든 사원보다 급여가 적으면서 
-- 업무가 프로그래머(IT_PROG)가 아닌  사원들의 사원번호(employee_id), 이름(first_name), 
-- 담당 업무(job_id), 급여(salary))를 출력하시오.

select employee_id, first_name, job_id, salary
from employees
where salary < any (select salary
					from employees
                    where job_id = 'IT_PROG') and job_id != 'IT_PROG';
                    
select salary
from employees
where job_id = 'IT_PROG'
order by salary asc;

select employee_id, first_name, job_id, salary
from employees
where salary < ALL (select salary
from employees
where job_id = 'IT_PROG');


               

-- 9)부하직원이 없는 모든 사원의 이름을 표시하시오.
select first_name
from employees e
where NOT exists (select 1
              from employees m
              where m.MANAGER_ID=e.EMPLOYEE_ID);

SELECT first_name, employee_id, manager_id
FROM employees e
WHERE NOT EXISTS (SELECT 1
              FROM employees m
              WHERE m.employee_id = e.manager_id);
