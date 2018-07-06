DROP TABLE CUSTOMER;
DROP SEQUENCE SEQ_CUST_USERID;
COMMIT;

/*
Table CUSTOMER이(가) 삭제되었습니다.

Sequence SEQ_CUST_USERID이(가) 삭제되었습니다.

커밋 완료.
*/

-- 테이블 생성
CREATE TABLE CUSTOMER
( userid       VARCHAR2(4)
, name         VARCHAR2(15)       NOT NULL
, birthyear    NUMBER(4)
, address      VARCHAR2(30)
, phone        VARCHAR2(13)
, grade        VARCHAR2(6)        DEFAULT 'SILVER'
, regdate      DATE               DEFAULT sysdate
, updatedt     DATE               DEFAULT sysdate
, CONSTRAINT   pk_customer        PRIMARY KEY (userid)
, CONSTRAINT   ck_customer_grade  CHECK (grade IN ('GENERAL', 'SILVER' , 'GOLD', 'VIP' ))
);
-- Table CUSTOMER이(가) 생성되었습니다.
    
    
    
-- 시퀀스 생성
CREATE SEQUENCE seq_cust_userid
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
;


-- INSERT 문 테스트
INSERT INTO CUSTOMER c(c.userid, c.name, c.address, c.phone)
    VALUES ('C'||lpad(SEQ_CUST_USERID.nextval,3,0), '2zoo0', 'Daejeon', '01051396628'); 

-- Sequence SEQ_CUST_USERID이(가) 생성되었습니다.


-- 현재 SEQ_CUST_USERID 확인 
SELECT SEQ_CUST_USERID.CURRVAL FROM dual;
SELECT 'C'||lpad(SEQ_CUST_USERID.CURRVAL,3,0) as "lpad_Seq" from dual;

CREATE OR REPLACE PROCEDURE sp_insert_customer
( v_name        IN CUSTOMER.NAME%TYPE
, v_address     IN CUSTOMER.ADDRESS%TYPE
, v_phone       IN CUSTOMER.PHONE%TYPE
, v_msg        OUT VARCHAR2
)
IS
BEGIN
    INSERT INTO CUSTOMER c(c.userid, c.name, c.address, c.phone)
    VALUES ('C' || lpad(SEQ_CUST_USERID.NEXTVAL,3,0), v_name, v_address, v_phone);
    v_msg := '유저아이디 '|| 'C'||lpad(SEQ_CUST_USERID.CURRVAL,3,0) || ', 유저번호 '|| v_name || ' 정보 추가';
END sp_insert_customer;
/
--Procedure SP_INSERT_CUSTOMER이(가) 컴파일되었습니다.

VAR v_insert_customer_msg VARCHAR2(200)

EXECUTE sp_insert_customer(v_name => '3zoo0', v_address => 'Seoul', v_phone => '01051396628', v_msg => :v_insert_customer_msg)
EXECUTE sp_insert_customer(v_name => '4zoo0', v_address => 'Suwon', v_phone => '01051396628', v_msg => :v_insert_customer_msg)
EXECUTE sp_insert_customer(v_name => '5zoo0', v_address => 'Busan', v_phone => '01051396628', v_msg => :v_insert_customer_msg)
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
PRINT v_insert_customer_msg

/*
V_INSERT_CUSTOMER_MSG
--------------------------------------------------------------------------------
고객번호 C004, 고객명 5zoo0 정보 입력 완료
*/

SELECT c.USERID
     , c.NAME
     , c.BIRTHYEAR
     , c.ADDRESS
     , c.PHONE
     , c.GRADE
     , c.REGDATE
     , c.UPDATEDT
  FROM customer c
 ORDER BY c.userid
;

/********************************************************************
USERID, NAME, BIRTHYEAR, ADDRESS, PHONE, GRADE, REGDATE, UPDATEDT
---------------------------------------------------------------------
C001	2zoo0		Daejeon	01051396628	SILVER	18/07/06	18/07/06
C002	3zoo0		Seoul	01051396628	SILVER	18/07/06	18/07/06
C003	4zoo0		Suwon	01051396628	SILVER	18/07/06	18/07/06
C004	5zoo0		Busan	01051396628	SILVER	18/07/06	18/07/06
*********************************************************************/
