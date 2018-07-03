SET SERVEROUTPUT ON

-- 실습 5)

CREATE OR REPLACE PROCEDURE chk_sal_per_month
( v_sal         IN NUMBER
, v_sal_month  OUT NUMBER
)
IS
BEGIN
    v_sal_month := v_sal*12;
END chk_sal_per_month;
/


VAR v_month NUMBER;

EXEC chk_sal_per_month(5000, :V_MONTH);

PRINT v_month


/**********************************************
Procedure CHK_SAL_PER_MONTH이(가) 컴파일되었습니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.


   V_MONTH
----------
     60000
**********************************************/


-- 실습 6)
CREATE OR REPLACE PROCEDURE sp_variables
( v_deptno      IN NUMBER
, v_loc         IN VARCHAR2)
IS
    v_hiredate  VARCHAR2(30);
    v_empno     NUMBER := 1999;
    v_msg       VARCHAR2(500) DEFAULT '지역 변수';
    v_max CONSTANT NUMBER := 5000;
BEGIN
    v_hiredate := sysdate;
    DBMS_OUTPUT.PUT_LINE('v_hiredate : ' || v_hiredate);
    DBMS_OUTPUT.PUT_LINE('v_deptno : ' || v_deptno);
    DBMS_OUTPUT.PUT_LINE('v_loc : ' || v_loc);
    DBMS_OUTPUT.PUT_LINE('v_empno : ' || v_empno);
    DBMS_OUTPUT.PUT_LINE('v_msg : ' || v_msg);
    DBMS_OUTPUT.PUT_LINE('v_max : ' || v_max);
END sp_variables;
/

EXEC SP_VARIABLES('20', '하와이')


-- 실습 7)

CREATE TABLE log_table (
  log_user VARCHAR2(20)
, log_date DATE
)
;
CREATE OR REPLACE PROCEDURE log_execution_sp
(  log_user  IN  log_table.log_user%type
 , log_date  OUT log_table.log_date%type)
IS
BEGIN
    log_date := sysdate;
    INSERT INTO log_table VALUES (log_user, log_date);
    
    DBMS_OUTPUT.PUT_LINE('INSERT INTO log_table VALUES ('||log_user||', '||log_date||')');
END log_execution_sp;
/

VAR v_log_date VARCHAR2

EXECUTE log_execution_sp('2zoo0', :v_log_date);

/*****************************
INSERT INTO log_table VALUES (2zoo0, 18/07/03)
*****************************/

PRINT v_log_date 
/*
V_LOG_DATE
--------------------------------------------------------------------------------
18/07/03
*/


-- 실습 8)
CREATE OR REPLACE PROCEDURE sp_chng_date_format
( v_date IN OUT VARCHAR2 )
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('적용    값 : ' || v_date);
    v_date := TO_CHAR(sysdate, 'YYYY Mon dd');
    DBMS_OUTPUT.PUT_LINE('적용    값 : ' || v_date);
END sp_chng_date_format;
/

-- Procedure SP_CHNG_DATE_FORMAT이(가) 컴파일되었습니다.

VAR v_date_bind VARCHAR2(30)

EXEC :v_date_bind := sysdate

EXEC sp_chng_date_format(:v_date_bind)
/*
적용    값 : 2018 7월  03
적용    값 : 2018 7월  03


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/
PRINT v_date_bind
/****************
V_DATE_BIND
--------------------
2018 7월  03
****************/

SELECT MAX(d.DEPTNO)
     FROM dept d;

-- 실습 9)
CREATE OR REPLACE PROCEDURE insert_dept
( v_deptno  OUT    DEPT.DEPTNO%TYPE
, v_dname   IN     DEPT.DNAME%TYPE
, v_loc     IN     DEPT.LOC%TYPE
)
IS
BEGIN
   SELECT MAX(d.DEPTNO)
     INTO v_deptno
     FROM dept d;
    
   v_deptno := v_deptno + 10;
   
   INSERT INTO dept (DEPTNO, DNAME, LOC)
   VALUES (v_deptno , v_dname, v_loc)
   ;
   DBMS_OUTPUT.PUT_LINE(v_deptno|| ' ' || v_dname || ' '|| v_loc);
    
END insert_dept;
/

-- Procedure INSERT_DEPT이(가) 컴파일되었습니다.
VAR v_deptno_bind NUMBER


EXEC insert_dept(:v_deptno_bind, 'game', 'seoul');

PRINT v_deptno_bind
/********

V_DEPTNO_BIND
-------------
           50
**********/
/**************************
DEPTNO, DNAME, LOC
----------------------------
50	game	    seoul
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*************************/

-- 실습 10)

EXEC insert_dept(v_deptno => :v_deptno_bind, v_dname => 'SLEEP', v_loc=> 'HOME');

/*****************
70 SLEEP HOME


PL/SQL 프로시저가 성공적으로 완료되었습니다.


DEPTNO, DNAME, LOC
---------------------------
50	game	seoul
60	game	seoul
70	SLEEP	HOME
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
*/

UPDATE emp e SET E.COMM = 100
     WHERE e.job = 'PRESIDENT';

SELECT e.JOB
      FROM emp e
      WHERE e.EMPNO = 7902
    ;
-- 실습 11)
SELECT e.comm
  FROM emp e
 WHERE e.empno = 7521; -- 500
 

CREATE OR REPLACE PROCEDURE sp_set_comm
( v_empno       IN  EMP.EMPNO%TYPE 
, v_comm        OUT EMP.COMM%TYPE   
)
IS
   v_job         EMP.JOB%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_empno);
    SELECT e.JOB, e.COMM
      INTO v_job, v_comm
      FROM emp e
     WHERE e.EMPNO = v_empno
    ; 
    DBMS_OUTPUT.PUT_LINE(v_job);
    IF      v_job = 'SALESMAN'  THEN v_comm := 1000; 
    ELSIF   v_job = 'MANAGER'   THEN v_comm := 1500;
    ELSE v_comm := 500;
    END IF;
    UPDATE emp e SET COMM = v_comm WHERE e.EMPNO = v_empno;
END sp_set_comm;
/

var v_set_comm NUMBER

EXEC sp_set_comm(7499, :v_set_comm)

/**
Procedure SP_SET_COMM이(가) 컴파일되었습니다.

PL/SQL 프로시저가 성공적으로 완료되었습니다.
**/

PRINT v_set_comm
/**
V_SET_COMM
----------
      1000
**/
SELECT e.comm
  FROM emp e
 WHERE e.empno = 7521; -- 1000
--  실습 12)
DECLARE 
    cnt         NUMBER :=0;
BEGIN
    LOOP
        cnt := cnt + 1;
        DBMS_OUTPUT.PUT_LINE(cnt);
        EXIT WHEN cnt = 10;
    END LOOP
    ;
END;
/

/**
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
**/

-- 실습 13)
DECLARE 
    cnt         NUMBER := 0;
BEGIN
    FOR cnt IN REVERSE 1 .. 10 LOOP
        IF MOD(cnt, 2) = 0   THEN DBMS_OUTPUT.PUT_LINE(cnt);
        END IF;
    END LOOP;
END;
/

/**
10
8
6
4
2


PL/SQL 프로시저가 성공적으로 완료되었습니다.
**/

-- 실습 14)
DECLARE 
    cnt         NUMBER := 0;
BEGIN
    WHILE cnt < 10 LOOP
        cnt := cnt + 1;
        DBMS_OUTPUT.PUT_LINE(cnt);
        
    END LOOP;
END;
/
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.

*/

-- 실습 15)

CREATE OR REPLACE FUNCTION emp_sal_avg
( v_job       IN EMP.JOB%TYPE)
RETURN NUMBER
IS
    v_avg_sal   EMP.SAL%TYPE;
BEGIN
    SELECT avg(e.sal)
      INTO v_avg_sal
      FROM emp e
     WHERE e.job = v_job
    ;
    
    RETURN ROUND(v_avg_sal);

END emp_sal_avg;
/

-- Function EMP_SAL_AVG이(가) 컴파일되었습니다.

-- 실습 16)
SELECT emp_sal_avg('CLERK') emp_sal_avg
  FROM dual;
  
/**
EMP_SAL_AVG
------------
  1017
**/
  
-- 실습 17)
SELECT e.ename
     , E.SAL
  FROM emp e
 WHERE e.sal >= emp_sal_avg('CLERK');
 /***************
 ALLEN	1600
WARD	1250
JONES	2975
MARTIN	1250
BLAKE	2850
CLARK	2450
KING	5000
TURNER	1500
FORD	3000
MILLER	1300
 ***************/
 
-- 실습 18)
CREATE OR REPLACE PROCEDURE sp_dept_row
    ( v_deptno      IN DEPT.DEPTNO%TYPE
    , v_dname       IN DEPT.dname%TYPE
    , v_loc         IN DEPT.loc%TYPE
    , v_msg         OUT VARCHAR2
    )
IS   
BEGIN
    INSERT INTO dept (deptno, dname, loc)
    VALUES (v_deptno, v_dname, v_loc);
    v_msg := v_deptno||'부서를 추가했습니다';
    commit;
    
    
    EXCEPTION  
        WHEN DUP_VAL_ON_INDEX
        THEN 
             UPDATE dept d
                SET d.dname = v_dname
                  , d.loc = v_loc 
              WHERE d.deptno = v_deptno
             ;
             
             v_msg := v_deptno||' 부서가 이미 존재하여 수정합니다.';
             
END sp_dept_row;
/
 show errors

VAR sp_dept_row_msg VARCHAR2

EXEC sp_dept_row(60,'STUDY','seoul', :sp_dept_row_msg);

PRINT sp_dept_row_msg

/**
Procedure SP_DEPT_ROW이(가) 컴파일되었습니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.


SP_DEPT_ROW_MSG
--------------------------------------------------------------------------------
60 부서가 이미 존재하여 수정합니다.
**/



/***********************           VIEW      *********************************/

-- 실습 9 )


CREATE TABLE CUSTOMER 
( userid VARCHAR2(4) PRIMARY KEY
, name VARCHAR2(30) NOT NULL
, birthyear NUMBER(4)
, regdate DATE DEFAULT sysdate
, address VARCHAR2(30)
);
ALTER TABLE CUSTOMER ADD phone VARCHAR2(11);
ALTER TABLE CUSTOMER ADD grade VARCHAR2(30) CHECK(grade IN('VIP', 'GOLD', 'SILVER'));
/*********************************************************************************
기존 customer table 생성
*********************************************************************************/

CREATE VIEW  v_cust_general_regdt
(이름, 등록일)
AS
SELECT c.userid as "이름"
     , c.regdate as "등록일"
 FROM customer c
WHERE c.grade = 'General'
;
-- View V_CUST_GENERAL_REGDT이(가) 생성되었습니다.

-- 실습 10)
SELECT v.*
 FROM v_cust_general_regdt v
;

-- 내용 없음

desc v_cust_general_regdt
/**
이름  널?       유형          
--- -------- ----------- 
이름 NOT NULL VARCHAR2(4) 
등록일          DATE    
**/

-- 실습 11) 
DESC USER_VIEWS
/**
이름               널?       유형             
---------------- -------- -------------- 
VIEW_NAME        NOT NULL VARCHAR2(30)   
TEXT_LENGTH               NUMBER         
TEXT                      LONG           
TYPE_TEXT_LENGTH          NUMBER         
TYPE_TEXT                 VARCHAR2(4000) 
OID_TEXT_LENGTH           NUMBER         
OID_TEXT                  VARCHAR2(4000) 
VIEW_TYPE_OWNER           VARCHAR2(30)   
VIEW_TYPE                 VARCHAR2(30)   
SUPERVIEW_NAME            VARCHAR2(30)   
EDITIONING_VIEW           VARCHAR2(1)    
READ_ONLY                 VARCHAR2(1)    
**/

-- 실습 12)
SELECT u.view_name
     , u.text
  FROM user_views u
;

/**
VIEW_NAME,              TEXT
---------------------- --------------------------------
V_CUST_GENERAL_REGDT	"SELECT c.userid as "이름"
                              , c.regdate as "등록일"
                          FROM customer c
                         WHERE c.grade = 'General'"
**/
-- 실습 13)
DROP VIEW v_cust_general_regdt;
-- View V_CUST_GENERAL_REGDT이(가) 삭제되었습니다.

-- 실습 14)
SELECT u.view_name
     , u.text
  FROM user_views u
;
/**
VIEW_NAME,  TEXT
----------- ----------------

**/
