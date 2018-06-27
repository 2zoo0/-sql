-- lab02 실습문제 작성


-- 실습 23)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e 
 WHERE e.SAL BETWEEN 2500 AND 3000
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7566	JONES	MANAGER	7839	81/04/02	2975		20
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7902	FORD	ANALYST	7566	81/12/03	3000		20
*/

-- 실습 24)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e 
 WHERE e.COMM IS NULL
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7369	SMITH	CLERK	7902	80/12/17	800		20
7566	JONES	MANAGER	7839	81/04/02	2975		20
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7782	CLARK	MANAGER	7839	81/06/09	2450		10
7839	KING	PRESIDENT		81/11/17	5000		10
7900	JAMES	CLERK	7698	81/12/03	950		30
7902	FORD	ANALYST	7566	81/12/03	3000		20
7934	MILLER	CLERK	7782	82/01/23	1300		10
*/

-- 실습 25)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e 
 WHERE e.COMM IS NOT NULL
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	 30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	 30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400 30
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	 30
*/

-- 실습 26)

SELECT  e.EMPNO as "사번", ' ' || e.ENAME || '의 월급은 $' || e.SAL || ' 입니다.' as "사번 월급여"
  FROM emp e 
;
/* 사번 월급여
7369	 SMITH의 월급은 $800 입니다.
7499	 ALLEN의 월급은 $1600 입니다.
7521	 WARD의 월급은 $1250 입니다.
7566	 JONES의 월급은 $2975 입니다.
7654	 MARTIN의 월급은 $1250 입니다.
7698	 BLAKE의 월급은 $2850 입니다.
7782	 CLARK의 월급은 $2450 입니다.
7839	 KING의 월급은 $5000 입니다.
7844	 TURNER의 월급은 $1500 입니다.
7900	 JAMES의 월급은 $950 입니다.
7902	 FORD의 월급은 $3000 입니다.
7934	 MILLER의 월급은 $1300 입니다.
9999	 J_JUNE의 월급은 $500 입니다.
8888	 J의 월급은 $400 입니다.
7777	 J%JONES의 월급은 $300 입니다.
*/

-------------------------------------------------------------------------
-------------------------------------------------------------------------

--- 실습 1) 
SELECT INITCAP(e.ENAME) as "INITCAP ENAME" 
  FROM emp e
;

/*
INITCAP ENAME
-------------
Smith
Allen
Ward
Jones
Martin
Blake
Clark
King
Turner
James
Ford
Miller
J_June
J
J%Jones
*/

-- 실습 2)
SELECT LOWER(e.ENAME) as "lower ename" 
  FROM emp e
;
/* lower ename
-------------
smith
allen
ward
jones
martin
blake
clark
king
turner
james
ford
miller
j_june
j
j%jones
*/

-- 실습 3)
SELECT UPPER(e.ENAME) as "CAPITAL ENAME" 
  FROM emp e
;
/* CAPITAL ENAME
----------------
SMITH
ALLEN
WARD
JONES
MARTIN
BLAKE
CLARK
KING
TURNER
JAMES
FORD
MILLER
J_JUNE
J
J%JONES
*/

-- 실습 4) 
-- 1.
SELECT LENGTH('korea') as "문자열길이"
  FROM dual
; 
-- 문자열 길이 = 5

-- 2.
SELECT LENGTHB('korea') as "바이트 길이"
  FROM dual
; 
--  바이트 길이 = 5 
--영어는 둘 다 같음

-- 실습 4) 
-- 1.
SELECT LENGTH('이주영') as "문자열 길이"
  FROM dual
; 
-- 문자열 길이 = 3

-- 2.
SELECT LENGTHB('이주영') as "바이트 길이"
  FROM dual
; 
-- 바이트 길이 = 9
--한글은 글자당 3

-- 실습 6)
SELECT concat('SQL', '배우기') as "concat"
  FROM dual
; 

-- 실습 7)
SELECT substr('SQL 배우기', 5, 2) as "substr"
  FROM dual
; 

-- 실습 8)
SELECT lpad('SQL', 7, '$')  as "lpad"
  FROM dual
; 
-- $$$$SQL

-- 실습 9)
SELECT rpad('SQL', 7, '$')  as "rpad"
  FROM dual
;
-- SQL$$$$

-- 실습 10)
SELECT ltrim('      SQL 배우기  ') as "ltrim"
  FROM dual
;

-- 실습 11)
SELECT rtrim('      SQL 배우기  ') as "rtrim"
  FROM dual
;

-- 실습 12)
SELECT trim('      SQL 배우기  ') as "trim"
  FROM dual
;

-- 실습 13)
SELECT e.EMPNO
     , e.ENAME
     , nvl(e.COMM, 0) as "COMM"
  FROM emp e
;
/*EMPNO, ENAME, COMM 
----------------------
7369	SMITH	0
7499	ALLEN	300
7521	WARD	500
7566	JONES	0
7654	MARTIN	1400
7698	BLAKE	0
7782	CLARK	0
7839	KING	0
7844	TURNER	0
7900	JAMES	0
7902	FORD	0
7934	MILLER	0
9999	J_JUNE	0
8888	J	0
7777	J%JONES	0
*/
-- 실습 14)
SELECT e.EMPNO
     , e.ENAME
     , nvl2(e.COMM, e.SAL+e.COMM, 0) as "SAL + COMM"
  FROM emp e
;
/* EMPNO, ENAME, SAL + COMM
----------------------------
7369	SMITH	0
7499	ALLEN	1900
7521	WARD	1750
7566	JONES	0
7654	MARTIN	2650
7698	BLAKE	0
7782	CLARK	0
7839	KING	0
7844	TURNER	1500
7900	JAMES	0
7902	FORD	0
7934	MILLER	0
9999	J_JUNE	0
8888	J	0
7777	J%JONES	0
*/
-- 실습 15)
SELECT e.EMPNO as "사원번호"
     , UPPER(e.ENAME) as "이름"
     , e.SAL as "급여"
     , TO_CHAR(DECODE(e.JOB, 'CLERK', '300',
                     'SALESMAN', '450',
                     'MANAGER', '600',
                     'ANALYST', '800',
                     'PRESIDENT', '1000'), '$999999') as "자기계발비"
  FROM emp e
;

/* 사원번호, 이름, 급여, 자기계발비
---------------------------------
7369	SMITH	800	    $300
7499	ALLEN	1600    $450
7521	WARD	1250    $450
7566	JONES	2975    $600
7654	MARTIN	1250    $450
7698	BLAKE	2850    $600
7782	CLARK	2450    $600
7839	KING	5000   $1000
7844	TURNER	1500	$450
7900	JAMES	950	    $300
7902	FORD	3000	$800
7934	MILLER	1300	$300
9999	J_JUNE	500	    $300
8888	J	    400	    $300
7777	J%JONES	300	    $300
*/

-- 실습 16)
SELECT e.EMPNO as "사원번호"
     , UPPER(e.ENAME) as "이름"
     , e.SAL as "급여"
     , TO_CHAR((CASE e.JOB WHEN 'CLERK'     THEN 300
                           WHEN 'SALESMAN'  THEN 450
                           WHEN 'MANAGER'   THEN 600
                           WHEN 'ANALYST'   THEN 800
                           WHEN 'PRESIDENT' THEN 1000
                           ELSE 0
                 END), '$999999') as "자기계발비"
  FROM emp e
;
/* 사원번호, 이름, 급여, 자기계발비
---------------------------------
7369	SMITH	800	    $300
7499	ALLEN	1600    $450
7521	WARD	1250    $450
7566	JONES	2975    $600
7654	MARTIN	1250    $450
7698	BLAKE	2850    $600
7782	CLARK	2450    $600
7839	KING	5000   $1000
7844	TURNER	1500	$450
7900	JAMES	950	    $300
7902	FORD	3000	$800
7934	MILLER	1300	$300
9999	J_JUNE	500	    $300
8888	J	    400	    $300
7777	J%JONES	300	    $300
*/

-- 실습 17)
SELECT e.EMPNO as "사원번호"
     , UPPER(e.ENAME) as "이름"
     , e.SAL as "급여"
     , TO_CHAR((CASE  WHEN e.JOB = 'CLERK'     THEN 300
                      WHEN e.JOB = 'SALESMAN'  THEN 450
                      WHEN e.JOB = 'MANAGER'   THEN 600
                      WHEN e.JOB = 'ANALYST'   THEN 800
                      WHEN e.JOB = 'PRESIDENT' THEN 1000
                      ELSE 0
                      END), '$999999') as "자기계발비"
  FROM emp e
;
/* 사원번호, 이름, 급여, 자기계발비
---------------------------------
7369	SMITH	800	    $300
7499	ALLEN	1600    $450
7521	WARD	1250    $450
7566	JONES	2975    $600
7654	MARTIN	1250    $450
7698	BLAKE	2850    $600
7782	CLARK	2450    $600
7839	KING	5000   $1000
7844	TURNER	1500	$450
7900	JAMES	950	    $300
7902	FORD	3000	$800
7934	MILLER	1300	$300
9999	J_JUNE	500	    $300
8888	J	    400	    $300
7777	J%JONES	300	    $300
*/

-- 실습 18)
SELECT COUNT(*)
  FROM emp
; -- COUNT(*) = 15

-- 실습 19)
SELECT  COUNT(DISTINCT e.JOB)
  FROM emp e
; --  COUNT(DISTINCT e.JOB) = 5

-- 실습 20)
SELECT  COUNT(*)
  FROM emp e
 WHERE COMM IS NOT NULL
; -- COUNT(*) = 4

-- 실습 21)
SELECT SUM(e.SAL)
  FROM emp e
; -- SUM(e.SAL) = 26125

-- 실습 22)
SELECT AVG(e.SAL)
  FROM emp e
; -- AVG(e.SAL) = 1741.666666666666666666666666666666666667

-- 실습 23)
SELECT nvl(e.DEPTNO || '', '부서없음') as "부서번호"
     , SUM(e.SAL) as "총합"
     , TRUNC(AVG(e.SAL), 2) as "평균"
     , MAX(e.SAL) as "최대"
     , MIN(e.SAL) as "최소"
  FROM emp e
 GROUP BY e.DEPTNO
;
/*부서번호, 총합, 평균, 최대, 최소
--------------------------------
30	    9400	1566.66	2850	950
부서없음	1200	400	    500	    300
20	    6775	2258.33	3000	800
10	    8750	2916.66	5000	1300
*/

-- 실습 24)
SELECT STDDEV(e.SAL) as "표준편차"
     , VARIANCE(e.SAL) as "분산"
  FROM emp e
;
/*
표준편차, 분산
1285.692790825612578985818541380067131433	1653005.95238095238095238095238095238095
*/

-- 실습 25)
SELECT STDDEV(e.SAL) as "표준편차"
     , VARIANCE(e.SAL) as "분산"
     , e.JOB as "직책"
  FROM emp e
 GROUP BY e.JOB
 HAVING e.JOB = 'SALESMAN'
;
/* 표준편차, 분산, 직책
177.951304200521853513525399426595177105	31666.6666666666666666666666666666666667	SALESMAN
*/