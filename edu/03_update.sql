-- UPDATE 문
-- DML중 하나로 저장되어있는 기존 데이터를
-- 수정하기 위해 사용하는 쿼리
-- UPDATE 테이블명
-- SET
--  컬럼1=값1
-- [, 컬럼2 = 값2...]
-- [WHERE 절] (반드시 넣어야댐)

-- 100005 사원의 이름을 변경하고 싶다
UPDATE employees
SET
	`name` = '미어캣'
	, gender = 'F'
WHERE
	emp_id = 100005
;
-- where절 먼저 적는 습관 들이기


UPDATE employees
SET
	`name` = '마이콜'
	, birth = '2020-01-01'
WHERE
	emp_id = 100005
;









