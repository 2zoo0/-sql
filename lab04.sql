-- 실습문제 4


-- 실습 3)
SELECT e1.EMPNO 사번
     , e1.ENAME 사명
     , e1.MGR 상사번호
     , e2.EMPNO 상사사번
     , e2.ENAME 상사명
  FROM emp e1, emp e2
 WHERE e1.MGR = e2.EMPNO(+)
;
/* 사번, 사명, 상사번호, 상사사번, 상사명
---------------------------------------
7902	FORD	7566	7566	JONES
7900	JAMES	7698	7698	BLAKE
7844	TURNER	7698	7698	BLAKE
7654	MARTIN	7698	7698	BLAKE
7521	WARD	7698	7698	BLAKE
7499	ALLEN	7698	7698	BLAKE
7934	MILLER	7782	7782	CLARK
7782	CLARK	7839	7839	KING
7698	BLAKE	7839	7839	KING
7566	JONES	7839	7839	KING
7369	SMITH	7902	7902	FORD
7777	J%JONES			
8888	J			
9999	J_JUNE			
7839	KING			

*/

-- 실습 4)
SELECT e1.EMPNO 사번
     , e1.ENAME 사명
     , e1.MGR 상사번호
     , e2.EMPNO 상사사번
     , e2.ENAME 상사명
  FROM emp e1 RIGHT OUTER JOIN emp e2
    ON e1.MGR = e2.EMPNO
 ORDER BY e1.EMPNO
;
/* 사번, 사명, 상사번호, 상사사번, 상사명
--------------------------------------
7369	SMITH	7902	7902	FORD
7499	ALLEN	7698	7698	BLAKE
7521	WARD	7698	7698	BLAKE
7566	JONES	7839	7839	KING
7654	MARTIN	7698	7698	BLAKE
7698	BLAKE	7839	7839	KING
7782	CLARK	7839	7839	KING
7844	TURNER	7698	7698	BLAKE
7900	JAMES	7698	7698	BLAKE
7902	FORD	7566	7566	JONES
7934	MILLER	7782	7782	CLARK
  여기부터는부하직원 없음  8888	J
                        7934	MILLER
                        7900	JAMES
                        7844	TURNER
                        7777	J%JONES
                        7654	MARTIN
                        7521	WARD
                        9999	J_JUNE
                        7369	SMITH
                        7499	ALLEN
*/

-- 실습문제 5)
SELECT e.ENAME 
     , e.JOB
  FROM emp e
 WHERE e.JOB = (SELECT e.JOB
                  FROM emp e
                 WHERE e.ENAME = 'JAMES')    
;
/* ENAME, JOB
--------------
SMITH	CLERK
JAMES	CLERK
MILLER	CLERK
J_JUNE	CLERK
J	    CLERK
J%JONES	CLERK
*/
