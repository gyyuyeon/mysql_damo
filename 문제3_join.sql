/*----------------------------------------------
 문제
 ----------------------------------------------   */
-- 1) EMPLOYEES 테이블에서 입사한 달(hire_date) 별로 인원수를 조회하시오 . 
--  <출력: 월        직원수   >
 
 select sum(month(hire_date)=1) 1월,
		sum(month(hire_date)=2) 2월,
        sum(month(hire_date)=3) 3월,
        sum(month(hire_date)=4) 4월,
        sum(month(hire_date)=5) 5월,
        sum(month(hire_date)=6) 6월,
        sum(month(hire_date)=7) 7월,
        sum(month(hire_date)=8) 8월,
        sum(month(hire_date)=9) 9월,
        sum(month(hire_date)=10) 10월,
        sum(month(hire_date)=11) 11월,
        sum(month(hire_date)=12) 12월
        
 from employees;

select month(hire_date) as 월,count(*) as 직원수
from employees
group by month(hire_date)
order by month(hire_date);

select date_format(hire_date, '%m') as 월,count(*) as 직원수
from employees
group by date_format(hire_date, '%m') -- group by 때는 이름명 변경 불가 
order by date_format(hire_date, '%m');


-- 2)각 부서에서 근무하는 직원수를 조회하는 SQL 명령어를 작성하시오. 
-- 단, 직원수가 5명 이하인 부서 정보만 출력되어야 하며 부서정보가 없는 직원이 있다면 
-- 부서명에 “<미배치인원>” 이라는 문자가 출력되도록 하시오. 
-- 그리고 출력결과는 직원수가 많은 부서먼저 출력되어야 합니다.
 
 
 
select d.department_name, count(e.employee_id)-- , e.first_name
from departments d inner join employees e
on d.department_id = e.department_id
group by d.department_id
having count(e.employee_id) <= 5;

select ifnull(d.department_name ,'<미배치 인원>') as 부서명 , count(*) as 직원수
from employees e left join departments d
on e.department_id = d.department_id
group by d.department_name
having count(*) <= 5;


select department_name,manager_id,department_id
from departments ;

select first_name,employee_id,MANAGER_ID,department_id
from employees ;

-- 3)각 부서 이름 별로 2005년 이전에 입사한 직원들의 인원수를 조회하시오.
-- <출력 :    부서명		입사년도	인원수  >

select d.department_name 부서명, year(e.hire_date) 입사연도, count(*) 인원수
from departments d inner join employees e 
on d.department_id = e.department_id
where year(e.hire_date) <= 2005
group by d.department_name, year(e.hire_date);

 
 
-- 4)직책(job_title)에서 'Manager'가 포함이된 사원의 이름(first_name), 직책(job_title),
--  부서명(department_name)을 조회하시오.
 select e.first_name, j.job_title, d.department_name
 from employees e inner join jobs j on e.job_id=j.job_id
				  inner join departments d on e.department_id = d.department_id
where j.job_title like '%Manager%';
  
-- 5)'Executive' 부서에 속에 있는 직원들의 관리자 이름을 조회하시오. 
-- 단, 관리자가 없는 직원이 있다면 그 직원 정보도 출력결과에 포함시켜야 합니다.
-- <출력 : 부서번호 직원명  관리자명  >

select e.department_id 부서번호 , e.first_name 직원명, m.first_name 관리자명
from employees e left join employees m on e.manager_id = m.employee_id
				 inner join departments d on e.department_id =  d.department_id
	where d.department_name like '%Executive%';


