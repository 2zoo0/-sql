-- sql day01
----------------------------------------------------------------------------------------
-- 1. SCOTT ���� Ȱ��ȭ
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
-- 2. ���� ���� Ȯ�� ���
SHOW USER
-- 3. HR ���� Ȱ��ȭ : SYS �������� �����Ͽ� �ٸ� ����ڿ���
--                   HR ������ �������, ��й�ȣ ���� ���� ����
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