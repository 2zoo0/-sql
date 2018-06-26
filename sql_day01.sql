-- SQL Day01

-- 1. SCOTT 계정 활성화
@C :\ oraclexe \ app \ oracle \ product \ 11.2.0 \ server \ rdbms \ admin \ scott.sql;

-- 2. 접속 유저 확인 명령

SHOW USER

-- 3. HR 계정 활성화 : sys 계정으로 접속하여 다른 사용자 확장 후 HR 계정의 계정잠김, 비밀번호 만료 상태 해제
------------------------------------------------------------------------------------------------------------

-- SCOTT 계정의 데이터 구조
-- (1) EMP 테이블 내용 조회

SELECT
    *
FROM
    emp;

/*-----------------------------------------------------------------
EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
-------------------------------------------------------------------
7369	SMITH	CLERK	    7902	80/12/17	800		        20
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
-------------------------------------------------------------------*/

-- (2) DEPT 테이블 내용 조회

SELECT
    *
FROM
    dept;

/* -----------------------
DEPTNO, DNAME, LOC
--------------------------
 0	ACCOUNTING	NEW YORK
 0	RESEARCH	DALLAS
 0	SALES	    CHICAGO
 0	OPERATIONS	BOSTON
-------------------------*/

-- (3) SALGRADE 테이블 내용 조회

SELECT
    *
FROM
    salgrade;

/* ------------------
GRADE, LOSAL, HISAL
---------------------
 	700	    1200
 	1201	1400
 	1401	2000
 	2001	3000
 	3001	9999
--------------------*/

-- 01. DQL
-- (1) SELECT 구문
--   1) emp 테이블에서 사번, 이름, 직무를 조회

SELECT
    e.empno,
    e.ename,
    e.job
FROM
    emp e -- 소문자 e는 alias(별칭)
    ;

--   2) emp 테이블에서 직무만 조회

SELECT
    e.job
FROM
    emp e;

/*-------
JOB
---------
CLERK
SALESMAN
SALESMAN
MANAGER
SALESMAN
MANAGER
MANAGER
PRESIDENT
SALESMAN
CLERK
ANALYST
CLERK
---------*/

-- (2) DISTINCT문 : SELECT문 사용시 중복을 배제하여 조회
--   3) emp 테이블에서 job 컬럼의 중복을 배제하여 조회

SELECT DISTINCT
    e.job
FROM
    emp e;

/*-------
JOB
---------
CLERK
SALESMAN
PRESIDENT
MANAGER
ANALYST
---------*/

-- * SQL SELECT 구문의 작동 원리 : 테이블의 한 행을 기본 단위로 실행함. 테이블 행의 개수만큼 반복 실행.

SELECT
    'Hello, SQL~'
FROM
    emp e;

/*----------
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
-----------*/

--   4) emp 테이블에서 job, deptno에 대해 중복을 제거하여 조회

SELECT DISTINCT
    e.job,
    e.deptno
FROM
    emp e;

/*----------------
JOB         DEPTNO
------------------
MANAGER	    20
PRESIDENT	10
CLERK	    10
SALESMAN	30
ANALYST	    20
MANAGER 	30
MANAGER 	10
CLERK	    30
CLERK	    20
-------------------*/

-- (3) ORDER BY 절 : 정렬
--   5) emp 테이블에서 job을 중복배제하여 조회하고 결과는 오름차순으로 정렬

SELECT DISTINCT
    e.job
FROM
    emp e
ORDER BY
    e.job ASC;

/*-------
JOB
---------
ANALYST
CLERK
MANAGER
PRESIDENT
SALESMAN
---------*/

--   6) emp 테이블에서 job을 중복배제하여 조회하고 내림차순으로 정렬

SELECT DISTINCT
    e.job
FROM
    emp e
ORDER BY
    e.job DESC;

/*--------
JOB
----------
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST
--------*/

--   7) emp 테이블에서 comm을 가장 많이 받는 순서대로 출력(사번, 이름, 직무, 입사일, 커미션 순으로 조회)

SELECT
    e.empno,
    e.ename,
    e.job,
    e.hiredate,
    e.comm
FROM
    emp e
ORDER BY
    e.comm DESC;

--   8) emp 테이블에서 comm이 적은 순서대로, 직무별 오름차순, 이름별 오름차순으로 정렬(사번, 이름, 직무, 입사일, 커미션을 조회)

SELECT
    e.empno,
    e.ename,
    e.job,
    e.hiredate,
    e.comm
FROM
    emp e
ORDER BY
    e.comm,
    e.job,
    e.ename;

-- 9) emp 테이블에서 comm이 적은 순서대로, 직무별 오름차순, 이름별 내림차순으로 정렬(사번, 이름, 직무, 입사일, 커미션을 조회)

SELECT
    e.empno,
    e.ename,
    e.job,
    e.hiredate,
    e.comm
FROM
    emp e
ORDER BY
    e.comm,
    e.job,
    e.ename DESC;

-- (4) Alias : 별칭
--   10) emp 테이블에서 아래 각 컬럼에 별칭을 풀네임을 주어서 조회
--       empno --> Employee No.
--       ename --> Employee Name.
--       job   --> Job Name

SELECT
    e.empno AS "Employee No.",
    e.ename AS "Employee  Name",
    e.job AS "Job Name"
FROM
    emp e;

-- 11) 10번과 동일 as 키워드 생략하여 조회
--       empno --> Employee No.
--       ename --> Employee Name.
--       job   --> Job Name

SELECT
    e.empno "Employee No.",
    e.ename "Employee  Name",
    e.job "Job Name"
FROM
    emp e;

--     컬럼을 한글로 바꿔서 조회
--     띄어쓰기가 없으면 쌍따옴표가 없어도 된다.
--       empno --> 사번
--       ename --> 사원 이름
--       job   --> 직무

SELECT
    e.empno 사번,
    e.ename "사원 이름",
    e.job "직무"
FROM
    emp e;

-- 12) 테이블에 붙이는 별칭을 주지 않았을 때

SELECT
    empnno
FROM
    emp;

SELECT
    emp.empno
FROM
    emp;

SELECT
    e.empno -- FROM 절에서 설정된 테이블 별칭은 SELECT 절에서 사용됨.
FROM
    emp e -- 소문자 e 가 emp 테이블의 별칭이며 테이블 별칭은 FROM 절에 사용함
    ;

SELECT
    d.deptno
FROM
    dept d;

-- 13) 영문별칭 사용시 특수기호 _ 사용하는 경우

SELECT
    e.empno employee_no -- "가 없으면 대소문자 모두 대문자로 나온다.
   ,
    e.ename "Employee Name"
FROM
    emp e;

-- 14) 별칭과 정렬의 조합 : SELECT절에 별칭을 준경 ORDER 절에서 사용가능
--     emp 테이블에서 사번, 이름, 직무, 입사일, 커미션을 조회할 때
--     각 컬럼에 대해서 한글별칭을 주어 조회
--     정렬은 커미션, 직무, 이름을 오름차순 정렬

SELECT
    e.empno 사번,
    e.ename 이름,
    e.job 직무,
    e.hiredate 입사일,
    e.comm 커미션
FROM
    emp e
ORDER BY
    커미션,
    직무,
    이름;

-- 15) DISTINCT, 별칭, 정렬의 조합
--     job 을 중복을 제거하여 직무 라는 별칭을 조회하고
--     내림차순으로 정렬

SELECT DISTINCT
    e.job 직무
FROM
    emp e
ORDER BY
    직무 DESC;

/*-------
직무
---------
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST
---------*/

-- (5) WHERE 조건절
--  16) emp 테이블에서 empno 가 7900인 사원의
--      사번, 이름, 직무, 입사일, 급여 , 부서번호 조회

SELECT
    e.empno,
    e.ename,
    e.job,
    e.hiredate,
    e.sal,
    e.deptno
FROM
    emp e
WHERE
    e.empno = 7900;
/*----------------------------------------
EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
------------------------------------------
7900	JAMES	CLERK	81/12/03	950	30
------------------------------------------*/

-- 17) emp 테이블에서 empno 는 7900 이거나 deptno 가 20인 직원의 정보를 조회
--     사번, 이름, 직무, 입사일, 급여 , 부서번호 조회

SELECT
    e.empno,
    e.ename,
    e.job,
    e.hiredate,
    e.sal,
    e.deptno
FROM
    emp e
WHERE
    e.empno = 7900
    OR e.deptno = 20;

/*---------------------------------------------
EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
-----------------------------------------------
7369	SMITH	CLERK	80/12/17	800	    20
7566	JONES	MANAGER	81/04/02	2975	20
7900	JAMES	CLERK	81/12/03	950	    30
7902	FORD	ANALYST	81/12/03	3000	20
-----------------------------------------------*/

-- 18) 17의 조회조건을 AND 조건으로 조합
--     empno 가 7900 이고 deptno 가 20 인 직원의 정보를 조회
--     사번, 이름, 직무, 입사일, 급여 , 부서번호 조회

SELECT
    e.empno,
    e.ename,
    e.job,
    e.hiredate,
    e.sal,
    e.deptno
FROM
    emp e
WHERE
    e.empno = 7900
    AND e.deptno = 20;
-- 인출된 모든 행 : 0
/*---------------------------------------------
EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
-----------------------------------------------*/

-- 19) job이 'CLERK' 이면서 deptno 가 10인 직원의 
--     사번, 이름, 직무, 부서번호을 조회
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.DEPTNO
  FROM emp e
 WHERE e.job = 'CLERK' -- 문자값 비교시 '' 사용, 문자값은 대소문자 구분
   AND e.deptnno = 10  -- 숫자값 비교시 따옴표 사용안함
;
    
-- 20) 19번에서 직무 비교 값을 소문자 clerk과 비교하여 결과값 조회
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.DEPTNO
  FROM emp e
 WHERE e.job = 'clerk' -- 문자값 비교시 '' 사용, 문자값은 대소문자 구분
   AND e.DEPTNO = 10  -- 숫자값 비교시 따옴표 사용안함
;

-- 소문자 clerk 으로 저장된 직무는 존재하지 않으므로 조건에 맞는 행이 없음
-- 인출된 모든 행 : 0 결과가 발생함

-- (6) 연산자 1. 산술연산자
--- 21) 사번, 이름, 급여를 조회하고 급여의 3.3% 에 해당하는 원천징수 세금을 계산하여 조회
SELECT e.EMPNO 사번
     , e.ENAME 이름
     , e.SAL 급여
     , e.SAL * 0.033 원천징수세금
     , e.SAL * 0.967 실수령액
  FROM emp e
;
--동일 결과를 내는 다른 계산
SELECT e.EMPNO 사번
     , e.ENAME 이름
     , e.SAL 급여
     , e.SAL * 0.033 원천징수세금
     , e.SAL * (1-0.033) 실수령액
  FROM emp e
;
SELECT e.EMPNO 사번
     , e.ENAME 이름
     , e.SAL 급여
     , e.SAL * 0.033 원천징수세금
     , e.SAL - (e.SAL*0.033) 실수령액
  FROM emp e
;

-- (6) 연산자 2. 비교연산자
--     비교연산자는 SELECT 절에 사용할 수 없음
--     WHERE, HAVING 절에만 사용함

--- 22) 급여가 2000이 넘는 사원의 사번, 이름, 급여를 조회
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL > 2000
   AND 2000 < e.SAL
;

--- 급여가 1000 이상인 직원의 사번, 이름, 급여를 조회
SELECT  e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL >= 1000
;

--- 급여가 1000 이상이며 2000미만인 직원 사번, 이름, 급여를 조회
SELECT  e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL >= 1000
   AND e.SAL < 2000
;

---- comm 값이 0보다 큰 직원의 사번, 이름, 급여를 조회
SELECT  e.EMPNO
     , e.ENAME
     , e.SAL
     , e.COMM
  FROM emp e
 WHERE comm > 0
;
/*
 위의 실행 결과에서 com 이 (null) 인 사람들의 행은
 처음부터 비교대상에 들지 않음에 주의해야 한다.
 (null) 값은 비교연산자로 비교할 수 없는 값이다.
*/

--- 23) 영업사원(SALESMAN) 직무를 가진 사람들은 급여와 수당을 함께 받으므로
--      영업사원의 실제 수령금을 계산해보자
SELECT  e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL +e.COMM "급여 + 수당"
  FROM emp e
;

---------- 집합연산자 ----------
------------------------------
SELECT * 
  FROM dept
 UNION ALL -- 중복값 포함 합집합
SELECT *
  FROM dept
 WHERE deptno = 10
 ;
 SELECT * 
  FROM dept
 UNION -- 중복값 제외 합집합
SELECT *
  FROM dept
 WHERE deptno = 10
 ;
SELECT * 
  FROM dept
 INTERSECT --중복값만 교집합
SELECT *
  FROM dept
 WHERE deptno = 10
 ;
SELECT * 
  FROM dept
 MINUS --중복값 제외 차집합
SELECT *
  FROM dept
 WHERE deptno = 10;
 ------------------------------