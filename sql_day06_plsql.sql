SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE sp_calc_year_sal
( v_sal         IN NUMBER
, v_sal_year    OUT NUMBER)
IS
BEGIN
    v_sal_year := v_sal * 12;
END sp_calc_year_sal;
/
--              오류가 존재하면 SHOW errors 명령으로 확인

--  5) OUT 모드 변수가 있는 프로시저이므로 BIND 변수가 필요
--    VAR명령으로 SQL*PLUS 의 변수를 선언하는 명령
--    DESC 명령 : SQL*PLUS

VARIABLE v_sal_year_bind NUMBER

-- 6) 프로시저 실행 : EXEC[UTE] : SQL*PLUS 명령
EXECUTE sp_calc_year_sal(1200000, :V_SAL_YEAR_BIND);

SHOW errors
-- 7) 실행 결과가 담긴 BIND 변수를 SQL*PLUS 에서 출력
PRINT v_sal_year_bind
/******************************
V_SAL_YEAR_BIND
---------------
       14400000
******************************/

-- 실습 6) 여러 형태의 변수를 사용하는 sp_variable 을 작성
/*
    IN 모드 변수 : v_deptno, v_loc
    지역 변수    : v_hiredate, v_empno, v_msg
    상수        : v_max
*/

-- 1) 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_variables
( v_deptno      IN NUMBER
, v_loc         IN VARCHAR2)
IS
    -- IS ~~ BEGIN 사이는 지역변수 선언/초기화
    v_hiredate  VARCHAR2(30);
    v_empno     NUMBER := 1999;
    v_msg       VARCHAR2(500) DEFAULT 'Hello,PL/SQL';
    -- CONSTANT 는 상수를 만드는 설정
    v_max CONSTANT NUMBER := 5000;
BEGIN
    -- 위에서 정의된 값들을 출력
    DBMS_OUTPUT.PUT_LINE('v_hiredate' || v_hiredate);
    
    v_hiredate := TO_CHAR(sysdate,'YYYY-MM-DD HH24:MI:SS DY');
    DBMS_OUTPUT.PUT_LINE('v_hiredate : ' || v_hiredate);
    DBMS_OUTPUT.PUT_LINE('v_deptno : ' || v_deptno);
    DBMS_OUTPUT.PUT_LINE('v_loc : ' || v_loc);
    DBMS_OUTPUT.PUT_LINE('v_empno : ' || v_empno);
    
    v_msg := '내일 지구가 멸망하더라도 나는 한 그루의 사과나무를 심겠다. by.스피노자';
    DBMS_OUTPUT.PUT_LINE('v_msg : ' || v_msg);
    
    -- 상수인 v_max 에 할당 시도
--    v_max := 10000; PLS-00363: expression 'V_MAX' cannot be used as an assignment target
    DBMS_OUTPUT.PUT_LINE('v_max : ' || v_max);
END sp_variables;
/
-- 2) 컴파일 / 디버깅
/*
25/5      PL/SQL: Statement ignored
25/5      PLS-00363: expression 'V_MAX' cannot be used as an assignment target
오류: 컴파일러 로그를 확인하십시오.
*/

-- 3) VAR : BIND 변수가 필요하면 선언

-- 4) EXEC : SP 실행
SET SERVEROUTPUT ON
EXEC SP_VARIABLES('10', '하와이')
EXEC SP_VARIABLES('20', '스페인')
EXEC SP_VARIABLES('30', '제주도')
EXEC SP_VARIABLES('40', '몰디브')

-- 5) PRINT : BIND 변수에 값이 저장되었으면 출력

/****************************************************
v_hiredate
v_hiredate : 18/07/03
v_deptno : 40
v_loc : 몰디브
v_empno : 1999
v_msg : 내일 지구가 멸망하더라도 나는 한 그루의 사과나무를 심겠다. by.스피노자
v_max : 5000


PL/SQL 프로시저가 성공적으로 완료되었습니다.
****************************************************/




-- PL/SQL   변수 : REFERENCE 변수의 사용
-- 1) %TYPE 변수
--      DEPT 테이블의 부서번호를 입력(IN 모드)받아서 부서명을 (OUT 모드) 출력하는 저장 프로시저 작성

-- (1) SP 이름 : sp_get_dname
-- (2) IN 변수 : v_deptno
-- (3) OUT 변수 : v_dname

CREATE OR REPLACE PROCEDURE sp_get_dname
( v_deptno      IN DEPT.DEPTNO%TYPE
, v_dname      OUT DEPT.DNAME%TYPE)
IS
BEGIN
    SELECT d.DNAME
      INTO v_dname
      FROM dept d
     WHERE D.DEPTNO = V_Deptno 
      ;
      
END sp_get_dname;
/

-- 2. 컴파일 / 디버깅
-- Procedure SP_GET_DNAME이(가) 컴파일되었습니다.

-- 3. BIND 변수가 필요하면 선언
VAR v_dname_bind VARCHAR2(30)

-- 4. EXEC : SP 실행
EXEC sp_get_dname(10, :v_dname_bind)
-- 5. PRINT : BIND 변수에 값이 저장되었으면 출력
PRINT v_dname_bind


/**
오류 보고 -
ORA-01403: no data found
ORA-06512: at "SCOTT.SP_GET_DNAME", line 6
ORA-06512: at line 1
01403. 00000 -  "no data found"
*Cause:    No data was found from the objects.
*Action:   There was no data from the objects which may be due to end of fetch.
**/


-- 2) %ROWTYPE
/*      특정 테이블의 한 행(row)를 컬럼의 순서대로
        
*/

--      DEPT 테이블의 부서번호를 입력(IN 모드)받아서 
--      부서 전체 정보를 화면 출력하는 저장 프로시저 작성

-- (1) SP 이름 : sp_get_dinfo
-- (2) IN 변수 : v_deptno
-- (3) 지역변수 : v_dinfo

CREATE OR REPLACE PROCEDURE sp_get_dinfo
( v_deptno      IN DEPT.DEPTNO%TYPE)
IS
    -- v_dinfo 변수는 dept 테이블의 한 행의 정보를 한번에 담는 변수
    v_dinfo     DEPT%ROWTYPE;
BEGIN
    -- IN 모드로 입력된 v_deptno 에 해당하는 부서정보
    -- 1행을 조회하여
    -- dept 테이블의 ROWTYPE 변수인 v_dinfo에 저장
    SELECT d.DEPTNO
         , D.DNAME
         , D.LOC
      INTO v_dinfo -- INTO 절에 명시되는 변수에는 1행만 저장 가능
      FROM dept d
     WHERE D.DEPTNO = V_Deptno 
      ;
      
      -- 조회된 결과를 화면출력
      DBMS_OUTPUT.PUT_LINE('부서번호' || V_DINFO.deptno);
      DBMS_OUTPUT.PUT_LINE('부서이름' || V_DINFO.dname);
      DBMS_OUTPUT.PUT_LINE('부서위치' || V_DINFO.loc);
      
END sp_get_dinfo;
/

-- 2. 컴파일 / 디버깅
-- Procedure SP_GET_DINFO이(가) 컴파일되었습니다.

-- 3. BIND 변수가 필요하면 선언
VAR v_dname_bind VARCHAR2(30)

-- 4. EXEC : SP 실행
EXEC sp_get_dinfo(10)
EXEC sp_get_dinfo(20)
EXEC sp_get_dinfo(50)
/********
부서번호10
부서이름ACCOUNTING
부서위치NEW YORK


PL/SQL 프로시저가 성공적으로 완료되었습니다.
***********/
-- 5. PRINT : BIND 변수에 값이 저장되었으면 출력

----------------------------------------------------------------------------------------------------------

-- 수업 중 실습
-- 문제) 한 사람의 사번을 입력받으면 그 삶의 소속 부서명, 부서위치를
--      함께 화면 출력

SELECT e.empno
     , D.DNAME
     , D.LOC
  INTO   
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno
   AND e.empno = ?
;
-- (1) sp_get_emp_info
-- (2) IN변수 : v_empno
-- (3) %TYPE, %ROWTYPE 변수 활용


-- 1. 프로시저 작성

CREATE OR REPLACE PROCEDURE sp_get_emp_info
( v_empno       IN EMP.EMPNO%TYPE)
IS
     v_emp      EMP%ROWTYPE;
     v_dept     DEPT%ROWTYPE;
BEGIN
    SELECT e.empno
         , E.ENAME
      INTO v_emp
      FROM emp e
     WHERE e.empno = v_empno
    ;
    SELECT d.*
      INTO v_dept
      FROM dept d
     WHERE d.deptno = v_emp.deptno
    ;
    
    DBMS_OUTPUT.PUT_LINE('사원번호' || v_emp.empno);
    DBMS_OUTPUT.PUT_LINE('부서이름' || v_dept.dname);
    DBMS_OUTPUT.PUT_LINE('부서위치' || v_dept.loc);
END sp_get_emp_info;
/

EXEC sp_get_emp_info(7654)





-- 문제 사번을 입력 (IN모드) 받아서
--     사번, 이름, 매니저이름 부서이름 부서위치 급여등급 함께 출력
/*
    sp 이름 : sp_get_emp_info_detail
        IN : v_empno
    RECODE : v_emp_record

*/
CREATE OR REPLACE PROCEDURE sp_get_emp_info_detail
( v_empno       IN EMP.EMPNO%TYPE)
IS
    -- 1. RECODE 타입
    TYPE emp_record_type IS RECORD
    ( r_empno       emp.empno%TYPE
    , r_ename       emp.ename%TYPE
    , r_mgrname     emp.ename%TYPE
    , r_dname       DEPT.DNAME%TYPE
    , r_loc         DEPT.LOC%TYPE
    , r_salgrade    SALGRADE.GRADE%TYPE
    );
    -- 2. 1에서 선언한 타입의 변수를 선언
    v_emp_record    emp_record_type;
BEGIN
     -- 2. 1에서 선언한 RECODE 타입은 조인의 결과를 받을 수 있음
    SELECT e.EMPNO
         , e.ENAME
         , e1.ENAME
         , d.DNAME
         , d.LOC
         , s.GRADE
      INTO v_emp_record
      FROM emp e
         , emp e1
         , dept d
         , salgrade s
     WHERE e.MGR = e1.EMPNO
       AND e.EMPNO = v_empno
       AND e.DEPTNO = d.DEPTNO
       AND e.SAL BETWEEN s.LOSAL AND S.HISAL
    ;
    
    DBMS_OUTPUT.PUT_LINE('사    번 : ' || v_emp_record.r_empno);
    DBMS_OUTPUT.PUT_LINE('이    름 : ' || v_emp_record.r_ename);
    DBMS_OUTPUT.PUT_LINE('매 니 저 : ' || v_emp_record.r_mgrname);
    DBMS_OUTPUT.PUT_LINE('부 서 명 : ' || v_emp_record.r_dname);
    DBMS_OUTPUT.PUT_LINE('부서 위치 : ' || v_emp_record.r_loc);
    DBMS_OUTPUT.PUT_LINE('급여 등급 : ' || v_emp_record.r_salgrade);
END sp_get_emp_info_detail;
/

EXEC sp_get_emp_info_detail(7369)

/*****************************************************
Procedure SP_GET_EMP_INFO_DETAIL이(가) 컴파일되었습니다.

사    번 : 7369
이    름 : SMITH
매 니 저 : FORD
부 서 명 : RESEARCH
부서 위치 : DALLAS
급여 등급 : 1


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*****************************************************/

DECLARE
    v_empno         EMP.EMPNO%TYPE;
BEGIN
    SELECT e.empno
      INTO v_empno
      FROM emp e
     WHERE e.empno = 7902 
    ;
    
    SP_GET_EMP_INFO_DETAIL(v_empno);
END;
/

/*****************************************************
사    번 : 7902
이    름 : FORD
매 니 저 : JONES
부 서 명 : RESEARCH
부서 위치 : DALLAS
급여 등급 : 4


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*****************************************************/



---------------------------------------------------------
-- PL/SQL 변수 : 아규먼트 변수 IN OUT 모드의 사용
---------------------------------------------------------

-- IN : SP로 값이 전달 될 때 사용
--      프로시져를 사용하는 쪽(SQL*PLUS) 에서 프로시저로 전달
---------------------------------------------------------
-- OUT : SP에서 수행 결과 값이 저장되는 용도, 출력용 프로시저는
--       리턴(반환)이 없기 때문에 SP를 호출한 쪽에 돌려주는 
--       방법으로 사용
---------------------------------------------------------
-- INOUT : 하나의 매개 변수에 입력, 출력을 함께 사용
---------------------------------------------------------

-- 문제 ) 기본 숫자값을 입력 받아서 숫자 포멧화 '$9,999.00'
--        출력하는 프로시저를 작성 IN OUT 모드 변수를 활용

--- (1) SP 이름 : sp_chng_number_format
--- (2) IN OUT 변수 : v_number
--- (3) BIND 변수 : v_number_bind

-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_chng_number_format
( v_number IN OUt VARCHAR2 )
IS
BEGIN

    DBMS_OUTPUT.PUT_LINE('초기 입력값 : ' || v_number);
    
    v_number := TO_CHAR(TO_NUMBER(v_number), '$9,999.00');
    
    DBMS_OUTPUT.PUT_LINE('적용    값 : ' || v_number);
END sp_chng_number_format;
/



-- 2. 컴파일 / 디버깅
-- Procedure SP_CHNG_NUMBER_FORMAT이(가) 컴파일되었습니다.

-- 3. VAR : BIND 변수 선언

VAR v_number_bind VARCHAR2(20)

-- 4. EXRC : 실행
    -- 초기값 1000 저장
EXEC :v_number_bind := 1000
    -- 1000이 지정된 BIND 변수를 프로시저에 전달
EXEC sp_chng_number_format(:v_number_bind)
-- 5. PRINT : BIND 변수 출력
PRINT v_number_bind





CREATE OR REPLACE PROCEDURE sp_chng_number_format
( in_number IN NUMBER
, out_number OUT VARCHAR2)
IS
BEGIN

    SELECT TO_CHAR(in_number, '$9,999.00')
      INTO out_number
      FROM dual
    ;
    
END sp_chng_number_format;
/

VAR v_out_number_bind VARCHAR2(10)

EXEC sp_chng_number_format(1000, :v_out_number_bind)
PRINT v_out_number_bind



---------------------------------------------------------------------------------
-- 매개변수 전달업 : SP 에서는 위치, 변수명에 의한 전달 방식이 있다.
---------------------------------------------------------------------------------
-- 1. 위치에 의한 전달법
EXEC sp_chng_number_format(1000, :v_out_number_bind)

-- 2. 변수명에 의한 전달
EXEC sp_chng_number_format(in_number => 1002, out_number => :v_out_number_bind)
PRINT v_out_number_bind



---------------------------------------------------------------------------------
-- PL/SQL 제어문
---------------------------------------------------------------------------------
-- 1. IF 제어문
--   IF ~ THEN ~[ELSIF ~ THEN] ~ ELSE ~ END IF;
CREATE OR REPLACE PROCEDURE sp_get_tribute_fee
( v_empno           IN   emp.empno%TYPE
, v_tribute_fee     OUT  EMP.SAL%TYPE)
IS
    -- 1. 사번인 직원의 직무를 저장할 지역변수 선언
    v_job       EMP.JOB%TYPE;
    -- 1. 사번인 직원의 급여를 저장할 지역변수 선언
    v_sal       EMP.SAL%TYPE;
BEGIN
    -- 3. 입력된 사번 직원의 직무, 급여를 조회하여 v_job, v_sal에 저장
    
    
    -- 1. 입력된 사번 직원의 직무를 조회
    SELECT e.JOB, e.SAL
      INTO v_job, v_sal
      FROM emp e
     WHERE e.EMPNO = v_empno 
    ;
    
    -- 2. 일정 비율로 v_tribute_fee 를 계산
    IF v_job = 'CLERK'        THEN v_tribute_fee := v_sal * 0.05;
    ELSIF v_job = 'SALESMAN'  THEN v_tribute_fee := v_sal * 0.04;
    ELSIF v_job = 'MANAGER'   THEN v_tribute_fee := v_sal * 0.37;
    ELSIF v_job = 'ANALYST'   THEN v_tribute_fee := v_sal * 0.37;
    ELSIF v_job = 'PRESIDENT' THEN v_tribute_fee := v_sal * 0.37;
    END IF;
    
END sp_get_tribute_fee;
/

-- Procedure SP_GET_TRIBUTE_FEE이(가) 컴파일되었습니다.

VAR v_tribute_fee_bind NUMBER


EXEC sp_get_tribute_fee(v_tribute_fee => :v_tribute_fee_bind, v_empno => 7566)
--PL/SQL 프로시저가 성공적으로 완료되었습니다.

PRINT v_tribute_fee_bind


---------------------------------------------------------------------------------
-- 2.LOOP 기본 반복문
---------------------------------------------------------------------------------
-- ANONYMOUS  로 실행 예
-- 문제 ) 1 ~ 10 까지의 합을 출력

DECLARE
    -- 1. 초기값 변수 선언 및 초기화
    v_init NUMBER := 0;
    -- 2. 합산을 저장 할 변수 선언 / 초기화
    v_sum  NUMBER := 0;

BEGIN
    LOOP
        v_init := v_init + 1;
        v_sum := v_sum + v_init;
        DBMS_OUTPUT.PUT_LINE('v_sum : ' || v_sum);
        -- 반복문 종료 조건
        EXIT WHEN v_init = 10;
    END LOOP
    ;
    
    -- 합산 변수 출력
    DBMS_OUTPUT.PUT_LINE('합산 결과 : ' || v_sum);
    -- 반복문 
    

END;
/

/*******************************************
v_sum : 1
v_sum : 3
v_sum : 6
v_sum : 10
v_sum : 15
v_sum : 21
v_sum : 28
v_sum : 36
v_sum : 45
v_sum : 55
합산 결과 : 55


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*******************************************/


---------------------------------------------------------------------------------
-- 2. LOOP : FOR LOOP 카운터 변수를 사용하는 반복문
---------------------------------------------------------------------------------
-- 지정된 횟수만큼 실행 반복문
-- 문제 ) 1 ~ 20 사이의 3의 배수 출력 : ANNONYMOUS PROCEDURE
DECLARE 
    -- 1. FOR LOOP 에서 사용할 카운터 변수 선언 / 초기화
    cnt         NUMBER :=0;
BEGIN
    -- 2. LOOP 작성
    FOR cnt IN 1 .. 20 LOOP
        --3. 3의 배수 판단
        IF (MOD(cnt, 3) = 0)
            THEN DBMS_OUTPUT.PUT_LINE(cnt);
        END IF;
    END LOOP;
END;
/


---------------------------------------------------------------------------------
-- 2. LOOP : WHILE LOOP 조건에 따라 수행되는 반복문
---------------------------------------------------------------------------------
-- 문제 ) 1~20 사이의 수 중에서 2의 배수를 화면에 출력
--     
DECLARE 
    -- 반복 조건으로 사용할 횟수 변수 선언
    cnt         NUMBER :=0;
BEGIN
    -- WHILE 반복문 작성
    WHILE cnt < 20 LOOP
        cnt := cnt + 2;
        DBMS_OUTPUT.PUT_LINE(cnt);
    END LOOP;
END;
/

/**********************

2
4
6
8
10
12
14
16
18
20


PL/SQL 프로시저가 성공적으로 완료되었습니다.
**********************/



---------------------------------------------------------------------------------
-- PL/SQL : Stored function 
---------------------------------------------------------------------------------
-- 대부분 SP랑 유사
-- IS 블록 전에 RETURN 구문이 존재
-- RETURN 구문에는 문장 종료 기호 (;) 없음
-- 실행은 기존 사용하는 함수와 동일하게 SELECT, WHERE 절 등에 사용함.

-- 문제 ) 부서번호를 입력받아서 해당 부서의 급여 평균을 구하느 함수 작성
---- (1) FN 이름 : fn_avg_sal_by_dept
---- (2) IN 변수 : v_deptno
-- 1. 함수 작성
CREATE OR REPLACE FUNCTION fn_avg_sal_by_deptt
( v_deptno      IN      EMP.DEPTNO%TYPE)
RETURN NUMBER
IS
    v_avg_sal   EMP.SAL%TYPE;
BEGIN
   -- 부서별 급여 평균을 함수를 사용하여 구하고 저장
   SELECT avg(e.sal)
   INTO v_avg_sal
     FROM emp e
    WHERE e.DEPTNO = v_deptno
    ;
   RETURN ROUND(v_avg_sal);
END fn_avg_sal_by_deptt;
/
-- 2. 컴파일 / 디버깅
Function FN_AVG_SAL_BY_DEPTT이(가) 컴파일되었습니다.
-- 3. 이 함수를 사용하느 쿼리를 작성하여 실행해 본다.
SELECT fn_avg_sal_by_deptt(10) 평균급여
   FROM dual;
   
   
   
   
   
   ------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_get_emp_info_detail
( v_empno       IN EMP.EMPNO%TYPE)
IS
    -- 1. RECODE 타입
    TYPE emp_record_type IS RECORD
    ( r_empno       emp.empno%TYPE
    , r_ename       emp.ename%TYPE
    , r_mgrname     emp.ename%TYPE
    , r_dname       DEPT.DNAME%TYPE
    , r_loc         DEPT.LOC%TYPE
    , r_salgrade    SALGRADE.GRADE%TYPE
    );
    -- 2. 1에서 선언한 타입의 변수를 선언
    v_emp_record    emp_record_type;
BEGIN
     -- 2. 1에서 선언한 RECODE 타입은 조인의 결과를 받을 수 있음
    SELECT e.EMPNO
         , e.ENAME
         , e1.ENAME
         , d.DNAME
         , d.LOC
         , s.GRADE
      INTO v_emp_record
      FROM emp e
         , emp e1
         , dept d
         , salgrade s
     WHERE e.MGR = e1.EMPNO(+)
       AND e.DEPTNO = d.DEPTNO
       AND e.SAL BETWEEN s.LOSAL AND S.HISAL
       AND e.EMPNO = v_empno
    ;
    
    DBMS_OUTPUT.PUT_LINE('사    번 : ' || v_emp_record.r_empno);
    DBMS_OUTPUT.PUT_LINE('이    름 : ' || v_emp_record.r_ename);
    DBMS_OUTPUT.PUT_LINE('매 니 저 : ' || v_emp_record.r_mgrname);
    DBMS_OUTPUT.PUT_LINE('부 서 명 : ' || v_emp_record.r_dname);
    DBMS_OUTPUT.PUT_LINE('부서 위치 : ' || v_emp_record.r_loc);
    DBMS_OUTPUT.PUT_LINE('급여 등급 : ' || v_emp_record.r_salgrade);
END sp_get_emp_info_detail;
/

EXEC sp_get_emp_info_detail(7839)







CREATE OR REPLACE PROCEDURE sp_get_emp_info_detail
( v_empno       IN EMP.EMPNO%TYPE)
IS
    -- 1. RECODE 타입
    TYPE emp_record_type IS RECORD
    ( r_empno       emp.empno%TYPE
    , r_ename       emp.ename%TYPE
    , r_mgrname     emp.ename%TYPE
    , r_dname       DEPT.DNAME%TYPE
    , r_loc         DEPT.LOC%TYPE
    , r_salgrade    SALGRADE.GRADE%TYPE
    );
    -- 2. 1에서 선언한 타입의 변수를 선언
    v_emp_record    emp_record_type;
BEGIN
     -- 2. 1에서 선언한 RECODE 타입은 조인의 결과를 받을 수 있음
    SELECT e.EMPNO
         , e.ENAME
         , e1.ENAME
         , d.DNAME
         , d.LOC
         , s.GRADE
      INTO v_emp_record
      FROM emp e
         , emp e1
         , dept d
         , salgrade s
     WHERE e.MGR = e1.EMPNO
       AND e.DEPTNO = d.DEPTNO
       AND e.SAL BETWEEN s.LOSAL AND S.HISAL
       AND e.EMPNO = v_empno
    ;
    
    DBMS_OUTPUT.PUT_LINE('사    번 : ' || v_emp_record.r_empno);
    DBMS_OUTPUT.PUT_LINE('이    름 : ' || v_emp_record.r_ename);
    DBMS_OUTPUT.PUT_LINE('매 니 저 : ' || v_emp_record.r_mgrname);
    DBMS_OUTPUT.PUT_LINE('부 서 명 : ' || v_emp_record.r_dname);
    DBMS_OUTPUT.PUT_LINE('부서 위치 : ' || v_emp_record.r_loc);
    DBMS_OUTPUT.PUT_LINE('급여 등급 : ' || v_emp_record.r_salgrade);
    
    ------------ 노데이터 예외처리
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN DBMS_OUTPUT.PUT_LINE('해당 직원의 매니저가 없습니다.');
    
END sp_get_emp_info_detail;
/

EXEC sp_get_emp_info_detail(7777)








-- 2. DUP_VAL_ON_INDEX
-- 문제 ) member 테이블에 member_id, member_name 을
--       입력받아서 신규로 1행을 추가하는
--       sp_insert_member 작성

-- 1. 프로시저 작성


------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_insert_memberr
( v_member_id        IN      member.member_id%TYPE
, v_member_name      IN      member.member_name%TYPE)
IS
BEGIN
   INSERT INTO member (member_id, member_name)
   VALUES (v_member_id, v_member_name)
   ;
   commit;
   ----------------
   EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN UPDATE member m
                SET m.member_name = v_member_name
              WHERE m.member_id = v_member_id
              ;
              DBMS_OUTPUT.PUT_LINE(v_member_id||' 가 이미 존재하므로 멤버 정보 수정함');
   
END sp_insert_memberr;
/

EXEC sp_insert_memberr('M13','이주영')

