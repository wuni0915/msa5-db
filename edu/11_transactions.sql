-- transaction
START TRANSACTION;
-- 커밋이나 롤백을 하기 전까지 무조건 트랜잭션이 되는중

INSERT INTO employees(
	`name`
	,birth
	,gender
	,hire_at
)
VALUES(
	'미어캣'
	,'1990-02-23'
	,'M'
	,NOW()
);

COMMIT;
ROLLBACK;