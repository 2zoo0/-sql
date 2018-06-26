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
/**/
-- 실습 2)
SELECT e.EMPNO
     , e.ENAME
     , e.HIREDATE
  FROM emp e
 ORDER BY e.HIREDATE
;

-- 실습 3)
SELECT e.EMPNO
     , e.ENAME
     , e.COMM
  FROM emp e
 ORDER BY e.COMM
;

-- 실습 4)
SELECT e.EMPNO
     , e.ENAME
     , e.COMM
  FROM emp e
 ORDER BY e.COMM DESC, 
;

-- 실습 5)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.COMM as "수당"
  FROM emp e
 ORDER BY e.COMM
;

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

-- 실습 8)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.DEPTNO as "부서번호"
  FROM emp e
 WHERE e.DEPTNO = 20 
;

-- 실습 9)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.SAL as "급여"
     , e.DEPTNO as "부서번호"
  FROM emp e
  WHERE e.DEPTNO = 20
    AND SAL <= 3000
;

-- 실습 10)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.SAL + e.COMM as "급여 + 커미션"
  FROM emp e
;
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.SAL + nvl(e.COMM, 0) as "급여 + 커미션"
  FROM emp e
;

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

-- 실습 13)
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.SAL + e.COMM as "급여 + 커미션"
  FROM emp e
 WHERE e.ENAME = 'MARTIN' 
    OR e.ENAME =  'BLAKE'
;
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB as "직책"
     , e.SAL + nvl(e.COMM, 0) as "급여 + 커미션"
  FROM emp e
 WHERE e.ENAME = 'MARTIN' 
    OR e.ENAME =  'BLAKE'
;

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
 WHERE NOT COMM = 0
;
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
 WHERE COMM <> 0
;

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

-- 실습 26)
SELECT  e.EMPNO || ' ' || e.ENAME || '의 월급은 $' || e.SAL || ' 입니다.' as "사번 월급여"
  FROM emp e 
 WHERE e.EMPNO <= (SELECT e.EMPNO FROM emp e WHERE e.ENAME = 'JONES') 
;