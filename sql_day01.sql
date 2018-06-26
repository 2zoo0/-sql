-- sql day01
----------------------------------------------------------------------------------------
-- 1. SCOTT 계정 활성화
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
-- 2. 접속 유저 확인 명령
SHOW USER
-- 3. HR 계정 활성화 : SYS 계정으로 접속하여 다른 사용자에서
--                   HR 계정의 계정잠김, 비밀번호 만료 상태 해제
----------------------------------------------------------------------------------------
-- SCOTT 계정의 데이터 구조
-- (1) EMP 테이블 내용 조회

SELECT *
  FROM EMP
;
/*
----------------------------------------------------------------------
EMPNO   ENAME   JOB         MGR     HIREDATE    SAL     COMM    DEPTNO
------- ------- ----------- ------- ----------- ------- ------- ------
7369	SMITH	CLERK	    7902	80/12/17	800		20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7566	JONES	MANAGER	    7839	81/04/02	2975		    20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		    30
7782	CLARK	MANAGER	    7839	81/06/09	2450		    10
7839	KING	PRESIDENT		    81/11/17	5000		    10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7900	JAMES	CLERK	    7698	81/12/03	950		        30
7902	FORD	ANALYST	    7566	81/12/03	3000		    20
7934	MILLER	CLERK	    7782	82/01/23	1300		    10
----------------------------------------------------------------------*/
-- (2) DEPT 테이블 내용 조회
SELECT *
  FROM DEPT
;
/*
----------------------------
DEPTNO  DNAME       LOC
------  ----------  --------
10	    ACCOUNTING	NEW YORK
20	    RESEARCH	DALLAS
30	    SALES	    CHICAGO
40	    OPERATIONS	BOSTON
---------------------------- */

-- (3) SALGRADE 테이블 내용 조회
SELECT *
  FROM SALGRADE
;
/* 
-----------------
GRADE LOSAL HISAL
----- ----- -----
1	  700    1200
2	  1201	 1400
3	  1401	 2000
4	  2001	 3000
5	  3001	 9999
----------------- */

-- 01. DQL
--(1) SELECT 구문
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
  FROM emp e --소문자 e 는 alias(별칭)
;
/*
-------------------------
EMPNO   ENAME   JOB
------- ------- ---------
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK
------------------------- */
