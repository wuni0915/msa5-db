-- 1. 직급테이블의 모든 정보를 조회해주세요.
SELECT
	*
FROM titles
;


-- 2. 현재 급여가 60,000,000 이하인 사원의 사번을 조회해 주세요.
SELECT
	emp_id
FROM salaries sal
WHERE
	end_at IS NULL
	and salary <= 60000000
;

-- 3. 현재 급여가 60,000,000에서 70,000,000인 사원의 사번을 조회해 주세요.
SELECT
	emp_id, salary
FROM salaries sal
WHERE
	end_at IS NULL
	and
	salary BETWEEN 60000000 AND 70000000
;

-- 4. 사원번호가 10001, 10005인 사원의 사원테이블의 모든 정보를 조회해 주세요.
SELECT
	*
FROM employees emp
WHERE
	emp_id IN (10001, 10005)
;

-- 5. 직급에 '사'가 포함된 직급코드와 직급명을 조회해 주세요.
SELECT
	title_code
	, title
FROM titles
WHERE
	title LIKE '%사%'
;

-- 6. 사원(퇴사자 포함) 이름 오름차순으로 정렬해서 조회해 주세요.
SELECT
	emp.`name`
FROM employees emp
ORDER BY `name`
;

-- 7. 사원(퇴사자 포함)별 전체 급여의 평균을 조회해 주세요.
SELECT
	emp_id
	, AVG(salary)
FROM salaries sal
GROUP BY emp_id
;
-- 그룹바이절은 사용한 컬럼과 집계 함수만 셀렉트입력가능
	
-- 8. 사원(퇴사자 포함)별전체 급여의 평균이 30,000,000 ~ 50,000,000인,
--   사원번호와 평균급여를 조회해 주세요.
SELECT
	emp_id
	, AVG(salary)
FROM salaries sal

GROUP BY
	emp_id
HAVING
	AVG(salary) <= 50000000
	AND AVG(salary) >= 30000000
;
-- 9. 사원(재직중)별 전체 급여 평균이 70,000,000이상인,
--   사원의 사번, 이름, 성별을 조회해 주세요.
SELECT
	emp_id
	, `name`
	,gender
FROM
	employees emp
WHERE
	emp_id IN (
		SELECT
			sal.emp_id
		FROM salaries sal
		GROUP BY sal.emp_id
		HAVING AVG(salary) >= 70000000
		)
	AND fire_at IS NULL
;


-- 10. 현재 직급이 'T005'인,
--   사원(재직중)의 사원번호와 이름을 조회해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
FROM employees emp
WHERE
	emp_id IN (
		select
		te.emp_id
		FROM title_emps te
		where
		te.title_code = 'T005'
	)
	AND fire_at IS NULL 
;

	(select
	title_code
	FROM title_emps
	where
	title_code = 'T005')