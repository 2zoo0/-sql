-- SQL Day02
--------------------------------------------------------------------------
--- IS NULL, IS NOT NULL 연산자
/*     
IS NULL : 비교하려는 컬럼의 값이 NULL 이면 true, NULL 이 아니면 false
IS NOT NULL: 비교하려는 컬럼의 값이 NULL 이 아니면 true, NULL 이면 false

NULL 값은 컬럼은 비교연산자와 연산이 불가능 하므로
NULL 값 비교 연산자가 따로 존재함

coll = null ==> NULL 값에 대해서는 = 비교 연산자 사용 불가능
coll != null ==> NULL 값에 대해서는 !=,<> 비교 연산자 사용 불가능
*/
--- 27) 어떤 직원의 mgr가 지정되지 않은 지원 정보 조회
SELECT e.EMPNO
     , e.ENAME
     , e.MGR
  FROM emp e
 WHERE e.MGR IS NULL
;
/*
EMPNO, ENAME, MGR
------------------
7839	KING	
9999	J_JUNE	
8888	J	
7777	J%JONES	
*/

--- mgr이 배정된 직원 정보 조회
SELECT e.EMPNO
     , e.ENAME
     , e.MGR
  FROM emp e
 WHERE e.MGR IS NOT NULL
 --- e.MGR != NULL 이라고 쓸 수 없음 주의
 --- e.MGR <> NULL 이라고 쓸 수 없음 주의
;
/*
EMPNO, ENAME, MGR
----------------------
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/

--- BETWEEN ~ AND ~ : 범위 비교 연산자 범위 포함
-- a<= sal <= b : 이러한 범위 연산과 동일
--- 28) 급여가 500 ~ 1200 사이인 직원 정보 조회
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL BETWEEN 500 AND 1200
    OR e.SAL BETWEEN 3000 AND 5000
;
/*EMPNO, ENAME, SAL
----------------------
7369	SMITH	800
7839	KING	5000
7900	JAMES	950
7902	FORD	3000
9999	J_JUNE	500
*/

-- BETWEEN 500 AND 1200 과 같은 결과를 내는 비교연산자
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL >= 500
   AND e.SAL <= 1200 -- 등호가 들어가는 비교 연산자를 사용
;


--- IS NOT NULL 대신 <>, != 연산자를 사용한 경우의 조회 결과 비교
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.MGR <> NULL
    OR e.MGR != NULL
;
-- > 인출된 모든 행 : 0
-- > 실행에 오류는 없지만 올바른 결과가 아님
-- > 이런 경우는 오류를 찾기가 어렵기 때문에 NULL 데이터를 다룰 때는 항상 주의


--- EXISTS 연산자 : 조회한 결과가 1행 이상 있다.
--                 어떤 SELECT 구문을 실행했을 때 조회 결과가 1행 이상 있으면
--                 이 연사자의 결과가 true
--                 조회 결과 : <인출된 모든 행 : 0> 인 경우 false
--                 따라서 서브쿼리와 함께 사용됨


--- 29) 급여가 10000이 넘는 사람이 있는가?
--       (1) 급여가 1000이 넘는 사람을 찾는 구문을 작성
SELECT e.ENAME
  FROM emp e
 WHERE e.SAL > 10000
;
/*
위의 쿼리 실행 결과가 1행 이라도 존재하면 화면에
"급여가 10000이 넘는 직원이 존재함" 이라고 출력
*/

SELECT '급여가 10000이 넘는 직원이 존재함' as "시스템  메시지"
  FROM dual
 WHERE EXISTS (SELECT e.ENAME
                 FROM emp e
                WHERE e.SAL > 10000)
;

/*
위의 쿼리 실행 결과가 1행 이라도 존재하지 않으면면 화면에
"급여가 10000이 넘는 직원이 존재하지 않음" 이라고 출력
*/

SELECT '급여가 10000이 넘는 직원이 존재하지 않음' as "시스템  메시지"
  FROM dual
 WHERE NOT EXISTS (SELECT e.ENAME
                 FROM emp e
                WHERE e.SAL > 10000)
;

-- (6) 연산자 : 결합연산자 (||)
--  오라클에만 존재, 문자열 결합(접합)
--  다른 자바 등의 프로그래밍 언어에서는 OR 논리 연산자로 사용되므로 
--  혼동에 주의

--  오늘의 날짜를 화면에 조회
SELECT sysdate as "오늘"
  FROM dual
;

-- 오늘의 날짜를 알려주는 문장을 만들려면
SELECT '오늘의 날짜는 ' || sysdate || '입니다.' as "오늘의 날짜"
  FROM dual
;

-- 직원의 사번을 알려주는 구문을 || 연산자를 사용하여 작성
SELECT '안녕하세요. ' || e.ENAME || '씨, 당신의 사번은 ' || e.EMPNO || '입니다.' as "사번 알리미"
  FROM emp e
;


--(6) 연산자 :  6. 집합연산자
-- 첫번째 쿼리
SELECT *
  FROM dept d
;
-- 두번째 쿼리 : 부서번호가 10번인 부서정보만 조회
SELECT *
  FROM dept d
 WHERE d.DEPTNO = 10
;

-- 1) UNION ALL : 두 집합의 중복데이터 허용하여 합집합
SELECT * 
  FROM dept
 UNION ALL -- 중복값 포함 합집합
SELECT *
  FROM dept
 WHERE deptno = 10
 ;
 
-- 2) UNION : 두 집합의 중복을 제거한 합집합
SELECT * 
  FROM dept
 UNION -- 중복값 제외 합집합
SELECT *
  FROM dept
 WHERE deptno = 10
 ;
 
-- 3) INTERSECT : 두집합의 중복된 데이터만 남긴 교집합
SELECT * 
  FROM dept
INTERSECT --중복값만 교집합
SELECT *
  FROM dept
 WHERE deptno = 10
 ;
 
-- 4) MINUS : 첫번째 쿼리 실행 결과에서 두번째 쿼리 실행결과를 뺀 차집합
SELECT * 
  FROM dept
 MINUS --중복값 제외 차집합
SELECT *
  FROM dept
 WHERE deptno = 10;

-- 주의! : 각 쿼리 조회 결과의 컬럼 갯수, 데이터 타입이 서로 일치해야 함.
SELECT * 
  FROM dept d
 UNION ALL
SELECT d.DEPTNO
     , d.DNAME
  FROM dept d
 WHERE deptno = 10
; 
 -- ORA-01789: query block has incorrect number of result columns
 
SELECT d.DNAME
     , d.DEPTNO 
  FROM dept d
 UNION ALL
SELECT d.DEPTNO
     , d.DNAME
  FROM dept d
 WHERE deptno = 10
; 
 -- ORA-01790: expression must have same datatype as corresponding expression
 -- 서로 대응하는 datatype이 같아야 함.
 
-- 서로 다른 테이블에서 조회한 결과를 집합연산 가능
-- 첫번째 쿼리 : emp 테이블에서 조회
SELECT e.EMPNO -- 숫자
     , e.ENAME -- 문자
     , e.JOB   -- 문자
  FROM emp e
;

-- 두번째 쿼리 : dept 테이블에서 조회
SELECT d.DEPTNO -- 숫자
     , d.DNAME -- 문자
     , d.LOC   -- 문자
  FROM dept d
;

-- 서로 다른 테이블의 조회 내용을 UNION
SELECT e.EMPNO -- 숫자
     , e.ENAME -- 문자
     , e.JOB   -- 문자
  FROM emp e
UNION
SELECT d.DEPTNO -- 숫자
     , d.DNAME -- 문자
     , d.LOC   -- 문자
  FROM dept d
;

/*
EMPNO, ENAME, JOB
------------------------
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7777	J%JONES	CLERK
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
*/

-- 서로 다른 테이블의 조회 내용을 MINUS
SELECT e.EMPNO -- 숫자
     , e.ENAME -- 문자
     , e.JOB   -- 문자
  FROM emp e
MINUS
SELECT d.DEPTNO -- 숫자
     , d.DNAME -- 문자
     , d.LOC   -- 문자
  FROM dept d
;
/*
EMPNO, ENAME, JOB
-------------------------
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7777	J%JONES	CLERK
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK
8888	J	CLERK
9999	J_JUNE	CLERK
*/

-- 서로 다른 테이블의 조회 내용을 INTERSECT
SELECT e.EMPNO -- 숫자
     , e.ENAME -- 문자
     , e.JOB   -- 문자
  FROM emp e
INTERSECT
SELECT d.DEPTNO -- 숫자
     , d.DNAME -- 문자
     , d.LOC   -- 문자
  FROM dept d
;
-- 조회 결과 없음 :  
-- 인출된 모든 행 : 0
-- no rows selected

-- (6) 연산자 : 7. 연산자 우선순위
/*
주어진 조건 3가지
1. mgr == 7698
2. job = 'CLERK'
3. sal > 1300
*/

-- 1) 매니저가 7698 번이며, 직무는 CLERK 이거나
--    급여가 1300이 넘는 조건을 만족하는 직원의 정보를 조회

SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL
     , e.MGR
  FROM emp e
 WHERE e.MGR = 7698
   AND (e.JOB = 'CLERK'
    OR e.SAL > 1300)
;

/* EMPNO, ENAME, JOB, SAL, MGR
----------------------------------------
7499	ALLEN	SALESMAN  1600	7698
7566	JONES	MANAGER	  2975	7839
7698	BLAKE	MANAGER	  2850	7839
7782	CLARK	MANAGER	  2450	7839
7839	KING	PRESIDENT 5000	
7844	TURNER	SALESMAN  1500	7698
7900	JAMES	CLERK	  950	7698
7902	FORD	ANALYST	  3000	7566
*/

-- 2) 매니저가 7609 번인 직원중에서
--    직무가 CLERK 이거나 급여가 1300이 넘는 조건을 만족하는 직원 정보
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL
     , e.MGR
  FROM emp e
 WHERE e.MGR = 7698
   AND (e.JOB = 'CLERK' OR e.SAL > 1300)
;
/*EMPNO, ENAME, JOB, SAL, MGR
----------------------------------------
7499	ALLEN	SALESMAN	1600	7698
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950 	7698
*/
-- 3) 직무가 CLERK 이거나
--    급여가 13000이 넘으면서 매니저가 7698인 직원의 정보 조회
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL
     , e.MGR
  FROM emp e
 WHERE e.JOB = 'CLERK'
    OR (e.MGR = 7698 AND e.SAL > 1300)
;
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL
     , e.MGR
  FROM emp e
 WHERE e.JOB = 'CLERK'
    OR e.MGR = 7698 
   AND e.SAL > 1300
; 
-- AND 연산자의 우선순위는 자동으로 OR 보다 높기 때문에
-- 두번째 처럼 괄호를 사용하지 않아도 수행 결과는 같아짐

/* EMPNO, ENAME, JOB, SAL, MGR
----------------------------------------
7369	SMITH	CLERK	 800	7902
7499	ALLEN	SALESMAN 1600	7698
7844	TURNER	SALESMAN 1500	7698
7900	JAMES	CLERK	 950	7698
7934	MILLER	CLERK	 1300	7782
9999	J_JUNE	CLERK	 500	
8888	J	    CLERK	 400	
7777	J%JONES	CLERK	 300	
*/

----------6. 함수
-- (2) dual 테이블 : 1행 1열로 구성된 시스템 테이블
DESC dual; -- 문자데이터 1칸으로 구성된 DUMMY 컬럼을 가진 테이블

SELECT * -- ==> dummy 컬럼에 X 값이 하나 들어있음을 확인 할 수 있다.
  FROM dual
;

-- dual 테이블을 이용하여 날짜 조회
SELECT sysdate
  FROM dual
;

--(3) 단일행 함수
--- 1) 숫자함수 : 1. MOD(m, n) : m을 n으로 나눈 나머지 계산함수
SELECT MOD(10, 3) as result
  FROM dual
;

SELECT MOD(10, 3) as result
  FROM emp
;
SELECT MOD(10, 3) as result
  FROM dept
;

-- 각 사원의 급여를 3으로 나눈 나머지를 조회
SELECT e.EMPNO
     , e.ENAME
     , MOD(e.SAL, 3) AS RESULT
  FROM emp e
;

-- SELECT 구문은 테이블 행의 수만큼 반복 실행
-- 함수가 1행마다 1번씩 적용

---- 2. ROUND(m, n) : 실수 m 을 소수점 n + 1 자리에서 [반올림] 한 결과를 계산
SELECT ROUND(1234.56, 1) FROM dual; -- 1234.6
SELECT ROUND(1234.56, 0) FROM dual; -- 1235
SELECT ROUND(1234.46, 0) FROM dual; -- 1234
-- ROUND(m) : n 값을 생략하면 소수점 이하 첫째자리 반올림 바로 수행
--            즉, n 값을 0으로 수정함
SELECT ROUND(1234.46) FROM dual; -- 1234
SELECT ROUND(1234.56) FROM dual; -- 1235

---- 3. TRUNC(m, n) : 실수 m을 n에서 지정한 자리 이하 소수점 이하 버림
SELECT TRUNC(1234.56, 1) FROM dual; -- 1234.5
SELECT TRUNC(1234.56, 0) FROM dual; -- 1234
-- TRUNC(m) : n 값을 생략하면 0으로 수행
SELECT TRUNC(1234.56) FROM dual; -- 1234

---- 4. CEIL(n) : 입력 된 실수 n에서 같거나 가장 큰 가까운 정수
SELECT CEIL(1234.56) FROM dual; -- 1235
SELECT CEIL(1234) FROM dual; -- 1234
SELECT CEIL(1234.001) FROM dual; -- 1235

---- 5. FLOOR(n) : 입력 된 실수 n에서 같거나 가장 가까운 작은 정수 
SELECT FLOOR(1234.56) FROM dual; -- 1234
SELECT FLOOR(1234) FROM dual; -- 1234
SELECT FLOOR(1234.999) FROM dual; -- 1234

---- 6. WIDTH_BUCKET(expr, min, max, buckets)
-- : min, max 값 사이를 buckets 개수만큼 구간으로 나누고
--   expr이 출력하는 값이 어느 구간인지 위치를 숫자로 구해줌

-- 급여 범위를 0 ~ 5000 으로 잡고, 5개의 구간으로 나누어서
-- 각 직원의 급여가 어느 구간에 해당하는지 보고서를 출력해 보자.
SELECT e.EMPNO
     , e.ENAME 
     , e.SAL
     , WIDTH_BUCKET(e.SAL, 300, 5000, 5) as "급여 구간"
  FROM emp e
 ORDER BY "급여 구간" DESC
;


--- 2) 문자함수
---- 1. INITCAP(str)
SELECT INITCAP('the soap') FROM dual; -- The Soap, 한글은 안됨

---- 2. LOWER(str)
SELECT LOWER('The Soap') "소문자로 변경" FROM dual; -- the soap

---- 3. UPPER(str)
SELECT UPPER('The Soap') "대문자로 변경" FROM dual; -- THE SOAP
SELECT UPPER('sql is cooooooooooool~~!!') "대문자로 변경" FROM dual; --SQL IS COOOOOOOOOOOOL~~!!

---- 4. LENGTH(str), LENTHB(str)
SELECT 'The Soap의 글자 길이는 ' || LENGTH('The Soap') || '입니다.' 
       as "글자길이" 
  FROM dual;
  -- oracle 에서 한글은 3byte 로 계산
SELECT 'The Soap의 글자 Byte는 ' || LENGTHB('The Soap') || '입니다.' 
    as "글자Byte" 
  FROM dual;
SELECT '오라클의 글자 Byte는 ' || LENGTHB('오라클') || '입니다.' 
       as "글자Byte" 
  FROM dual; -- 9 byte

---- 5. CONCAT(str1, str2) : str1, str2 문자열을 접합, || 연산자와 동일
SELECT CONCAT('The Soap ', 'is small.') "대문자로 변경" FROM dual;

---- 6. SUBSTR(str, i, n) : str 에서 i번째 위치에서 n개의 글자를 추출
--                          SQL 에서 문자열 인덱스를 나타내는 i는 1부터 시작에 주의함
SELECT SUBSTR('sql is cooooooooooool~~!!', 3, 4) FROM dual;
-- l is
SELECT SUBSTR('sql is cooooooooooool~~!!', 3) FROM dual;
-- l is cooooooooooool~~!!

---- 7. INSTR(str1, str2) : 2번째 문자열이 1번째 문자열 어디에 위치하는가
--                          등장하는 위치를 계산
SELECT INSTR('sql is cooooooooooool~~!!', 'is') FROM dual; -- 5
SELECT INSTR('sql is cooooooooooool~~!!', 'ia') FROM dual; -- 2번째 문장이 등장하지 않으면 0으로 조회됨

---- 8. LPAD, RPAD(str, n, c)
--       : 입력된 str 에 대해서, 전체 글자의 자릿수를 n으로 잡고
--         남는 공간에 왼쪽, 혹은 오른쪽으로 c 의 문자르 채워넣는다.
SELECT LPAD('sql is cool', 20, '!') FROM dual; --!!!!!!!!!sql is cool
SELECT RPAD('sql is cool', 20, '!') FROM dual; --sql is cool!!!!!!!!!

---- 9. LTRIM, RTRIM, TRIM
SELECT '>' || LTRIM('    sql is cool     ') || '<' FROM dual;
SELECT '>' || RTRIM('    sql is cool     ') || '<' FROM dual;
SELECT '>' || TRIM('    sql is cool     ') || '<' FROM dual;

---- 10. NVL(expr1, expr2), NVL2(expr1, expr2, expr3), NULLIF(expr1, expr2)
--  NVL(expr1, expr2) : expr1의 값이  NULL이면 expr2으로 대체하여 출력
--  mgr 가 배정안된 직원의 경우 '매니저 없음' 으로 변경해서 출력
SELECT e.EMPNO
     , e.ENAME
     , nvl(e.MGR, '매니저 없음') -- mgr 숫자 데이터, 변경 출력이 문자
  FROM emp e --  타입 불일치로 실행이 안됨
;
-----------------
SELECT e.EMPNO
     , e.ENAME
     , nvl(e.MGR || '', '매니저 없음')
  FROM emp e
;

--  NVL2(expr1, expr2, expr3) : expr1의 값이 NOT NULL이면 expr2의 값으로 대체하여 출력하고 
--                              NULL이면 expr3의 값으로 대체하여 출력

SELECT e.EMPNO
     , e.ENAME
     , nvl2(e.MGR || '','매니저 있음' , '매니저 없음')
  FROM emp e
;

--  NULLIF(expr1, expr2) : expr1, expr2의 값이 동일하면 NULL을 출력
--                         식의 값이 다르면 expr1의 값을 출력
SELECT NULLIF('AAA','AAA')
  FROM dual
; -- (null)
SELECT NULLIF('AAA','BBB')
  FROM dual
; -- AAA



-- (3) 날짜함수 : 날짜 출력 패턴 조합으로 다양하게 출력가능
SELECT TO_CHAR(sysdate,'YYYY') FROM dual;
SELECT TO_CHAR(sysdate,'YY') FROM dual;
SELECT TO_CHAR(sysdate,'MM') FROM dual;
SELECT TO_CHAR(sysdate,'MONTH') FROM dual;
SELECT TO_CHAR(sysdate,'MON') FROM dual;
SELECT TO_CHAR(sysdate,'D') FROM dual;
SELECT TO_CHAR(sysdate,'DD') FROM dual;
SELECT TO_CHAR(sysdate,'DAY') FROM dual;
SELECT TO_CHAR(sysdate,'DY') FROM dual;

-- 패턴을 조합
SELECT TO_CHAR(sysdate,'YYYY-MM-DD') FROM dual;
SELECT TO_CHAR(sysdate,'YY-MONTH-DD') FROM dual;
SELECT TO_CHAR(sysdate,'YY-MONTH-DD DAY') FROM dual;
SELECT TO_CHAR(sysdate,'YY-MONTH-DD DY') FROM dual;

/*
 HH : 시간을 두자리로 표기
 MI : 분을 두자로 표기
 SS : 초를 두자리로 표기
 HH24 : 시간을 24시간 체계로 표기
 AM : 오전 오후 표시
*/

SELECT TO_CHAR(sysdate,'YYYY-MM-DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(sysdate,'YYYY-MM-DD AM HH:MI:SS') FROM dual;

-- 날짜 값과 숫자의 연산 : +, - 연산 가능
SELECT sysdate + 10 FROM dual; -- 10일 후
SELECT sysdate - 10 FROM dual; -- 10일 전
SELECT sysdate + (10/24) FROM dual; -- 10시간 후
SELECT TO_CHAR(sysdate + (10/24),'YYYY-MM-DD HH24:MI:SS') FROM dual;

----- 1. MONTHS_BETWEEN(날짜1, 날짜2) : 두 날짜 사이의 달의 차이
SELECT MONTHS_BETWEEN(sysdate, e.HIREDATE) FROM emp e;

----- 2. ADD_MONTHS(날짜1, 숫자) : 날짜 1에 숫자만큼 후의 날짜
SELECT ADD_MONTHS(sysdate, 3) FROM dual;

----- 3. NEXT_DAY, LAST_DAY : 다음 요일에 해당하는 날짜, 이 달의 마지막 날짜
SELECT NEXT_DAY(sysdate, '목요일') FROM dual;
SELECT NEXT_DAY(sysdate, 5) FROM dual; -- 일요일부터 1
SELECT LAST_DAY(sysdate) FROM dual;

----- 4. ROUND, TRUNC : 날짜 관련 반올림, 버림
SELECT TO_CHAR(ROUND(sysdate),'YYYY-MM-DD HH24:MI:SS')FROM dual; --반올림
SELECT TO_CHAR(TRUNC(sysdate),'YYYY-MM-DD HH24:MI:SS')FROM dual; --내림

--- 4) 데이터 타입 변환 함수
/*
   TO_CHAR()    : 숫자, 날짜 ===> 문자
   TO_DATE()    : 날짜 형식의 문자 ===> 날짜
   TO_NUMBER()  : 숫자로만 구성된 문자데이터 ===> 숫자
*/

---- 1. TO_CHAR() : 숫자패턴 적용
--      숫자패턴 : 9 ==> 한자리 숫자
SELECT TO_CHAR(12345, '0,999,999,999.9') FROM dual; -- 0012345.0

SELECT e.EMPNO
     , e.SAL
  FROM emp e
;
---- 2. TO_DATE() : 날짜패턴에 맞는 문자 값을 날짜 데이터로 변경
SELECT TO_DATE('2018-06-27','YYYY-MM-DD') + 10 today FROM dual; -- 문자 -> 날짜 -> 10일후
SELECT '2018-06-27' + 10 today FROM dual; -- ORA-01722: invalid number 형변환 안돼서 연산불가능

---- 3. TO_NUMBER() : 오라클이 자동 형변환을 제공하므로 자주 사용은 안 됨
SELECT '1000' + 10 FROM dual --숫자로만 이루어진 문자는 연산이 된다
UNION ALL
SELECT TO_NUMBER('1000') + 10 FROM dual;

--- 5) DECODE(expr, search, result [,search, result]...[, default])
/*
    만약에 default 가 설정이 안되었고
    expr 과 일치하는 search가 없는 경우 null 을 리턴
*/
SELECT DECODE('YES' -- expr
              ,'YES', '입력값이 YES 입니다.'
              ,'NO', '입력값이 NO 입니다.'
             ) as result
  FROM dual
;
SELECT DECODE('NO' -- expr
              ,'YES', '입력값이 YES 입니다.'
              ,'NO', '입력값이 NO 입니다.'
             ) as result
  FROM dual
;
SELECT DECODE('예' -- expr
              ,'YES', '입력값이 YES 입니다.'
              ,'NO', '입력값이 NO 입니다.'
             ) as result
  FROM dual
; 
-- >> 행마다 실행되기 때문에  < 인출된 모든 행 : 0 > 이 아닌 NULL 
-- default는 (null)

SELECT DECODE('예' -- expr
              ,'YES', '입력값이 YES 입니다.'
              ,'NO', '입력값이 NO 입니다.'
              ,'입력값이 YES/NO 둘 다 아닙니다.') as result
  FROM dual
; 
-- emp 테이블의 hiredate 의 입사년도를 추출하여 몇년 근무했는지를 계산
-- 장기근속 여부를 판단
-- 1) 입사년도 추출 : 날짜 패턴
SELECT e.EMPNO
     , e.ENAME
     , TO_CHAR(e.HIREDATE, 'YYYY') hireyear
  FROM emp e
;
-- 2) 몇년근무 판단 : 오늘 시스템 날짜와 연산
SELECT e.EMPNO
     , e.ENAME
     , TO_CHAR(sysdate, 'YYYY') - TO_CHAR(e.HIREDATE, 'YYYY') "workingyear"
  FROM emp e
;

-- 3) 37년 이상 된 직원을 장기 근속으로 판단
SELECT a.EMPNO
     , a.ENAME
     , DECODE(a.workingyear
             ,37, '장기 근속자 입니다.' -- search, result1
             ,38, '장기 근속자 입니다.' -- search, result2
             ,'장기 근속자가 아닙니다.') as "장기 근속여부" -- default
  FROM (SELECT e.EMPNO
             , e.ENAME
             , TO_CHAR(sysdate, 'YYYY') - TO_CHAR(e.HIREDATE, 'YYYY') workingyear
          FROM emp e) a
;

-- job별로 경조사비를  급여대비 일정 비율로 지급하고 있다.
-- 각 직원들의 경조사비 지원금을 구하자
/*
    CLERK : 5%
    SALESMAN : 4%
    PRESIDENT : 3.7%
    MANAGER : 3%
    ANALYST : 1.5%
*/
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , TO_CHAR(DECODE(e.JOB
                     ,'CLERK' , e.SAL*0.05
                     ,'SALESMAN' , e.SAL*0.04
                     ,'MANAGER' , e.SAL*0.037
                     ,'ANALYST' , e.SAL*0.03
                     ,'PRESIDENT' , e.SAL*0.015
                     ,0), '$999.99') as "경조사비"
  FROM emp e
 ORDER BY "경조사비"
;
