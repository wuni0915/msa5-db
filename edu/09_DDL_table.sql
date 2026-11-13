-- CREATE DATABASE test;
-- USE test;
-- 테스트에 접속한 상황
-- 개념적 설계
-- 테이블과 필요한 속성(컬럼)들이 무엇일까?
-- 테이블 어떤걸 만들지 생각해봤다.
-- 물리적 설계: 데이터베이스에 실제로 스키마를
-- 하나씩하나씩 작업해나가는것.
-- 테이블 생성

-- 유저 테이블
-- pk, 이메일, PW, 이름, 생년월일, 전화번호, 성별, 이름, 프로필, 주소, 이메일, pw
-- 테이블 만들기
CREATE TABLE users (
	id					BIGINT		 PRIMARY KEY AUTO_INCREMENT
	,email			varchar(100) NOT NULL
	,`password`		VARCHAR(255) NOT NULL
	,user_name		varchar(30)  NOT NULL
	,birth			DATE 			 NOT NULL
	,phone			CHAR(13)  	 NOT NULL COMMENT '''010-xxxx-xxxx'', 하이픈 포함 13자리'
	,gender			CHAR(1) 		 NOT NULL COMMENT '\'M\', \'F\''
	,addr_number	CHAR(5)
	,addr1 			VARCHAR(50)
	,addr2			VARCHAR(50)
	,`profile`		VARCHAR(100)
	,hired_at		DATE 			 NOT NULL DEFAULT (CURRENT_DATE())
	,withdrawn_at	DATE 			 DEFAULT NULL
	,created_at		DATETIME		 NOT NULL DEFAULT (CURRENT_TIMESTAMP())
	,updated_at 	DATETIME 	 NOT NULL DEFAULT (CURRENT_TIMESTAMP())
	,deleted_at 	DATETIME 	 DEFAULT NULL
	,CONSTRAINT uk_users_email  UNIQUE (email)
	
);
-- 논리명은 설계상에서 개발자가 보기 편한것.
-- 실제 스키마를 구성하지 않음. 논리명빼고 생성해도됨.
-- 물리 구현할때 논리명은 드가지 않음
-- 	now와의 차이. 만약 now를 넣을시 스키마가 만들어질 당시의 시간이 디폴트값임.
-- 	CONSTRAINT 키워드로 이름을 별도로 지정
-- 연산이 들어가는 키워드는 소괄호로 감싸줘야한다.


-- 게시글 테이블
-- pk, 제목, 본문, 이미지, 작성자, 게시글 삭제일, 작성일, 수정여부, 삭제일
CREATE TABLE posts (
	id BIGINT PRIMARY KEY auto_increment
	,user_id BIGINT NOT NULL
	,title VARCHAR(30) NOT NULL
	,content VARCHAR(500)
	,image VARCHAR(100) null
	,deactived_at date default NULL
	,created_at DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP())
	,updated_at DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP())
	,deleted_at DATETIME	DEFAULT NULL
);
-- fk 테이블을 만들때 넣지 않음/ 기본테이블 다 만들고 스키마 수정하는 문법으로 추가한다.
-- 컬럼의 추가
ALTER TABLE users
ADD COLUMN birth_month CHAR(2) NOT NULL COMMENT '\'MM\'양식'
DEFAULT (LPAD(MONTH(users.birth), 2, '0')) AFTER birth
;

ALTER TABLE users
ADD COLUMN birth_month CHAR(2) NOT NULL COMMENT '\'MM\'양식';
-- 컬럼의 순서성 없음.
-- 컬럼 수정
ALTER TABLE users
MODIFY COLUMN birth_month CHAR(2) COMMENT '\'MM\'양식';
-- 컬럼 삭제
ALTER TABLE users
DROP COLUMN birth_month;
-- 스키마 삭제시 데이터 되돌릴 방법 없음
-- 테이블 수정
-- posts 테이블에 fk제약조건 추가
ALTER TABLE posts
ADD CONSTRAINT fk_posts_user_id
FOREIGN KEY (user_id) REFERENCES users(id);

-- 제약조건(constraint) 제거 (수정작업임)
ALTER TABLE posts
DROP CONSTRAINT fk_posts_user_id;



-- SELECT
-- *
-- FROM employees
-- WHERE
-- -- 	SUBSTR(CAST(birth AS char(10)), 6, 2) = MONTH(NOW())
-- 	MONTH(birth) = MONTH(NOW())
-- ;

-- AUTO_INCREMENT 값 변경
ALTER TABLE users AUTO_INCREMENT = 1;

-- TRUNCATE 문: 테이블의 모든 데이터를 깨끗하게 제거하는 문법
-- 복구방법이 아예 없다. 실행하면 대형사고
TRUNCATE TABLE users;
-- 왜 있냐? 보관기간 넘은것, 데이터 유지 필요 없는 기간에 씀.

-- 테이블 삭제
DROP TABLE posts, users;