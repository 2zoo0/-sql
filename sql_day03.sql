-- (3) 단일행 함수
--  6) CASE
--  job별로 경조사비를 급여대비 일정 비율로 지급하고 있다.
--  각 직원들의 경조사비 지원금을 구하자
/*
    CLERK     : 5%
    SALESMAN  : 4%
    MANAGER   : 3.7%
    ANALYST   : 3%
    PRESIDENT : 1.5%
*/

--   1. Simple CASE 구문으로 구해보자 : DECODE와 거의 유사, 동일비교만 가능
--                                      괄호가 없고, 콤마 대신 키워드 WHEN, THEN, ELSE 등을 사용
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , case e.JOB when 'CLERK'     then e.SAL * 0.05
                  when 'SALSEMAN'  then e.SAL * 0.04
                  when 'MANAGER'   then e.SAL * 0.037
                  when 'ANALYST'   then e.SAL * 0.03
                  when 'PRESIDENT' then e.SAL * 0.015
        end as "경조사 지원금"
  FROM emp e
;

--   2. Searched CASE 구문으로 구해보자
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , CASE WHEN e.JOB = 'CLERK'     THEN e.SAL * 0.05
            WHEN e.JOB = 'SALESMAN'  THEN e.SAL * 0.04
            WHEN e.JOB = 'MANAGER'   THEN e.SAL * 0.037
            WHEN e.JOB = 'ANALYST'   THEN e.SAL * 0.03
            WHEN e.JOB = 'PRESIDENT' THEN e.SAL * 0.015
            ELSE 10
        END as "경조사 지원금"
  FROM emp e
;

--  CASE 결과에 숫자 통화 패턴 씌우기 : $기호
SELECT e.EMPNO
     , e.ENAME
     , nvl(e.JOB, '미지정') as "JOB"
     , TO_CHAR(CASE WHEN e.JOB = 'CLERK'     THEN e.SAL * 0.05
                    WHEN e.JOB = 'SALESMAN'  THEN e.SAL * 0.04
                    WHEN e.JOB = 'MANAGER'   THEN e.SAL * 0.037
                    WHEN e.JOB = 'ANALYST'   THEN e.SAL * 0.03
                    WHEN e.JOB = 'PRESIDENT' THEN e.SAL * 0.015
                    ELSE 10
                END, '$9,999.99') as "경조사 지원금"
  FROM emp e
;

/* SALGRADE 테이블의 내용 : 이 회사의 급여 등급 기준 값
GRADE, LOSAL, HISAL
---------------------
1	     700 	1200
2	    1201	1400
3	    1401	2000
4	    2001	3000
5	    3001	9999
--------------------*/

--  제공되는 급여 등급을 바탕으로 각 직원들의 급여 등급을 구해보자
--  CASE를 사용하여
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
     , CASE WHEN e.SAL >= 700 AND e.SAL <= 1200 THEN 1
            WHEN e.SAL > 1200 AND e.SAL <= 1400 THEN 2
            WHEN e.SAL > 1400 AND e.SAL <= 2000 THEN 3
            WHEN e.SAL > 2000 AND e.SAL <= 3000 THEN 4
            WHEN e.SAL > 3000 AND e.SAL <= 9999 THEN 5
            ELSE 0
        END as "급여 등급"
  FROM emp e
 ORDER BY "급여 등급" DESC
;

--  WHEN안의 구문을 BETWEEN ~ AND ~으로 변경하여 작성
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
     , CASE WHEN e.SAL BETWEEN  700 AND 1200 THEN 1
            WHEN e.SAL BETWEEN 1201 AND 1400 THEN 2
            WHEN e.SAL BETWEEN 1401 AND 2000 THEN 3
            WHEN e.SAL BETWEEN 2001 AND 3000 THEN 4
            WHEN e.SAL BETWEEN 3001 AND 9999 THEN 5
            ELSE 0
        END as "급여 등급"
  FROM emp e
 ORDER BY "급여 등급" DESC
;

---------- 2. 그룹함수 (복수행 함수)
-- 1) COUNT(*) : 특징 테이빌의 행의 개수(데이터의 개수)를 세어주는 함수
--               NULL 을 처리하는 <유일한 그룹함수>

--  COUNT(expr) : expr 으로 등장한 값을 NULL 제외하고 세어주는 함수

--dept, salgrade 테이블의 전체 데이터 개수 조회
SELECT *
  FROM dept d
;

SELECT COUNT(*) as "부서개수"
  FROM dept d
; -- 부서개수 = 4
/* DEPTNO, DNAME, LOC
-------------------------
10	ACCOUNTING	NEW YORK  ====>
20	RESEARCH	DALLAS    ====>   COUNT(*) = 4
30	SALES	CHICAGO       ====>
40	OPERATIONS	BOSTON    ====>
*/

SELECT *
  FROM dept d
;

SELECT COUNT(*) as "급여 등급 개수"
  FROM salgrade s
; -- 급여 등급 개수 = 5

/* DEPTNO, DNAME, LOC
-------------------------
10	ACCOUNTING	NEW YORK ====>
20	RESEARCH	DALLAS   ====>  COUNT(*) = 5
30	SALES	CHICAGO      ====>
40	OPERATIONS	BOSTON   ====>
*/

--- emp 테이블에서 job 컬럼의 데이터 개수를 세어보자
SELECT COUNT(DISTINCT e.JOB) as "직책 종류 수"
  FROM emp e
;

SELECT e.EMPNO
     , e.ENAME
     , e.JOB
  FROM emp e
;
/* EMPNO, ENAME, JOB
-------------------------
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
6666	JJ	
7777	J%JONES	
8888	J	
9999	J_JUNE	
*/

-- 회사에 매니저가 배정된 직원이 몇명인가
SELECT e.EMPNO
     , e.ENAME
     , e.MGR
  FROM emp e
;
/*
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
6666	JJ	
7777	J%JONES	
8888	J	
9999	J_JUNE	
*/
SELECT COUNT(e.MGR) as "상사가 있는 직원 수"
  FROM emp e
;

-- 매니저 직을 맡고 있는 직원이 몇명인가
--- 1. mgr 컬럼을 중복제거 하여 조회
SELECT DISTINCT e.MGR
  FROM emp e
;
--- 2. 그때의 결과를 카운트
SELECT COUNT(DISTINCT e.MGR) as "매니저 직원 직원수"
  FROM emp e
;

-- 부서가 배정된 직원이 몇명이나 있는가
SELECT DISTINCT e.DEPTNO
  FROM emp e
;

-- COUNT(*) 가 아닌 COUNT(expr) 을 사용한 경우에는
SELECT e.DEPTNO
  FROM emp E
 WHERE e.DEPTNO IS NOT NULL
;
-- 을 수행한 결과를 카운트 한 것으로 생각할 수 있다.

SELECT COUNT(e.DEPTNO) as "부서 배정 인원"
     , COUNT(*) -COUNT(e.DEPTNO) as "부서 미배정 인원"
     , COUNT(*) as "전체 인원"
  FROM emp e
;


--2) SUM() : NULL 항목 제외하고
--           합산 가능한 행을 모두 더한 결과를 출력
-- SALESMAN 들의 수당 총합을 구해보자
SELECT SUM(e.COMM) as "SUM of SALESMAN"
  FROM emp e
 WHERE e.JOB = 'SALESMAN'
;
/*
(null)
300     ====>
500     ====>
(null)
1400    ====> SUM(e.COMM) ====> 2200 : comm 컬럼이 NUL인 것들은 합산에서 제외
(null)
(null)
(null)
0       ====>
(null)
(null)
(null)
(null)
(null)
(null)
(null)
*/

-- 수당총합 결과에 숫자 출력 패턴, 별칭
SELECT TO_CHAR(SUM(e.COMM), '$99,999') as "수당총합"
  FROM emp e
 WHERE e.JOB = 'SALESMAN'
;

-- 3) AVG(expr) : NULL 값 제외하고 연산 가능한 항목의 산술 평균을 구함

--  수당 평균을 구해보자
SELECT AVG(e.COMM) as "수당 평균"
  FROM emp e
;
SELECT TO_CHAR(AVG(e.COMM), '999') as "수당 평균"
  FROM emp e
;

-- 4) MAX(expr) : expr에 등장한 값 중 최대값을 구함
--                expr 이 문자인 경우 알파벳순 뒷쪽에 위치한 글자를 최댓값으로 계산

-- 이름이 가장 나중인 직원
SELECT MAX(e.ENAME)
  FROM emp e
;
-------- 3. GROUP BY 절의 사용
-- 1) emp 테이블에서 각 부서별로 급여의 총합을 조회

--    총합을 구하기 위하여 SUM()을 사용
--    그룹화 기준을 부서번호(deptno)를 사용
--    그룹화 기준으로 잡은 부서번호가 GROUP BY 절에 등장해야 함

-- a) 먼저 emp 테이블에서 급여 총합 구하는 구문을 작성
SELECT SUM(e.SAL)
  FROM emp e
;

 -- b) 부서번호를 기준으로 그룹화를 진행
 --    SUM()은 그룹함수이므로 GROUP BY 절을 조합하면 그룹화 가능
 --    그룹화를 하려면 기준 컬럼을 GROUP BY 절에 명시
 
SELECT e.DEPTNO
   --, e.JOB ORA-00979: not a GROUP BY expression
     , SUM(e.SAL) as "급여 총합"
  FROM emp e
 GROUP BY e.DEPTNO
;
SELECT d.DNAME as "부서명"
     , SUM(e.SAL) as "급여 총합"
  FROM emp e, dept d
 WHERE e.DEPTNO = d.DEPTNO
 GROUP BY e.DEPTNO, d.DNAME
; -- 조인으로 부서명 출력
 
-- 부서별 급여의 총합, 평균, 최대급여, 최소급여를 구하자
SELECT SUM(e.SAL) as "급여 총합"
     , AVG(e.SAL) as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO
;
SELECT SUM(e.SAL) as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '$999,999.99') as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO
 ORDER BY e.DEPTNO
;
-- 위의 쿼리는 수행되지만 정확하게 어느 부서의 결과인지
-- 알 수가 없다는 단점이 존재
/* ---------------------------------------------------------------------------
  GROUP BY 절에 등장하는 그룹화 기준 컬럼은 반드시 SELECT 절에 똑같이 등장해야 한다.
  
  하지만 위의 쿼리가 실행되는 이유는 
  SELECT 절에 나열된 컬럼 중에서 그룹 함수가 사용되지 않은 컬럼이 없기 때문
  즉, 모두 다 그룹함수가 사용된 컬럼들이기 때문
------------------------------------------------------------------------------ */

-- 부서 지정 안되어서 (null) 로 표현되는 값을 "부서 미지정" 으로 출력되도록

SELECT nvl(e.DEPTNO, '0') as "부서번호"
     , SUM(e.SAL) as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '$999,999.99') as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO
;

-- 부서, 직무별 급여의 총합, 평균, 최대급여, 최소급여를 구하자
SELECT e.DEPTNO when e.DEPTNO is null then e.DEPTNO = '부서없음'
     , e.JOB    as "직무"
     , SUM(e.SAL) as "급여 총합"
     , AVG(e.SAL) as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO, e.JOB
-- WHERE e.DEPTNO IS NOT NULL
;
-- GROUP BY 절에 없는 것이 SELECT 절에 나오면 오류
-- GROUP BY 절에 있는 것이 SELECT 절에 없으면 오류





-- job 별 급여의 총합, 평균, 최대, 최소 를 구해보자
SELECT nvl(e.JOB, '직무없음')    as "직무"
     , TO_CHAR(SUM(e.SAL), '$999,999') as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '$999,999.99') as "급여 평균"
     , TO_CHAR(MAX(e.SAL), '$999,999') as "최대 급여"
     , TO_CHAR(MIN(e.SAL), '$999,999') as "최소 급여"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY e.JOB
 ;