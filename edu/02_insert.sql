-- INSERT 문
-- DML 중 하나로 신규 데이터를 저장하기 위해 사용하는 쿼리
-- INSERT INTO 테이블명[(컬럼1, 컬럼2...)] (기본 형태)
-- []<- 이걸로 묶어놨다하면 보통 생략이 가능하다(근데 하면 안됨). DB의 특징으로 컬럼 순서성은 없다.
INSERT INTO employees (`name`, birth, gender, hire_at)
-- 어토 인크리먼트 1씩 증가?? 자동으로? 설정해놨다? 그러니까 pk,emp_id 없애도됨
VALUES ('최원희', '2002-02-21', 'F', NOW())
, ('홍길동', '2000-01-01', 'M', NOW())
,('홍갑동', '2000-03-01', 'M', NOW())
,('홍명동', '2000-02-01', 'M', NOW());
-- 현재시간 가져오는 함수
-- 여러개의 코드를 한번에 넣고 싶을떄.
-- 복수의 레코드를 삽입하고싶을경우

-- select insert
-- 조회된 결과를 가지고 삽입(insert)를 실행
INSERT INTO title_emps (
	emp_id
	, title_code
	, start_at
	, end_at
	, created_at
	, updated_at
	, deleted_at
)
SELECT
	emp_id, 'T001', NOW(), NULL, NOW(), NOW(), NULL
FROM employees
WHERE
	emp_id >100000
;