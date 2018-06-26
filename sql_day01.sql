-- sql day01
----------------------------------------------------------------------------------------
-- 1. SCOTT 계정 활성화
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
-- 2. 접속 유저 확인 명령
SHOW USER
-- 3. HR 계정 활성화 : SYS 계정으로 접속하여 다른 사용자에서
--                   HR 계정의 계정잠김, 비밀번호 만료 상태 해제
----------------------------------------------------------------------------------------
-- 01. DQL
SELECT *
  FROM EMP
;
SELECT *
  FROM DEPT
;
SELECT *
  FROM SALGRADE
;
SELECT *
  FROM BONUS
;