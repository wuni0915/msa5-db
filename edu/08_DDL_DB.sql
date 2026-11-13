-- DDL 데이터 디파이네이션 랭귀지
-- 스키마를 조작하고 저장하는것.
-- DB 생성
CREATE DATABASE test;
-- DB접근/ 선택
USE test;
USE dbsample;
SELECT * FROM employees;
-- DB삭제
DROP DATABASE test;
-- 세션: 접속요청, 요청이 끝남 접속되어있는
-- 상황이 세션이 유지중이다 라고함. 이 라이프사이클을
