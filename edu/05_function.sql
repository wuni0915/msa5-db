-- 내장 함수 (Function)

-- ---------------------------------
-- 데이터 타입 변환 함수
-- ---------------------------------
SELECT
	CAST(1234 AS CHAR(6))
	, CONVERT(1234, CHAR(6))
;
-- 앞에 있는 값을 뒤에 있는값으로 바꿀때

-- 100005번 회원의 아이디를 문자열로 바꾸고싶다
SELECT CONVERT
	(emp_id, VARCHAR(20))
-- 	빅인트를 바케어로 바꾸는건 불가능
FROM employees
WHERE emp_id = 100005
;

-- -------------------------
-- 제어 흐름 함수(if 같은거)
-- -------------------------
-- if(수식, 참일 경우의 값, 거짓일 경우의 값)
SELECT
	`name`
	, gender
	, if(gender = 'M', '남자', '여자') ko_gender
-- 알리아스?
FROM employees
;

-- IFNULL(수식1, 수식2)
-- 수식1이 null이면 수식2를 반환, 아니면 수식 1을 반환
SELECT
	IFNULL(fire_at, '재직중') , fire_at
FROM employees
;
-- NULLIF(수식1, 수식2)
-- 수식1과 수식2를 비교해서 같으면 NULL을 반환
-- 다르면 수식2를 반환
SELECT
	NULLIF(gender, 'M')
FROM employees
;
-- case ~ when ~ else ~ end
SELECT
	case gender
		when 'M' then '남자'
		when 'F' then '여자'
		ELSE '기타'
	end
	
	genderValue, gender
FROM employees
;
-- 	젠더의 값을 케이스로 분리?한다
-- 문자열 함수: 리턴되는 DT가 문자열임
-- ------------
-- 문자열 연결
SELECT CONCAT('안녕', '하세요.');
SELECT CONCAT(`name`, ' ', gender) FROM employees;
-- 구분자로 문자열을 연결
SELECT CONCAT_WS(',','자바','js','html');
-- 숫자에 자릴수(,) 및 소수점 자리수 표시-문자열로드감
SELECT FORMAT(salary, 0) FROM salaries;

-- 문자열의 왼쪽/오른쪽부터 길이만큼 잘라 반환
SELECT
	LEFT('123456', 2)
	,right('123456', 2)
;
-- 문자열의 좌/우에 문자열 길이만큼 채울 문자열을 삽입
SELECT
	LPAD('123', 6, '0')
	, RPAD('123', 6, '*')
;

-- 문자열의 좌/우 공백을 제거
SELECT
	'      test'
	, TRIM('      test')
	, LTRIM('      test')
	, RTRIM('      test')
;
-- 문자열을 시작 위치에서 길이만큼 잘라서 반환
SELECT suvstrign ( '12345', 3, 2
)

SELECT suvstrig_index(
'abs.test.123.txt'
,'.'
,2
)txt;

-- 영어 대소문자 변경
SELECT UPPER('asdSADwdasS'), LOWER('asdASDWdasS');

-- 수함함서
-- 올림, 반올림, 버림
SELECT CEIL(3.14), ROUND(3.14), FLOOR(3.14);

-- 절대값ㄱ
SELECT ABS(-1), ABS(1);
-- 앱솔루트 약자

-- 소수점을 기준으로 특정 자리수까지 구하고 나머지는 버리고싶을때
SELECT TRUNCATE(1.19, 0);
-- 현재 날짜 및 시간 반환 (YYYY-MM-DD hh:mi:ss)
SELECT NOW();
-- 연월일만 반환(YYYY-MM-DD)
SELECT DATE(NOW());
SELECT DATE('2026-11-09 16:05:39');
SELECT DATE(created_at) FROM employees;

SELECT ADDDATE(NOW(), INTERVAL 1 YEAR);
SELECT ADDDATE(NOW(), INTERVAL -1 YEAR);
SELECT subDATE(NOW(), INTERVAL 1 YEAR);
SELECT ADDDATE(NOW(), INTERVAL 1 MONTH);
SELECT ADDDATE(NOW(), INTERVAL 1 DAY);
SELECT ADDDATE(NOW(), INTERVAL 1 HOUR);
SELECT ADDDATE(NOW(), INTERVAL 1 MINUTE);
SELECT ADDDATE(NOW(), INTERVAL 1 SECOND);
SELECT ADDDATE(NOW(), INTERVAL 1 MICROSECOND);

-- ------------------------
-- 집계함수 금요일에 했음
-- --------------------

-- -----------------
-- 순차함수
-- ------------------
-- RANK() OVER(ORDER BY 컬럼 ASC/DESC)
-- 지정한 컬럼을 기준으로 순위를 매겨 반환
-- 동일한 값이 있는 경우 동일한 순위를 부여
SELECT
	emp_id
	, salary
	, RANK() OVER(ORDER BY salary DESC) `rank`
FROM salaries
WHERE
	end_at IS NULL
;

UPDATE salaries
SET salary = 196357546
WHERE emp_id = 93611 AND end_at IS NULL
;

SELECT * FROM salaries WHERE emp_id = 93611;

-- ROW_NUMBER() OBER (ORDER BY SALARY DESC)
-- 레코드에 순위를 매겨 반환
-- 동일한 값이 있는 경우에도 각 행에 고유한 번호를 부여
SELECT
	emp_id
	, salary
	, ROW NUMBER() OVER(ORDER BY salary DESC) `rank`
FROM salaries
WHERE
	end_at IS NULL
;

UPDATE salaries
SET salary = 196357546
WHERE emp_id = 93611 AND end_at IS NULL
;

SELECT * FROM salaries WHERE emp_id = 93611;
