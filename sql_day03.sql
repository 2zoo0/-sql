--- 6) CASE

/*
    CLERK : 5%
    SALESMAN : 4%
    PRESIDENT : 3.7%
    MANAGER : 3%
    ANALYST : 1.5%
*/
-- 1. Simple CASE 구문으로 구해보자 : DECODE와 거의 유사, 동일 비교만 가능
--                                  괄호가 없고, 콤마 대신 키워드 WHEN, THEN, ELSE 등을 사용
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , CASE e.JOB WHEN 'CLERK'    THEN e.SAL * 0.05
                  WHEN 'SALESMAN' THEN e.SAL * 0.04
                  WHEN 'MANAGER'  THEN e.SAL * 0.037
                  WHEN 'ANALYST'  THEN e.SAL * 0.03
                  WHEN 'CLERK'    THEN e.SAL * 0.015
        END as "경조사 지원금"
  FROM emp e
;

-- 2. Searched CASE 구문으로 구해보자
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , CASE WHEN e.JOB =  'CLERK'   THEN e.SAL * 0.05
            WHEN e.JOB = 'SALESMAN' THEN e.SAL * 0.04
            WHEN e.JOB = 'MANAGER'  THEN e.SAL * 0.037
            WHEN e.JOB = 'ANALYST'  THEN e.SAL * 0.03
            WHEN e.JOB = 'CLERK'    THEN e.SAL * 0.015
       END as "경조사 지원금"
  FROM emp e
;
