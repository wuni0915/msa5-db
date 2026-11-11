-- JOIN문
-- 복수의 테이블을 묶어서 하나의 결과 집합으로 출력하는것

-- INNER JOIN
-- 복수의 테이블이 공통적으로 만족하는 레코드를 출력
-- WHERE절은 메인쿼리의 필터링을 위한 조건
-- 해빙절 그룹절을 사용할때 집계치로 거르는 조건
-- 이너 조인 어떻게 연결해서 어떤 조건으로 가져올지

-- 전 사원의 사번, 이름, 현재 급여를 출력해주세요.
SELECT
	emp.emp_id
	, emp. `name`
	, sal.salary
FROM employees emp
	JOIN  salaries sal
-- 	 레코드가 같은 애들끼리 잇는다.
		ON emp.emp_id = sal.emp_id
		AND sal.end_at IS NULL
;
-- FK가 안되어있어서 데이터의 무결성이 우리때문에
-- 헤쳐질가능성이 있음.
-- 재직중인 사원의 사번, 이름, 생일, 부서명

SELECT
	emp.emp_id
	, emp.`name`
	, emp.birth
	, dep.dept_name
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
			AND emp.fire_at IS NULL
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
			AND depe.end_at IS NULL
;
-- LEfT JOIN
-- 재직중인 전 사원 정보를 출력하는데,
-- 현재 부서장인 사원이면 부서장 정보도 같이 출력해주세요.
SELECT
	emp.emp_id
	, emp. `name`
	, depm.dept_code
FROM employees emp
	LEFT JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
			AND emp.fire_at IS NULL 
			AND depm.end_at IS NULL 
ORDER BY depm.dept_code desc
;

SELECT * FROM department_managers
WHERE end_at IS NULL;
-- 문제 발생 가능성/ 코드 말고 부서명을 보고싶을때
-- 
SELECT
	emp.emp_id
	, emp. `name`
	, depm.dept_code
FROM employees emp
	LEFT JOIN (
	select
		
	department_managers depm
		ON emp.emp_id = depm.emp_id
			AND emp.fire_at IS NULL 
			AND depm.end_at IS NULL 
		JOIN departments dep
			ON dep.dept_code = depm.dept_code
			)
ORDER BY depm.dept_code desc
;

SELECT
	emp.emp_id
	, emp.`name`
	, tmp_manager.dept_code
	, tmp_manager.dept_name
FROM employees emp
	LEFT JOIN (
		select
			depm.emp_id
			, dep.dept_code
			, dep.dept_name
		FROM departments dep
			JOIN department_managers depm
				ON dep.dept_code = depm.dept_code
					AND depm.end_at IS NULL 
	) tmp_manager
		ON emp.emp_id = tmp_manager.emp_id
			AND emp.fire_at IS NULL
ORDER BY tmp_manager.dept_code DESC
;
SELECT
	emp.emp_id
	, emp.`name`
	, depm.dept_code
	, dep.dept_name
FROM employees emp
	LEFT JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
				AND emp.fire_at IS NULL 
				AND depm.end_at IS NULL 
	LEFT JOIN departments dep
		ON dep.dept_code = depm.dept_code
ORDER BY depm.dept_code IS NULL, depm.dept_code
;
-- union
-- 두개 이상의 쿼리의 결과를 합쳐서 출력
-- nuion: 중복 레코드를 제거
-- union all: 중복 레코드를 제거하지 않음.
SELECT *, '1' FROM employees
WHERE emp_id IN (1,3)
UNION
SELECT *, '2' FROM employees
WHERE emp_id IN (1,5)
;
-- 값이 단 한컬럼이라도 다르면 다른것 취급이다
-- SELF JOIN: 같은 테이블끼리 조인
-- 현재 슈퍼바이저인 사원 정보 출력
SELECT distinct
	emp.emp_id junior_emp_id
	, emp.`name` junior_name
	, sup.emp_id sup_id
	, sup.`name` sup_name
FROM employees emp
	JOIN employees sup
		ON emp.sup_id = sup.emp_id
			AND emp.sup_id IS NOT NULL
;
-- 사수를 가진 사원과 해당 사원의 사수 정보.
-- 슈퍼 바이저 정보가 겹칠 때
-- distinct를 쓰면 중복 없어져서 나옴 