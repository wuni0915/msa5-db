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



