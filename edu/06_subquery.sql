-- SubQuery

-- WHERE 절에서 사용

-- 단일 행 서브 쿼리(단일 행 비교 연산자)
-- D001 부서장의 사번과 이름을 출력(테이블 두개)
-- 서브쿼리가 단일 행 비교 연산자와 함께 사용할 때는
-- 반드시 서브쿼리의 결과 수가 1건 이하여야 한다.
-- 만약에 2건 이상일 경우 오류 발생
SELECT
	emp.`name`
	,emp.emp_id
FROM employees emp
where
	emp.emp_id = (
	SELECT
		depm.emp_id
	FROM department_managers depm
	WHERE
		dept_code = 'D001'
		AND end_at IS NULL
	)
; 
-- 다중 행 서브쿼리
-- 서브 쿼리의 결과가 2건 이상을 반환할 경우
-- 반드시 다중행 비교 연산자(IN, ALL, ANY, SOME, EXISTS)를 사용해야한다.
-- 현재 부서장인 사원의 사번과 이름을 출력
SELECT
	depm.emp_id
FROM department_managers depm
WHERE
	depm.end_at IS NULL
;

SELECT
emp.emp_id,
	emp.`name`
FROM employees emp
WHERE
	emp.emp_id IN (
	SELECT
	depm.emp_id
FROM department_managers depm
WHERE
	depm.end_at IS NULL
)
;

-- 다중 열 서브쿼리
-- 현재 'D002' 부서장이 해당 부서에 소속 된 날짜를 출력
SELECT
	depe.start_at
	,depe.dept_code
FROM department_emps depe
WHERE
(depe.emp_id, depe.dept_code) IN (
	SELECT
		depm.emp_id
		,depm.dept_code
	FROM department_managers depm
	WHERE
		depm.dept_code = 'D002'
		AND depm.end_at IS NULL
)
-- 	depe.emp_id = 571
-- 	AND depe.dept_code = 'D002'
;

SELECT
	depm.emp_id
	,depm.dept_code
FROM department_managers depm
WHERE
	depm.dept_code = 'D002'
	AND depm.end_at IS NULL
;

-- 연관 서브 쿼리
-- 서브 쿼리 내에서 메인 쿼리의 컬럼이 사용된 서브 쿼리
-- 부서장직을 지냈던 경력이 있는 사원의 정보를 출력
SELECT
	emp.*
FROM employees emp
WHERE
	emp.emp_id IN (
		select
			depm.emp_id
		FROM department_managers depm
		where
			depm.emp_id = emp.emp_id
	)
;
-- select 절에서 사용하는 서브쿼리
-- 사원별 역대 전체 급여 평균
SELECT
	emp.emp_id
	, (
		select
			AVG(sal.salary)
		FROM salaries sal
		WHERE sal.emp_id = emp.emp_id
	) avg_sal
FROM employees emp
;
-- from 절:
SELECT
	tmp.*
FROM (
	SELECT
		emp.emp_id
		,emp.`name`
	FROM employees emp
	WHERE
		fire_at IS not NULL 
) tmp 
;
-- insert문에서 사용 내가 조회한결과를특정컬럼에서 쓰고싶을때
INSERT INTO employees (
	employees.emp_id
	, employees.`name`
	, employees.birth
	, employees.gender
	, employees.hire_at
)
VALUES (
	(SELECT MAX(emp.emp_id) +1 FROM employees emp)
	, '둘리'
	, '1980-01-01'
	, 'M'
	, NOW()
);
-- update문
-- 퇴사한 사원의 직급테이블의 직급 종료일을
-- 퇴사일로 갱신해주세요
UPDATE title_emps
SET
	title_emps.end_at = (
	SELECT employees.fire_at
	FROM employees
	WHERE
		employees.emp_id = 100011)
WHERE
	title_emps.emp_id = 100011
	AND title_emps.end_at IS NULL
;