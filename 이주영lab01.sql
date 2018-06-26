-- 실습문제
-- EMP| EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO

-- 실습 1) 
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL
  FROM emp e
 ORDER BY SAL DESC
;
/*
EMPNO, ENAME, JOB, SAL
--------------------------------
7839	KING	PRESIDENT	5000
7902	FORD	ANALYST	    3000
7566	JONES	MANAGER	    2975
7698	BLAKE	MANAGER	    2850
7782	CLARK	MANAGER	    2450
7499	ALLEN	SALESMAN	1600
7844	TURNER	SALESMAN	1500
7934	MILLER	CLERK	    1300
7654	MARTIN	SALESMAN	1250
7521	WARD	SALESMAN	1250
7900	JAMES	CLERK	    950
7369	SMITH	CLERK	    800
*/

-- 실습 2)
SELECT e.EMPNO
     , e.ENAME
     , e.HIREDATE
  FROM emp e
 ORDER BY e.HIREDATE
;
/*
EMPNO, ENAME, HIREDATE
------------------------
7369	SMITH	80/12/17
7499	ALLEN	81/02/20
7521	WARD	81/02/22
7566	JONES	81/04/02
7698	BLAKE	81/05/01
7782	CLARK	81/06/09
7844	TURNER	81/09/08
7654	MARTIN	81/09/28
7839	KING	81/11/17
7900	JAMES	81/12/03
7902	FORD	81/12/03
7934	MILLER	82/01/23*/

-- 실습 3)
SELECT e.EMPNO
     , e.ENAME
     , e.COMM
  FROM emp e
 ORDER BY e.COMM
;
/*
EMPNO, ENAME, COMM
---------------------
7844	TURNER	0
7499	ALLEN	300
7521	WARD	500
7654	MARTIN	1400
7839	KING	
7900	JAMES	
7902	FORD	
7782	CLARK	
7934	MILLER	
7566	JONES	
7369	SMITH	
7698	BLAKE	*/

-- 실습 4)
SELECT e.EMPNO
     , e.ENAME
     , e.COMM
  FROM emp e
 ORDER BY e.COMM DESC
;
/*EMPNO, ENAME, COMM
---------------------
7369	SMITH	
7698	BLAKE	
7902	FORD	
7900	JAMES	
7839	KING	
7566	JONES	
7934	MILLER	
7782	CLARK	
7654	MARTIN	1400
7521	WARD	500
7499	ALLEN	300
7844	TURNER	0*/

-- 실습 5)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.COMM as "수당"
  FROM emp e
 ORDER BY e.COMM
;
/*
사번, 이름, 수당
---------------------
7844	TURNER	0
7499	ALLEN	300
7521	WARD	500
7654	MARTIN	1400
7839	KING	
7900	JAMES	
7902	FORD	
7782	CLARK	
7934	MILLER	
7566	JONES	
7369	SMITH	
7698	BLAKE	*/

-- 실습 6)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e
;
/*
사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
---------------------------------------------------------------------
7369	SMITH	CLERK	    7902	80/12/17	800		20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	 30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	 30
7566	JONES	MANAGER	    7839	81/04/02	2975		 20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400 30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		 30
7782	CLARK	MANAGER	    7839	81/06/09	2450		 10
7839	KING	PRESIDENT		    81/11/17	5000		 10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	 30
7900	JAMES	CLERK	    7698	81/12/03	950		30
7902	FORD	ANALYST	    7566	81/12/03	3000		 20
7934	MILLER	CLERK	    7782	82/01/23	1300		 10*/

-- 실습 7)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e
 WHERE e.ENAME = 'ALLEN'
;
/*
사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
--------------------------------------------------------------
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
*/

-- 실습 8)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.DEPTNO as "부서번호"
  FROM emp e
 WHERE e.DEPTNO = 20 
;
/*
사번, 이름, 부서번호
-------------------
7369	SMITH	20
7566	JONES	20
7902	FORD	20
*/

-- 실습 9)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.SAL as "급여"
     , e.DEPTNO as "부서번호"
  FROM emp e
  WHERE e.DEPTNO = 20
    AND SAL <= 3000
;
/*
사번, 이름, 급여, 부서번호
---------------------------
7369	SMITH	800 	20
7566	JONES	2975	20
7902	FORD	3000	20
*/

-- 실습 10)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.SAL + e.COMM as "급여 + 커미션"
  FROM emp e
;
/*
7369	SMITH	
7499	ALLEN	1900
7521	WARD	1750
7566	JONES	
7654	MARTIN	2650
7698	BLAKE	
7782	CLARK	
7839	KING	
7844	TURNER	1500
7900	JAMES	
7902	FORD	
7934	MILLER	
*/
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.SAL + nvl(e.COMM, 0) as "급여 + 커미션"
  FROM emp e
;
/*
7369	SMITH	800
7499	ALLEN	1900
7521	WARD	1750
7566	JONES	2975
7654	MARTIN	2650
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7844	TURNER	1500
7900	JAMES	950
7902	FORD	3000
7934	MILLER	1300
*/
-- 실습 11)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.SAL * 12 as "년급여"
  FROM emp e
;

-- 실습 12)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.SAL as "급여"
     , e.COMM as "커미션"
  FROM emp e
 WHERE e.ENAME = 'MARTIN' 
    OR e.ENAME =  'BLAKE'
;
/* 사번, 이름, 직책, 급여, 커미션
7654	MARTIN	SALESMAN	1250	1400
7698	BLAKE	MANAGER	    2850	
*/

-- 실습 13)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.SAL + e.COMM as "급여 + 커미션"
  FROM emp e
 WHERE e.ENAME = 'MARTIN' 
    OR e.ENAME =  'BLAKE'
;
/*
사번, 이름, 직책, 급여 + 커미션
7654	MARTIN	SALESMAN	2650
7698	BLAKE	MANAGER	
*/
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.SAL + nvl(e.COMM, 0) as "급여 + 커미션"
  FROM emp e
 WHERE e.ENAME = 'MARTIN' 
    OR e.ENAME =  'BLAKE'
;
/* 사번, 이름, 직책, 급여 + 커미션
7654	MARTIN	SALESMAN	2650
7698	BLAKE	MANAGER 	2850
*/

-- 실습 14) 
-- 1
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e
 WHERE COMM != 0
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	 30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	 30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400 30
*/
-- 2
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e
 WHERE COMM > 0
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	 30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	 30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400 30
*/
--3
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e
 WHERE COMM >= 0
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	 30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	 30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400 30
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	 30
*/

-- 실습 15)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e
 WHERE COMM IS NOT NULL
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	 30
7521	WARD	SALESMAN	7698	81/02/22	1250	500  30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400 30
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	 30
*/

-- 실습 16)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e 
 WHERE e.DEPTNO = 20
   AND SAL >= 2500
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7566	JONES	MANAGER	7839	81/04/02	2975		20
7902	FORD	ANALYST	7566	81/12/03	3000		20
*/

-- 실습 17)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e 
 WHERE e.JOB = 'MANAGER'
    OR e.DEPTNO = 10
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7566	JONES	MANAGER	7839	81/04/02	2975		20
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7782	CLARK	MANAGER	7839	81/06/09	2450		10
7839	KING	PRESIDENT		81/11/17	5000		10
7934	MILLER	CLERK	7782	82/01/23	1300		10
*/

-- 실습 18)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e 
 WHERE e.JOB IN('MANAGER', 'CLERK', 'SALESMAN')
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7369	SMITH	CLERK	 7902	80/12/17	800		20
7499	ALLEN	SALESMAN 7698	81/02/20	1600	300	 30
7521	WARD	SALESMAN 7698	81/02/22	1250	500	 30
7566	JONES	MANAGER	 7839	81/04/02	2975		 20
7654	MARTIN	SALESMAN 7698	81/09/28	1250	1400 30
7698	BLAKE	MANAGER	 7839	81/05/01	2850		 30
7782	CLARK	MANAGER	 7839	81/06/09	2450		 10
7844	TURNER	SALESMAN 7698	81/09/08	1500	0	 30
7900	JAMES	CLERK	 7698	81/12/03	950		30
7934	MILLER	CLERK	 7782	82/01/23	1300		 10
*/

-- 실습 19)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e 
 WHERE e.ENAME LIKE 'A%'
;
/*사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
*/
-- 실습 20)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e 
 WHERE e.ENAME LIKE '%A%'
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7499	ALLEN	SALESMAN 7698	81/02/20	1600	300	 30
7521	WARD	SALESMAN 7698	81/02/22	1250	500	 30
7654	MARTIN	SALESMAN 7698	81/09/28	1250	1400 30
7698	BLAKE	MANAGER	 7839	81/05/01	2850		 30
7782	CLARK	MANAGER	 7839	81/06/09	2450		 10
7900	JAMES	CLERK	 7698	81/12/03	950		30
*/

-- 실습 21)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e 
 WHERE e.ENAME LIKE '%S'
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7566	JONES	MANAGER	7839	81/04/02	2975	20
7900	JAMES	CLERK	7698	81/12/03	950		30
*/

-- 실습 22)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.MGR as "상관"
     , e.HIREDATE as "입사일"
     , e.SAL as "급여"
     , e.COMM as "수당"
     , e.DEPTNO as "부서번호"
  FROM emp e 
 WHERE e.ENAME LIKE '%E_'
;
/* 사번, 이름, 직책, 상관, 입사일, 급여, 수당, 부서번호
7499	ALLEN	SALESMAN 7698	81/02/20	1600	300	30
7566	JONES	MANAGER	 7839	81/04/02	2975		20
7844	TURNER	SALESMAN 7698	81/09/08	1500	0	30
7900	JAMES	CLERK	 7698	81/12/03	950		30
7934	MILLER	CLERK	 7782	82/01/23	1300		10
*/

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
SELECT  e.EMPNO || ' ' || e.ENAME || '의 월급은 $' || e.SAL || ' 입니다.' as "사번 월급여"
  FROM emp e 
 WHERE e.EMPNO <= (SELECT e.EMPNO FROM emp e WHERE e.ENAME = 'JONES') 
;
/* 사번 월급여
7369 SMITH의 월급은 $800 입니다.
7499 ALLEN의 월급은 $1600 입니다.
7521 WARD의 월급은 $1250 입니다.
7566 JONES의 월급은 $2975 입니다.
*/