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
    ;
-- 실습 11)--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_set_comm
( v_comm    OUT EMP.COMM%TYPE)
IS
    v_job      EMP.JOB%TYPE;
BEGIN
    SELECT e.job
      INTO v_job
      FROM emp e
    ;
    
    UPDATE emp e SET E.COMM = v_comm
     WHERE e.job = v_job;
    
    IF v_job = 'SALESMAN'   THEN v_comm := 1000;
                                UPDATE emp e SET E.COMM = v_comm
                                 WHERE e.job = v_job;
    ELSIF v_job = 'MANAGER' THEN v_comm := 1500;
                                UPDATE emp e SET E.COMM = v_comm
                                 WHERE e.job = v_job;
    ELSE v_comm := 500;
    END IF;
    
END sp_set_comm;
/

var v_set_comm NUMBER

EXECUTE sp_set_comm(:v_set_comm)
PRINT v_set_comm

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
    cnt         NUMBER := 10;
BEGIN
    WHILE cnt > 1 LOOP
        cnt := cnt - 1;
        IF MOD(cnt, 2) = 0   THEN DBMS_OUTPUT.PUT_LINE(cnt);
        END IF;
    END LOOP;
END;
/

/**
8
6
4
2


PL/SQL 프로시저가 성공적으로 완료되었습니다.
**/

-- 실습 14)
