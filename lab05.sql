
-- 실습 1)
INSERT INTO customer (userid, name, birthyear, regdate, address) 
VALUES ('C001', '김수현', 1988, sysdate, '경기');
INSERT INTO customer (userid, name, birthyear, regdate, address) 
VALUES ('C002', '이효리', 1979, sysdate, '제주');
INSERT INTO customer (userid, name, birthyear, regdate, address) 
VALUES ('C003', '원빈', 1977, sysdate, '강원');

/*
C001	김수현	1988	18/07/02	경기	
C002	이효리	1979	18/07/02	제주	
C003	원빈  	1977	18/07/02	강원	
*/

-- 실습 2)
UPDATE customer c
   SET C.NAME = '차태현'
     , C.birthyear = 1976
     , C.address = '서울'
 WHERE C.userid = 'C001'
;

/*
C001	차태현	1976	18/07/02	서울	
C002	이효리	1979	18/07/02	제주	
C003	원빈	    1977	18/07/02	강원	
*/

-- 실습 3)
UPDATE customer c
   SET C.address = '서울'
;
/* 3개 행 이(가) 업데이트되었습니다.

C001	차태현	1976	18/07/02	서울	
C002	이효리	1979	18/07/02	서울	
C003	원빈	    1977	18/07/02	서울	
*/

-- 실습 4)
DELETE customer c
 WHERE C.userid = 'C003'
;
/* 1 행 이(가) 삭제되었습니다.

C001	차태현	1976	18/07/02	서울	
C002	이효리	1979	18/07/02	서울	
*/

-- 실습 5)
DELETE customer;
-- 2개 행 이(가) 삭제되었습니다.

-- 실습 6)
TRUNCATE TABLE customer;

-- Table CUSTOMER이(가) 잘렸습니다.

