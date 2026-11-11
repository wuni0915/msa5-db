-- 모두 재직중
-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
	, tie.title_code
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
-- 		AND tie.end_at IS NULL
WHERE emp.fire_at IS NULL
;
-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	, gender
	, sal.salary
FROM employees emp
	LEFT JOIN salaries sal
	ON emp.emp_id = sal.emp_id
	AND sal.start_at >= '2025-01-01'
WHERE
	fire_at IS NULL
;
-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT
	emp.`name`
	, sal.salary
	, sal.start_at
FROM employees emp
	LEFT JOIN salaries sal
	ON emp.emp_id = sal.emp_id
WHERE
	emp.emp_id = 10010
	and fire_at IS NULL
;
-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,depr.dept_name
FROM employees emp
	JOIN department_emps depe
	ON emp.emp_id = depe.emp_id
	AND depe.end_at IS null
	LEFT JOIN  departments depr
	ON depe.dept_code = depr.dept_code
	AND depr.end_at IS null
WHERE
emp.fire_at IS NULL
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT
	emp.`name`
	, emp.emp_id
	, sal.salary
FROM employees emp
LEFT JOIN salaries sal
	ON sal.emp_id = emp.emp_id
	AND sal.start_at = '2025-01-01'
WHERE
	emp.fire_at IS NULL
	
ORDER BY salary DESC
-- LIMIT 10
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
	emp.`name`
	, emp.hire_at
	, depm.dept_mgr_id
	, dep.dept_name
FROM employees emp
	JOIN department_managers depm
	ON depm.emp_id = emp.emp_id
	AND depm.end_at IS null
	LEFT JOIN departments dep
	on depm.dept_code = dep.dept_code
WHERE
	emp.fire_at IS NULL
;
-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
SELECT
	title
	, AVG(sal.salary) 
FROM titles tit
	JOIN title_emps tie
	ON tie.title_code = tit.title_code
	LEFT JOIN salaries sal
	ON sal.emp_id = tie.emp_id
WHERE
	title = '부장'
	AND tie.end_at IS null
GROUP BY sal.emp_id
;
-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균


-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
-- 한번이라도 했던 사람
SELECT
	emp.`name`
	, 	emp.hire_at
	, emp.emp_id
	, depm.dept_code
FROM employees emp
	JOIN department_managers depm
	ON depm.emp_id = emp.emp_id
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인
-- 직급의 직급명, 평균연봉(정수)를을
-- 평균연봉 내림차순으로 출력해 주세요.
SELECT
	title
	, ceil(AVG(sal.salary))
FROM titles tit
	JOIN title_emps tie
	ON tit.title_code = tie.title_code
	LEFT JOIN employees emp
	ON emp.emp_id = tie.emp_id
	LEFT JOIN salaries sal
	ON sal.emp_id = emp.emp_id
GROUP BY title
HAVING AVG(sal.salary) >= 60000000
;

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT
	tite.title_code
	, COUNT(tite.emp_id) AS cnt
FROM employees emp
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id
		AND tite.end_at IS NULL
WHERE emp.fire_at IS NULL
	AND emp.gender = 'F'
GROUP BY tite.title_code
ORDER BY tite.title_code
;

-- ------------------------------
-- 전체 평균 급여보다 높은 급여를 받은 기록을 조회



-- 가장 높은 급여를 받은 이력이있는 사원의 사번과 급여를 조회