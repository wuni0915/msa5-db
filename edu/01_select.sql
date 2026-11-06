-- SELECT 문
-- DML 중 하나로, 저장되어 있는 데이터를
-- 조회 하기 위해 사용하는 쿼리

-- 조회 하는 데이터 중에 특정 컬럼만 출력
-- 데이터 베이스는 보통 컬럼과 레코드(열)로 이루어짐.

-- SELECT 절: 조회한 데이터 중 특정 컬럼만 출력
SELECT
	emp_id
	, `NAME`
-- name은 예약어, 더 안전하게 하려면 빽틱으로 감싸준다
-- 빽틱으로 감싸주면 예약어가 아니라 컬럼명으로 인식(구버전에서는)
-- emp_ 는 예약어가 아님 빽틱=컬럼 인식
	, gender
FROM employees
;
-- 프롬절: 테이블 지정
-- 내가 아이디와 네임을 가져오고 싶은데 임플로이 테이블에서 가져오겠다라는 뜻
-- 실ㅇ행 방법: 실행, 선택 실행, 현재 쿼리 실행
SELECT
	emp_id
FROM employees
;
-- 현재 쿼리 실행은 커서를 기준으로 내 이후에 있는 세미콜론까지 있는 쿼리를 실행 하는것
-- Asterrisk(*) : 모든 컬럼 조회
SELECT
	*
	FROM employees
;

--  WHERE 절: 특정 컬럼의 값이 조건에 맞는 데이터만 조회(필터링)
-- 사번이 10009번인 사원의 모든 정보를 조회해 주세요.
SELECT
	*
FROM employees
WHERE
	emp_id = 10009
-- emp_id 데이터타입=빅인트임. 정수형.
-- 대입연산자가 아닌 여기서는 같다라는 의미이다. ==
	;

-- 사원명이 박보람인 사원의 정보를 조회해 주세요

SELECT
	*
FROM employees
WHERE
	`NAME` = "박보람"
	;
	
-- 생일이 2000-01-01 이후인 사원 모두 찾아주세요
SELECT
	*
FROM employees
WHERE
	birth >= '2000-01-01'
	;
	
-- 퇴사하지 않은 사원 정보 다 주세요. fire date null 재직중, 날짜있으면 퇴사
SELECT
	*
FROM employees
WHERE
	fire_at IS not NULL
;

	
SELECT
	*
FROM employees
WHERE
	fire_at IS NULL
;
-- 1990년생인 사원을 조회해 주세요.
SELECT
	*
FROM employees
WHERE
	birth >= '1990-01-01'
	AND birth <= '1990-12-31'
;

-- 이름이 김철수 또는 정유리인 사원을 조회해주세요.

SELECT
	*
FROM employees
WHERE
	`name` = '박보람'
	OR `name` = '정유리'
;
-- 1990년생 이거나, 이름이 '정유리'인 사원을 조회해주세요.
SELECT
	*
FROM employees
WHERE
	birth >= '1990-01-01'
	AND birth <= '1990-12-31'
	OR `name` = '정유리'
;
-- and or 같이 할때 주의점: and는 연산이 한묶음이다.
-- and와 or가 섞일때 이상한 데이터가 섞인다. 정유리 1970년생등이 섞일수있음
-- 1990년생 이후면서, 이름이 정유리 또는 박보람인사원.
SELECT
	*
FROM employees
WHERE
	birth >= '1990-01-01'
	AND
	(`name` = '박보람'
	OR `name` = '정유리'
	)
;

-- BETWEEN 연산자: 지정한 범위 내의 데이터를 조회
SELECT
	*
FROM employees
WHERE
-- 	birth >= '1990-01-01'
-- 	AND birth <= '1990-12-31'
birth BETWEEN '1990-01-01' AND '1990-12-31'
;

-- IN 연산자: 다수의 지정한 값과 일치하는 데이터를 조회
-- or로 연결된것들을 IN연산자로 대체 가능
SELECT
	*
FROM employees
WHERE
-- 	`name` = '박보람'
-- 	OR `name` = '정유리'
`name` IN('박보람', '정유리')
;
-- 사번이 10001, 10005, 10006인 사원의 모든 정보 조회

SELECT
	*
FROM employees
WHERE
	emp_id IN(10001,10005,10006)
;
-- 선생님 시험이 이런유형임
-- LIKE 절: 문자열의 내용을 조회/기본적으로 속도 느림
-- %: 글자수와 상관없이 조회할 경우 사용
-- 이름이 '우'로 끝나는 사원 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE '우%우'
;
-- %우앞에 몇글자가 오든 마지막이 우인 글자는 다 추출함
-- %우% = 우 포함 사원 모두. 우%=우로 시작 사원 조회.
-- (_):언더바의 개수만큼 글자수를 허용해서 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE '_우_'
-- `name` LIKE '____' 4글자 나오넹 신기하다
;
-- order by 절: 조회한 데이터를 정렬, 원랜 레코드들이 뒤섞임어디서든 무조건 넣음
SELECT
	*
FROM employees
-- ORDER BY `name` ASC
-- ORDER BY `name` DESC
ORDER BY `name` , birth
-- ASC- 오름차순 영어 약어 어샌딩 DESC 내림차순, 생략하면 디폴트 ASC
-- 강가람 내부에서 벌쓰가 오름차순으로 정렬 강강은에서 다시 오름차순
-- 정렬시 null이 제일 최상위
;
-- 쿼리 작성 순서 기본틀
-- SELECT [DISTINCT] [컬럼명]
-- FROM [테이블명]


-- LIMIT 키워드, OFFSET 키워드: 출력의 개수를 제한
SELECT
	*
FROM employees
-- LIMIT 5 OFFSET 5
LIMIT 10, 5
-- 5개로 자르는데 오프셋이 5라는거는 5부터 시작이라는 말
-- 5번커서 위치에서 리미트 5개를 잘라오겠다.
;
-- 집계 함수
-- sum(컬럼) : 조회 된 해당 컬럼의 모든 값의 합계를 반환하는 함수
-- 전사원의 현재 급여 합계를 조회 해 주세요
SELECT
	SUM(salary) sum_sal
-- 응용하기 용이하도록 별칭을 붙인다...머지?
-- 테이블 명은 관습적으로 복수형
FROM salaries
WHERE
	end_at IS NULL
;
-- max(컬럼)
SELECT
	max(salary) max_sal
FROM salaries
WHERE
	end_at IS NULL
;
-- min(컬럼)
SELECT
	min(salary) min_sal

FROM salaries
WHERE
	end_at IS NULL
;
-- avg(컬럼)
SELECT
	avg(salary) avg_sal,
	min(salary) min_sal

FROM salaries
WHERE
	end_at IS NULL
;
-- count(컬럼)
-- 현재 재직중인 사원수를 구해주세요.
SELECT
	COUNT(`name`),
	COUNT(*)
-- 	애스터리스크는 널도 포함해서 세아림. 네임은 널 빼고ㅇㅇ
-- pk는 널을 포함하지 않음
FROM employees
WHERE
	fire_at IS NULL
;
-- 컬럼말고 값이라고도 함 값에 컬럼이 드가는것.
-- distinct 키워드:검색결과에서 중복된 레코드 없이 출력
SELECT DISTINCT
	`name`
FROM employees
ORDER BY `name`
;

SELECT DISTINCT
	*
FROM employees
WHERE
	`name`
;

-- GROUP BY 절, HAVING절
-- 그룹으로 묶어서 조회

-- 부서별 사원수?
SELECT
-- select 절에 작성하는 컬럼은
-- 그룹 바이절에서 사용한 컬럼과
-- 집계 함수만 작성 가능(sql표준 문법)
	dept_code
	,COUNT(*) cnt_emps
FROM department_emps
WHERE
	end_at IS null
GROUP BY dept_code
;

-- 직급별 사원 수가 10000명 이상인 직급을 조회해해주세요.
SELECT
	title_code,
	COUNT(*) cnt
FROM title_emps
where
	end_at IS NULL
GROUP BY title_code
	HAVING cnt >=10000
;
-- where 데이터 필터링 조건임/ having은 그룹에 조건을 줄때임