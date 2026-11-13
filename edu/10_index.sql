-- index
-- index 확인
SHOW INDEX FROM employees;

SELECT * FROM employees WHERE `name` = '이미경';

-- index 생성
ALTER TABLE employees
ADD INDEX idx_employees_name (`name`);

-- index 제거
ALTER TABLE employees
DROP INDEX idx_employees_name (`name`);

