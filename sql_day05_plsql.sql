
--PL/SQL

-- 1. ANONYMOUS PROCEDUER : 이름 없이 1회 실행 저장 프로시저

--    출력 설정 SQL*PLUS 설정
-- 기본 OFF 설정일 것임
SHOW SERVEROUTPUT
;

-- ON 설정으로 변경
SET SERVEROUTPUT ON
;

-- 1) 변수선언이 있는 ANONYMOUS PROCEDUER 작성
DECLARE
    -- 변수 선언부
	name VARCHAR2(20) := 'Hannam Univ';
	-- name 변수는 선언하며 값을 저장
	year NUMBER;
	-- year 변수는 선언만 하고 값을 저장하지 않음
BIGIN
	-- 프로지더에서 실행할 로직을 작성
	-- 일반적으로 SQL rnanscjflrkemfdjrka.
	-- 변수 처리, 비교, 반복 등의 로직이 들어감.
	
	-- year 변수에 값 저장
	year := 1956;
	
	-- 화면 출력
	DBMS_OUTPUT.put_line(name || ' ' || year);

END;
/
