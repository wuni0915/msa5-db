-- DELETE 문
-- DML 중 하나로 저장되어있는
-- 기존 데이터를 삭제 하기 위해 사용하는 쿼리
-- !!엄청 조심해야댐~~~!!
-- DELETE FROM 테이블명
-- [where 조건]; 이 조건에 맞는 레코드들을 삭제할것
DELETE FROM title_emps
WHERE
-- 프롬 적고 웨얼 안적고 실행하면 그 테이블 싹다~!
	start_at >= '2026-11-09'
;


