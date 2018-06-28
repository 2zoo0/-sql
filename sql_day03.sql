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

--   3. GROUP BY절의 사용
--  1) emp테이블에서 각 부서별로 급여의 총합을 조회

--    총합을 구하기 위하여 SUM()을 사용
--    그룹화 기준을 부서번호(deptno)를 사용
--    그룹화 기준으로 잡은 부서번호가 GROUP BY절에 등장해야 함

--  a) 먼저 emp테이블에서 급여 총합 구하는 구문을 작성
SELECT SUM(e.SAL)
  FROM emp e
;

--  b) 부서번호(deptno)를 기준으로 그룹화를 진행
--     SUM()은 그룹함수이므로 GROUP BY절을 조합하면 그룹화 가능
--     그룹화를 하려면 기준 컬럼을 GROUP BY절에 명시
SELECT e.DEPTNO
     , SUM(e.SAL) as "급여 총합"
  FROM emp e
 GROUP BY e.DEPTNO
;

--  GROUP BY절에 등장하지 않은 컬럼이 SELECT절에 등장하면 오류, 실행 불가
SELECT e.DEPTNO, e.JOB -- e.JOB은 GROUP BY절에 등장 안해서 오류
     , SUM(e.SAL) as "급여 총합"
  FROM emp e
 GROUP BY e.DEPTNO
;
--  ORA-00979: not a GROUP BY expression

--  부서별 급여의 총합, 평균, 최대급여, 최소급여를 구하자
SELECT SUM(e.SAL) as "급여 총합"
     , AVG(e.SAL) as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO
;
-- 위의 쿼리는 수행되지만 정확하게 어느 부서의 결과인지 알 수가 없다는 단점이 존재
/*-------------------------------------------------------------------------------------
   GROUP BY절에 등장하는 그룹화 기준 컬럼은 반드시 SELECT절에 똑같이 등장해야 한다.
   
   하지만 위의 쿼리가 실행되는 이유는
   SELECT절에 나열된 컬럼 중에서 그룹함수가 사용되지 않은 컬럼이 없기 때문
   즉, 모두 다 그룹함수가 사용된 컬럼들이기 때문
-------------------------------------------------------------------------------------*/

--  결과 숫자 패턴 씌우기, ORDER BY로 정렬
SELECT e.DEPTNO as "부서 번호"
     , TO_CHAR(SUM(e.SAL), '9,999.00') as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '9,999.00') as "급여 평균"
     , TO_CHAR(MAX(e.SAL), '9,999.00') as "최대 급여"
     , TO_CHAR(MIN(e.SAL), '9,999.00') as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO
 ORDER BY e.DEPTNO
;

--  부서별, 직무별 급여의 총합, 평균, 최대, 최소를 구해보자
SELECT e.DEPTNO                      as "부서 번호"
     , e.JOB                         as "직무"
     , TO_CHAR(SUM(e.SAL), '$9,999') as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '$9,999') as "급여 평균"
     , TO_CHAR(MAX(e.SAL), '$9,999') as "최대 급여"
     , TO_CHAR(MIN(e.SAL), '$9,999') as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO, e.JOB
 ORDER BY e.DEPTNO, e.JOB
;

-- 오류코드 ORA-00979: not a GROUP BY expression
SELECT e.DEPTNO   as "부서 번호"
     , e.JOB      as "직무"        -- SELECT에는 등장
     , SUM(e.SAL) as "급여 총합"
     , AVG(e.SAL) as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO                 -- GROUP BY에는 누락된 컬럼 JOB
 ORDER BY e.DEPTNO, e.JOB
;
-- 그룹함수가 적용되지 않았고, GROUP BY절에도 등장하지 않는 JOB컬럼이
-- SELECT 절에 있기 때문에 오류가 발생

-- 오류코드 ORA-00937: not a single-group group function
SELECT e.DEPTNO   as "부서 번호"
     , e.JOB      as "직무"        
     , SUM(e.SAL) as "급여 총합"
     , AVG(e.SAL) as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
-- GROUP BY e.DEPTNO                
;
-- 그룹함수가 적용되지 않은 컬럼들이 SELECT에 등장하면
-- 그룹화 기준으로 가정되어야 함
-- 그룹화 기준으로 사용되는 GROUP BY절 자체가 누락

--  job별 급여의 총합, 평균, 최대, 최소를 구해보자
SELECT nvl(e.JOB, '직무 미배정')          as "직무"
     , TO_CHAR(SUM(e.SAL), '$9,999.00')  as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '$9,999.00')  as "급여 평균"
     , TO_CHAR(MAX(e.SAL), '$9,999.00')  as "급여 최대"
     , TO_CHAR(MIN(e.SAL), '$9,999.00')  as "급여 최소"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY "급여 총합" DESC 
;

-- 부서 미배정이어서 NULL 데이터는 '미배정' 이라고 분류
SELECT nvl(TO_CHAR(e.DEPTNO) ||'', '미배정')       as "직무"
     , TO_CHAR(SUM(e.SAL), '$9,999.00')  as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '$9,999.00')  as "급여 평균"
     , TO_CHAR(MAX(e.SAL), '$9,999.00')  as "급여 최대"
     , TO_CHAR(MIN(e.SAL), '$9,999.00')  as "급여 최소"
  FROM emp e
 GROUP BY e.DEPTNO
 ORDER BY "급여 총합" DESC 
;
-- DECODE 활용
SELECT DECODE(nvl(e.DEPTNO, 0)
             , e.DEPTNO, e.DEPTNO||''
             , 0,        '미배정') as "직무"
     , TO_CHAR(SUM(e.SAL), '$9,999.00')  as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '$9,999.00')  as "급여 평균"
     , TO_CHAR(MAX(e.SAL), '$9,999.00')  as "급여 최대"
     , TO_CHAR(MIN(e.SAL), '$9,999.00')  as "급여 최소"
  FROM emp e
 GROUP BY e.DEPTNO
 ORDER BY "급여 총합" DESC 
;

---- 4. HAVING 절의 사용
-- GROUP BY 결과에 조건을 걸어서
-- 결과를 제한(필터링)을 목적으로 사용되는 절

-- 문제) 부서별 급여 평균이 2000이상인 부서

-- a) 우선 부서별 급여 평균을 구한다.
SELECT e.DEPTNO 부서번호
     , avg(e.SAL) 급여평균
  FROM emp e
 GROUP BY e.DEPTNO
;
-- b) a의 결과에서 2500이상인 부서만 남긴다.
SELECT e.DEPTNO 부서번호
     , avg(e.SAL) 급여평균
  FROM emp e
 GROUP BY e.DEPTNO
HAVING AVG(e.SAL) >= 2000;
;

-- HAVING 의 조건에 별칭 사용 불가
SELECT e.DEPTNO 부서번호
     , avg(e.SAL) "급여평균"
  FROM emp e
 GROUP BY e.DEPTNO
HAVING "급여평균" >= 2000;
; -- ORA-00904: "급여평균": invalid identifier
-- HAVING 절이 존재하는 경우 SELECT 의 구문의 실행 순서 정리
/*
 1. FROM 절의 테이블 각 행을 대상으로
 2. WHERE 절의 조건에 맞는 행만 선택하고
 3. GROUP BY 절에 나온 컬럼, 식(함수 식 등0으로 그룹화를 진행
 4. HAVING 절의 조건을 만족시키는 그룹만 선택
 5. 4까지 선택된 그룹 정보를 가진 행에 대해서
    SELECT 절에 명시된 컬럼, 식(함수 식 등)만 출력
 6. ORDER BY 가 있다면 정렬 조건에 맞추어 최종 정렬하여 보여준다.
*/


---------------------------------------------------
-- 수업중 실습

-- 1. 매니저별, 부하직원 수를 구하고, 많은 순으로 정렬
SELECT e.MGR
     , COUNT(*) "부하직원수"
  FROM emp e
 WHERE e.MGR IS NOT NULL
 GROUP BY e.MGR
 ORDER BY "부하직원수" DESC
;
-- 2. 부서별 인원을 구하고, 인원수 많은 순으로 정렬
SELECT e.DEPTNO "부서 번호"
     , COUNT(*) "부서별 인원"
  FROM emp e
 WHERE e.DEPTNO IS NOT NULL
 GROUP BY e.DEPTNO
 ORDER BY "부서별 인원" DESC
;
-- 3. 직무별 급여 평균 구하고, 급여평균 높은 순으로 정렬
SELECT e.JOB
     , TRUNC(AVG(e.SAL), 2) "직무별 급여 평균"
  FROM emp e
 WHERE e.JOB IS NOT NULL
 GROUP BY e.JOB
 ORDER BY "직무별 급여 평균" DESC
;

-- 4. 직무별 급여 총합 구하고, 총합 높은 순으로 정렬
SELECT e.JOB
     , SUM(e.SAL) "직무별 급여 총합"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY "직무별 급여 총합" DESC
;

-- 5. 급여의 앞단위가 1000이하, 1000, 2000, 3000, 5000 별로 인원수를 구하시오
--    급여 단위 오름차순으로 정렬

SELECT DECODE(TRUNC(e.SAL, -3),
                        0, '1000 이하'
                      , TRUNC(e.SAL, -3)) as "급여 단위"
     , COUNT(TRUNC(e.SAL, -3))            as "급여 단위별 인원수"
  FROM emp e
 GROUP BY TRUNC(e.SAL, -3)
 ORDER BY TRUNC(e.SAL, -3)
;

-----다른 방법
SELECT e.EMPNO
     , e.ENAME
     , SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1) "급여단위"
  FROM emp e
;

SELECT SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1) "급여단위"
     , COUNT(*) "인원(명)"
  FROM emp e
 GROUP BY SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1)
;

SELECT DECODE(SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1),
                        0, '1000 이하'
                      , TO_CHAR(SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1)*1000)) as "급여 단위"
     , COUNT(*) "인원(명)"
  FROM emp e
 GROUP BY SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1)
;
--------------

-- 6. 직무별 급여 합의 단위를 구하고, 급여 합의 단위가 큰 순으로 정렬
SELECT e.JOB
     , TRUNC(SUM(e.SAL), -3)/1000  "급여 합의 단위"
  FROM emp e
 WHERE e.JOB IS NOT NULL
 GROUP BY e.JOB
 ORDER BY "급여 합의 단위" DESC
;

-- 7. 직무별 급여 평균이 2000이하는 경우를 구하고 평균이 높은 순으로 정렬 
SELECT e.JOB
     , TO_CHAR(AVG(e.SAL), '$9999.99') " 직무별 급여 평균"
  FROM emp e
 WHERE e.SAL <= 2000
 GROUP BY e.JOB
 ORDER BY " 직무별 급여 평균" DESC
;

-- 8. 년도별 입사 인원을 구하시오
SELECT TO_CHAR(e.HIREDATE, 'YYYY') "년도"
     , COUNT(TO_CHAR(e.HIREDATE, 'YYYY')) "년도별 인원"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'YYYY')
 ORDER BY "년도별 인원" DESC
;

-- 9. 년도별 월별 입사 인원을 구하시오
SELECT TO_CHAR(e.HIREDATE, 'YYYY') "년도"
     ,  TO_CHAR(e.HIREDATE, 'MM') "월"
     , COUNT(*) "인원"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'YYYY'), TO_CHAR(e.HIREDATE, 'MM')
 ORDER BY "년도", "월"
;

-----------------------------------------------------------------
-- 년도벼르 월별 입사 인원을 가로 표 형태로 출력
-- a) 년도 추출, 월 추출
-- TO_CHAR(e.HIREDATE, 'YYYY'), TO_CHAR(e.HIREDATE, 'MM')

-- b) hiredate 에서 월을 추출한 값이 01이 나오면 그 때의 숫자만 1월에서 카운트
--    이 과정을 12월 까지 반복

SELECT '인원(명)' "%"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '01', 1)) "1월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '02', 1)) "2월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '03', 1)) "3월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '04', 1)) "4월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '05', 1)) "5월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '06', 1)) "6월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '07', 1)) "7월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '08', 1)) "8월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '09', 1)) "9월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '10', 1)) "10월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '11', 1)) "11월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '12', 1)) "12월"
  FROM emp e
;


------------------------7. 조인과 서브쿼리
-- (1) 조인 : JOIN
--   하나 이상의 테이블을 논리적으로 묶어서 하나의 테이블인 것 처럼 다루는 기술
-- FROM 절에 조인에 사용할 테이블 이름을 나열

-- 문제) 직원의 소속 . 부서 번호가 아닌, 부서 명을 알고싶다.
-- a) FROM 절에 emp, dept 두 테이블을 나열 ===> 조인 발생 == 카티션 곱 ==> 두 테이블의 모든 조합
-- emp 테이블의 행의 수 (16) * dept 테이블의 행의 수 (4) = 카티션 곱 (64)
SELECT e.EMPNO,
       e.ENAME,
       d.DNAME
  FROM emp e 
     , dept d 
 WHERE e.DEPTNO = d.DEPTNO -- b) 조건이 추가 되어야 직원의 소속 부서만 정확하게 연결할 수 있음
 ORDER BY d.DEPTNO
;

SELECT e.EMPNO,
       e.ENAME,
       d.DNAME
  FROM emp e JOIN dept d ON (e.DEPTNO = d.DEPTNO)
        --- 최근 다른 DBMS 들이 사용하고 있는 기법을 오라클에서 지원함
 ORDER BY d.DEPTNO
;
-- 조인 조건이 적절히 추가되어 12행의 의미 있는 데이터만 남김

-- 문제) 위의 결과에서 ACCOUNTING 부서의 직원만 알고 싶다.
--       조인 조건과 일반 조건이 같이 사용될 수 있다.
SELECT e.EMPNO,
       e.ENAME,
       d.DNAME
  FROM emp e 
     , dept d 
 WHERE e.DEPTNO = d.DEPTNO 
   AND d.DNAME = 'ACCOUNTING'
 ORDER BY d.DEPTNO
;


---- 2) 조인 : 카티션 곱
--            조인 대상 테이블의 데이터를 가능한 모든 조합으로 겪는 것
--            조인 조건 누락시 발생
--            9i 버전 이후 CROSS JOIN 키워드 지원

SELECT e.EMPNO,
       e.ENAME,
       d.DNAME,
       s.GRADE
  FROM emp e CROSS JOIN dept d  
             CROSS JOIN salgrade s-- 크로스 조인
 ORDER BY d.DEPTNO
; -- emp 16 * dept 4 * salgrade 5 = 320 행




---- 3) EQUI JOIN : 조인의 가장 기본 형태
--                  서로 다른 테이블의 공통 컬럼을 '='으로 연결
--                  공통 컬럼(join attribute)라고 부름

------- 1. 오라클 전통적인 WHERE 에 조인 조건을 걸어주는 방법
SELECT e.EMPNO,
       e.ENAME,
       d.DNAME
  FROM emp e 
     , dept d 
 WHERE e.DEPTNO = d.DEPTNO 
 ORDER BY d.DEPTNO
;

------- 2. NATURAL JOIN 키워드로 자동조인 
SELECT e.EMPNO,
       e.ENAME,
       d.DNAME
  FROM emp e NATURAL JOIN dept d -- 공통 컬럼 명시가 필요 없음
;

------- 3. JOIN ~ USING ~ 키워드로 자동조인 
SELECT e.EMPNO,
       e.ENAME,
       d.DNAME
  FROM emp e JOIN dept d USING(deptno)-- USING뒤에 공통 컬럼 별칭 없이 명시
;

------- 4. JOIN ~ ON ~ 키워드로 자동조인 
SELECT e.EMPNO,
       e.ENAME,
       d.DNAME
  FROM emp e JOIN dept d ON (e.DEPTNO = d.DEPTNO )-- ON뒤에 조인 조건 구문을 명시
;

