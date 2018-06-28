-- lab03 실습문제 작성

-- 실습 15)
SELECT e.EMPNO as "사원번호"
     , UPPER(e.ENAME) as "이름"
     , e.SAL as "급여"
     , TO_CHAR(DECODE(e.JOB,
                     'CLERK', '300',
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
SELECT TRUNC(AVG(e.SAL), 2)
  FROM emp e
; -- AVG(e.SAL) = 1741.66

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
SELECT TRUNC(STDDEV(e.SAL), 2) as "표준편차"
     , TRUNC(VARIANCE(e.SAL), 2) as "분산"
  FROM emp e
;
/*
표준편차, 분산
1285.692790825612578985818541380067131433	1653005.95238095238095238095238095238095
*/

-- 실습 25)
SELECT TRUNC(STDDEV(e.SAL), 2) as "표준편차"
     , TRUNC(VARIANCE(e.SAL), 2) as "분산"
     , e.JOB as "직책"
  FROM emp e
 GROUP BY e.JOB
 HAVING e.JOB = 'SALESMAN'
;
/* 표준편차, 분산, 직책
177.95	31666.66	SALESMAN
*/

-- 실습 26) 


SELECT  e.JOB,
        DECODE(e.JOB, 'CLERK', 300,
                      'SALESMAN'  , 450,
                      'MANAGER'   , 600,
                      'ANALYST'   , 800,
                      'PRESIDENT' , 1000,
                       0) as "자기계발비" ,
        SUM(DECODE(e.JOB, 'CLERK', 300,
                      'SALESMAN'  , 450,
                      'MANAGER'   , 600,
                      'ANALYST'   , 800,
                      'PRESIDENT' , 1000,
                       0)) as "자기계발비 총합"
  FROM emp e
 WHERE e.JOB IS NOT NULL
 GROUP BY e.JOB
;

/* JOB, 자기계발비, 자기계발비총합
--------------------------------
CLERK	    300	    900
SALESMAN	450	    1800
PRESIDENT	1000	1000
MANAGER	    600	    1800
ANALYST 	800 	800
*/

-- 실습 27)
SELECT  e.DEPTNO,
        e.JOB,
        SUM(DECODE(e.JOB, 'CLERK', 300,
                      'SALESMAN'  , 450,
                      'MANAGER'   , 600,
                      'ANALYST'   , 800,
                      'PRESIDENT' , 1000,
                       0)) as "자기계발비 총합"
  FROM emp e
 WHERE e.JOB IS NOT NULL
 GROUP BY e.JOB, e.DEPTNO
 ORDER BY e.DEPTNO ASC, e.JOB DESC
;
/*
DEPTNO, JOB, 자기계발비 총합
---------------------------
10	PRESIDENT	1000
10	MANAGER	     600
10	CLERK	     300
20	MANAGER	     600
20	CLERK	     300
20	ANALYST	     800
30	SALESMAN	1800
30	MANAGER	     600
30	CLERK	     300
*/


-------  JOIN ------
-- 실습 1)
SELECT e.EMPNO,
       e.ENAME, 
       e.JOB, 
       e.MGR, 
       e.HIREDATE,
       e.SAL,
       e.COMM, 
       e.DEPTNO, 
       d.DNAME, 
       d.LOC
  FROM emp e JOIN dept d ON e.DEPTNO = d.DEPTNO
;
/* EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, DNAME, LOC
------------------------------------------------------------------------------------
7369	SMITH	CLERK	    7902	80/12/17	800		20	        RESEARCH	DALLAS
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	 30	    SALES	    CHICAGO
7521	WARD	SALESMAN	7698	81/02/22	1250	500	 30	    SALES	    CHICAGO
7566	JONES	MANAGER	    7839	81/04/02	2975		 20	    RESEARCH	DALLAS
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400 30	    SALES	    CHICAGO
7698	BLAKE	MANAGER 	7839	81/05/01	2850		 30	    SALES	    CHICAGO
7782	CLARK	MANAGER 	7839	81/06/09	2450		 10  	ACCOUNTING	NEW YORK
7839	KING	PRESIDENT		    81/11/17	5000		 10	    ACCOUNTING	NEW YORK
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	 30	    SALES	    CHICAGO
7900	JAMES	CLERK	    7698	81/12/03	950		30	        SALES	    CHICAGO
7902	FORD	ANALYST	    7566	81/12/03	3000		 20	    RESEARCH	DALLAS
7934	MILLER	CLERK	    7782	82/01/23	1300		 10	    ACCOUNTING	NEW YORK
*/

-- 실습 2)
SELECT EMPNO,
       ENAME, 
       JOB, 
       MGR, 
       HIREDATE,
       SAL,
       COMM, 
       DEPTNO, 
       DNAME, 
       LOC
  FROM emp JOIN dept USING(DEPTNO)
;
/* EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, DNAME, LOC
------------------------------------------------------------------------------------
7369	SMITH	CLERK	    7902	80/12/17	800		20	        RESEARCH	DALLAS
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	 30	    SALES	    CHICAGO
7521	WARD	SALESMAN	7698	81/02/22	1250	500	 30	    SALES	    CHICAGO
7566	JONES	MANAGER	    7839	81/04/02	2975		 20	    RESEARCH	DALLAS
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400 30	    SALES	    CHICAGO
7698	BLAKE	MANAGER 	7839	81/05/01	2850		 30	    SALES	    CHICAGO
7782	CLARK	MANAGER 	7839	81/06/09	2450		 10  	ACCOUNTING	NEW YORK
7839	KING	PRESIDENT		    81/11/17	5000		 10	    ACCOUNTING	NEW YORK
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	 30	    SALES	    CHICAGO
7900	JAMES	CLERK	    7698	81/12/03	950		30	        SALES	    CHICAGO
7902	FORD	ANALYST	    7566	81/12/03	3000		 20	    RESEARCH	DALLAS
7934	MILLER	CLERK	    7782	82/01/23	1300		 10	    ACCOUNTING	NEW YORK
*/

-- End --