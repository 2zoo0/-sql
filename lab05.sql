
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

----- 시퀀스ㅡ

-- 실습 1)
CREATE SEQUENCE seq_cust_userid
MAXVALUE 99
NOCYCLE
;
-- Sequence SEQ_CUST_USERID이(가) 생성되었습니다.

-- 실습 2)
SELECT S.sequence_name
     , S.min_value
     , S.max_value
     , S.increment_by
     , s.CYCLE_FLAG
  FROM user_sequences s
 WHERE S.sequence_name = 'SEQ_CUST_USERID'
;
/*
SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, INCREMENT_BY, CYCLE_FLAG
----------------------------------------------------------------
SEQ_CUST_USERID	1	99	1	N
*/

-- 실습 3)
CREATE INDEX idx_cust_userid
    ON customer (userid);
-- 01408. 00000 -  "such column list already indexed"
-- 실습 1) 에서 userid가 primary key 제약조건을 갖고 생성되어

SELECT a.CONSTRAINT_NAME
     , a.CONSTRAINT_TYPE
     , a.SEARCH_CONDITION
     , a.TABLE_NAME
  FROM ALL_CONSTRAINTS a
 WHERE a.TABLE_NAME = 'CUSTOMER';
 /*
SYS_C007001	C	"NAME" IS NOT NULL	CUSTOMER
SYS_C007002	Primary_Key	            CUSTOMER
 */

-- 자동으로 SYS_C007002 인덱스가 등록됨
-- 실습용이니 그냥 제약조건 없애버리고 하겠습니다.
ALTER TABLE customer
DROP CONSTRAINT SYS_C007002;

CREATE INDEX idx_cust_userid
    ON customer (userid);
--Index IDX_CUST_USERID이(가) 생성되었습니다.

-- 실습 4)
DESC USER_INDEXES;

/*
이름                      널?       유형             
----------------------- -------- -------------- 
INDEX_NAME              NOT NULL VARCHAR2(30)   
INDEX_TYPE                       VARCHAR2(27)   
TABLE_OWNER             NOT NULL VARCHAR2(30)   
TABLE_NAME              NOT NULL VARCHAR2(30)   
TABLE_TYPE                       VARCHAR2(11)   
UNIQUENESS                       VARCHAR2(9)    
COMPRESSION                      VARCHAR2(8)    
PREFIX_LENGTH                    NUMBER         
TABLESPACE_NAME                  VARCHAR2(30)   
INI_TRANS                        NUMBER         
MAX_TRANS                        NUMBER         
INITIAL_EXTENT                   NUMBER         
NEXT_EXTENT                      NUMBER         
MIN_EXTENTS                      NUMBER         
MAX_EXTENTS                      NUMBER         
PCT_INCREASE                     NUMBER         
PCT_THRESHOLD                    NUMBER         
INCLUDE_COLUMN                   NUMBER         
FREELISTS                        NUMBER         
FREELIST_GROUPS                  NUMBER         
PCT_FREE                         NUMBER         
LOGGING                          VARCHAR2(3)    
BLEVEL                           NUMBER         
LEAF_BLOCKS                      NUMBER         
DISTINCT_KEYS                    NUMBER         
AVG_LEAF_BLOCKS_PER_KEY          NUMBER         
AVG_DATA_BLOCKS_PER_KEY          NUMBER         
CLUSTERING_FACTOR                NUMBER         
STATUS                           VARCHAR2(8)    
NUM_ROWS                         NUMBER         
SAMPLE_SIZE                      NUMBER         
LAST_ANALYZED                    DATE           
DEGREE                           VARCHAR2(40)   
INSTANCES                        VARCHAR2(40)   
PARTITIONED                      VARCHAR2(3)    
TEMPORARY                        VARCHAR2(1)    
GENERATED                        VARCHAR2(1)    
SECONDARY                        VARCHAR2(1)    
BUFFER_POOL                      VARCHAR2(7)    
FLASH_CACHE                      VARCHAR2(7)    
CELL_FLASH_CACHE                 VARCHAR2(7)    
USER_STATS                       VARCHAR2(3)    
DURATION                         VARCHAR2(15)   
PCT_DIRECT_ACCESS                NUMBER         
ITYP_OWNER                       VARCHAR2(30)   
ITYP_NAME                        VARCHAR2(30)   
PARAMETERS                       VARCHAR2(1000) 
GLOBAL_STATS                     VARCHAR2(3)    
DOMIDX_STATUS                    VARCHAR2(12)   
DOMIDX_OPSTATUS                  VARCHAR2(6)    
FUNCIDX_STATUS                   VARCHAR2(8)    
JOIN_INDEX                       VARCHAR2(3)    
IOT_REDUNDANT_PKEY_ELIM          VARCHAR2(3)    
DROPPED                          VARCHAR2(3)    
VISIBILITY                       VARCHAR2(9)    
DOMIDX_MANAGEMENT                VARCHAR2(14)   
SEGMENT_CREATED                  VARCHAR2(3)
*/


DESC USER_IND_COLUMNS;
/*
이름              널? 유형             
--------------- -- -------------- 
INDEX_NAME         VARCHAR2(30)   
TABLE_NAME         VARCHAR2(30)   
COLUMN_NAME        VARCHAR2(4000) 
COLUMN_POSITION    NUMBER         
COLUMN_LENGTH      NUMBER         
CHAR_LENGTH        NUMBER         
DESCEND            VARCHAR2(4)   
*/

-- 실습 5) 
SELECT u.*
  FROM USER_INDEXES u
 WHERE U.INDEX_NAME = 'IDX_CUST_USERID' 
;
 /*
 INDEX_NAME, INDEX_TYPE, TABLE_OWNER, TABLE_NAME, TABLE_TYPE, UNIQUENESS, COM ....
 --------------------------------------------------------------------------------
 IDX_CUST_USERID	NORMAL	SCOTT	CUSTOMER	TABLE	UNIQUE	DISABLED	....
 
 */
 
 -- 실습 6) 
SELECT u.*
  FROM USER_IND_COLUMNS u
 WHERE U.INDEX_NAME = 'IDX_CUST_USERID' 
;
 
 /*
 INDEX_NAME, TABLE_NAME, COLUMN_NAME, COLUMN_POSITION, COLUMN_LENGTH, CHAR_LENGTH, DESCEND
 -----------------------------------------------------------------------------------------
 IDX_CUST_USERID	CUSTOMER	USERID	1	4	4	ASC
 */
 
-- 실습 7) 
DROP INDEX IDX_CUST_USERID;
--Index IDX_CUST_USERID이(가) 삭제되었습니다.    

-- 실습 8) 
SELECT u.*
  FROM USER_IND_COLUMNS u
 WHERE U.INDEX_NAME = 'IDX_CUST_USERID' 
;
-- 'IDX_CUST_USERID' 인덱스가 없으므로 삭제된 것을 확인.


-- PL/SQL 실습 1)

SET SERVEROUTPUT ON

BEGIN
	

	DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL World');

END;
/
/*
Hello, PL/SQL World


PL/SQL 프로시저가 성공적으로 완료되었습니다.

*/

-- 실습 2)

SET SERVEROUTPUT ON
DECLARE
    hello VARCHAR2(20) := 'Hello, PL/SQL World';
BEGIN
	
    
	DBMS_OUTPUT.PUT_LINE(hello);

END;
/
/*
Hello, PL/SQL World


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 실습 3)
CREATE OR REPLACE PROCEDURE log_execution
(   userid    IN VARCHAR2
  , log_date IN DATE)
IS
BEGIN

    DBMS_OUTPUT.PUT_LINE(userid || ' : ' || log_date);
    
END sp_maxim;
/





CREATE OR REPLACE PROCEDURE sp_maxim
(   name    IN  VARCHAR2
  , message IN  VARCHAR2
  , result  OUT VARCHAR2)
IS
BEGIN

    DBMS_OUTPUT.PUT_LINE(name || ' : ' || MESSAGE);
    -- result OUT 변수에 저장
    result := name || ' : ' || message;
END sp_maxim;
/

VAR v_log_user VARCHAR2(200)
VAR v_log_date DATE
