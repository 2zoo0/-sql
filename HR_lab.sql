--1. employees 테이블에서 job_id 를 중복 배제하여 조회 하고
--   job_title 같이 출력
--19건
SELECT DISTINCT e.job_id
  FROM employees e
;
/* JOB_ID
-----------
AC_ACCOUNT
AC_MGR
AD_ASST
AD_PRES
AD_VP
FI_ACCOUNT
FI_MGR
HR_REP
IT_PROG
MK_MAN
MK_REP
PR_REP
PU_CLERK
PU_MAN
SA_MAN
SA_REP
SH_CLERK
ST_CLERK
ST_MAN
*/

--2. employees 테이블에서 사번, 라스트네임, 급여, 커미션 팩터,
--   급여x커미션팩터(null 처리) 조회
--   커미션 컬럼에 대해 null 값이면 0으로 처리하도록 함
--107건
SELECT e.EMPLOYEE_ID
     , e.LAST_NAME
     , e.SALARY
     , nvl(e.COMMISSION_PCT, 0) "COMMISSION_PCT"
     , e.SALARY * nvl(e.COMMISSION_PCT, 0) "SAL x COMM_PCT"
  FROM employees e
;
/* EMPLOYEE_ID, LAST_NAME, SALARY, COMMISSION_PCT, SAL x COMM_PCT
------------------------------------------------------------------
100	King	    24000	0	0
101	Kochhar	    17000	0	0
102	De Haan 	17000	0	0
103	Hunold	    9000	0	0
104	Ernst	    6000	0	0
105	Austin	    4800	0	0
106	Pataballa	4800	0	0
107	Lorentz	    4200	0	0
108	Greenberg	12008	0	0
109	Faviet	    9000	0	0
110	Chen	    8200	0	0
111	Sciarra	    7700	0	0
112	Urman	    7800	0	0
113	Popp	    6900	0	0
114	Raphaely	11000	0	0
115	Khoo	    3100	0	0
116	Baida	2900	0	0
117	Tobias	2800	0	0
118	Himuro	2600	0	0
119	Colmenares	2500	0	0
120	Weiss	8000	0	0
121	Fripp	8200	0	0
122	Kaufling	7900	0	0
123	Vollman	6500	0	0
124	Mourgos	5800	0	0
125	Nayer	3200	0	0
126	Mikkilineni	2700	0	0
127	Landry	2400	0	0
128	Markle	2200	0	0
129	Bissot	3300	0	0
130	Atkinson	2800	0	0
131	Marlow	2500	0	0
132	Olson	2100	0	0
133	Mallin	3300	0	0
134	Rogers	2900	0	0
135	Gee	2400	0	0
136	Philtanker	2200	0	0
137	Ladwig	3600	0	0
138	Stiles	3200	0	0
139	Seo	2700	0	0
140	Patel	2500	0	0
141	Rajs	3500	0	0
142	Davies	3100	0	0
143	Matos	2600	0	0
144	Vargas	2500	0	0
145	Russell	14000	0.4	5600
146	Partners	13500	0.3	4050
147	Errazuriz	12000	0.3	3600
148	Cambrault	11000	0.3	3300
149	Zlotkey	10500	0.2	2100
150	Tucker	10000	0.3	3000
151	Bernstein	9500	0.25	2375
152	Hall	9000	0.25	2250
153	Olsen	8000	0.2	1600
154	Cambrault	7500	0.2	1500
155	Tuvault	7000	0.15	1050
156	King	10000	0.35	3500
157	Sully	9500	0.35	3325
158	McEwen	9000	0.35	3150
159	Smith	8000	0.3	2400
160	Doran	7500	0.3	2250
161	Sewall	7000	0.25	1750
162	Vishney	10500	0.25	2625
163	Greene	9500	0.15	1425
164	Marvins	7200	0.1	720
165	Lee	6800	0.1	680
166	Ande	6400	0.1	640
167	Banda	6200	0.1	620
168	Ozer	11500	0.25	2875
169	Bloom	10000	0.2	2000
170	Fox	9600	0.2	1920
171	Smith	7400	0.15	1110
172	Bates	7300	0.15	1095
173	Kumar	6100	0.1	610
174	Abel	11000	0.3	3300
175	Hutton	8800	0.25	2200
176	Taylor	8600	0.2	1720
177	Livingston	8400	0.2	1680
178	Grant	7000	0.15	1050
179	Johnson	6200	0.1	620
180	Taylor	3200	0	0
181	Fleaur	3100	0	0
182	Sullivan	2500	0	0
183	Geoni	2800	0	0
184	Sarchand	4200	0	0
185	Bull	4100	0	0
186	Dellinger	3400	0	0
187	Cabrio	3000	0	0
188	Chung	3800	0	0
189	Dilly	3600	0	0
190	Gates	2900	0	0
191	Perkins	2500	0	0
192	Bell	4000	0	0
193	Everett	3900	0	0
194	McCain	3200	0	0
195	Jones	2800	0	0
196	Walsh	3100	0	0
197	Feeney	3000	0	0
198	OConnell	2600	0	0
199	Grant	2600	0	0
200	Whalen	4400	0	0
201	Hartstein	13000	0	0
202	Fay	6000	0	0
203	Mavris	6500	0	0
204	Baer	10000	0	0
205	Higgins	12008	0	0
206	Gietz	8300	0	0
*/

 
--3. employees 테이블에서 사번, 라스트네임, 급여, 커미션 팩터(null 값 처리) 조회
--   단, 2007년 이 후 입사자에 대하여 조회, 고용년도 순 오름차순 정렬
--30건
SELECT e.EMPLOYEE_ID
     , e.LAST_NAME
     , e.SALARY
     , nvl(e.COMMISSION_PCT, 0) "COMMISSION_PCT"
  FROM employees e
 WHERE e.HIRE_DATE >= '07/01/01'
 ORDER BY e.HIRE_DATE
;
/* 
EMPLOYEE_ID, LAST_NAME, SALARY, COMMISSION_PCT
-----------------------------------------------
127	Landry	        2400	0
107	Lorentz	        4200	0
187	Cabrio	        3000	0
171	Smith	        7400	0.15
195	Jones	        2800	0
163	Greene	        9500	0.15
172	Bates	        7300	0.15
132	Olson	        2100	0
104	Ernst	        6000	0
178	Grant	        7000	0.15
198	OConnell	    2600	0
182	Sullivan	    2500	0
119	Colmenares	    2500	0
148	Cambrault	    11000	0.3
124	Mourgos	        5800	0
155	Tuvault	        7000	0.15
113	Popp	        6900	0
135	Gee	            2400	0
191	Perkins	        2500	0
179	Johnson	        6200	0.1
199	Grant	        2600	0
164	Marvins	        7200	0.1
149	Zlotkey	        10500	0.2
183	Geoni	        2800	0
136	Philtanker	    2200	0
165	Lee	            6800	0.1
128	Markle	        2200	0
166	Ande	        6400	0.1
167	Banda	        6200	0.1
173	Kumar	        6100	0.1
*/

--4. Finance 부서에 소속된 직원의 목록 조회
--조인으로 해결
SELECT e.EMPLOYEE_ID
     , e.LAST_NAME
     , e.DEPARTMENT_ID
     , d.DEPARTMENT_NAME
  FROM employees e , DEPARTMENTS d
 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
   AND d.DEPARTMENT_NAME = 'Finance'
;
/* EMPLOYEE_ID, LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME
-----------------------------------------------------------
        108	Greenberg	100	Finance
        109	Faviet	    100	Finance
        110	Chen	    100	Finance
        111	Sciarra	    100	Finance
        112	Urman	    100	Finance
        113	Popp	    100	Finance
*/


--서브쿼리로 해결
SELECT e.EMPLOYEE_ID
     , e.LAST_NAME
     , e.DEPARTMENT_ID
     , (SELECT d.DEPARTMENT_NAME
          FROM departments d
         WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID) "DNAME"
  FROM employees e
 WHERE e.DEPARTMENT_ID = (SELECT d.DEPARTMENT_ID
                            FROM departments d
                           WHERE d.DEPARTMENT_NAME = 'Finance')
;

--6건
 
--5. Steven King 의 직속 부하직원의 모든 정보를 조회
--14건
-- 조인 이용
SELECT e2.*
  FROM employees e1 JOIN employees e2
    ON e1.employee_id = e2.manager_id
 WHERE e1.FIRST_NAME = 'Steven'
   AND e1.LAST_NAME = 'King'
;

-- 서브쿼리 이용
 SELECT *
  FROM employees
 WHERE manager_id = (SELECT employee_id
                       FROM employees
                      WHERE FIRST_NAME = 'Steven'
                        AND LAST_NAME = 'King')
;

/* EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
---------------------------------------------------------------------------------------------------------------------------------
101	Neena	Kochhar	    NKOCHHAR	515.123.4568	    05/09/21	AD_VP	17000		100	90
102	Lex	    De Haan     LDEHAAN	    515.123.4569	    01/01/13	AD_VP	17000		100	90
114	Den	    Raphaely	DRAPHEAL	515.127.4561    	02/12/07	PU_MAN	11000		100	30
120	Matthew	Weiss	    MWEISS	    650.123.1234    	04/07/18	ST_MAN	8000		100	50
121	Adam	Fripp	    AFRIPP	    650.123.2234    	05/04/10	ST_MAN	8200		100	50
122	Payam	Kaufling	PKAUFLIN	650.123.3234	    03/05/01	ST_MAN	7900		100	50
123	Shanta	Vollman	    SVOLLMAN	650.123.4234	    05/10/10	ST_MAN	6500		100	50
124	Kevin	Mourgos	    KMOURGOS	650.123.5234	    07/11/16	ST_MAN	5800		100	50
145	John	Russell 	JRUSSEL	    011.44.1344.429268	04/10/01	SA_MAN	14000	0.4	100	80
146	Karen	Partners	KPARTNER	011.44.1344.467268	05/01/05	SA_MAN	13500	0.3	100	80
147	Alberto	Errazuriz	AERRAZUR	011.44.1344.429278	05/03/10	SA_MAN	12000	0.3	100	80
148	Gerald	Cambrault	GCAMBRAU	011.44.1344.619268	07/10/15	SA_MAN	11000	0.3	100	80
149	Eleni	Zlotkey 	EZLOTKEY	011.44.1344.429018	08/01/29	SA_MAN	10500	0.2	100	80
201	Michael	Hartstein	MHARTSTE	515.123.5555	    04/02/17	MK_MAN	13000		100	20

조인이용과 서브쿼리 이용 내용이 같으므로 테이블 한개만 주석
*/

--6. Steven King의 직속 부하직원 중에서 Commission_pct 값이 null이 아닌 직원 목록
--5건
SELECT *
  FROM employees
 WHERE manager_id = (SELECT employee_id
                       FROM employees
                      WHERE FIRST_NAME = 'Steven'
                        AND LAST_NAME = 'King')
   AND Commission_pct IS NOT NULL
;
/* EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
---------------------------------------------------------------------------------------------------------------------------------
145	John	Russell	    JRUSSEL	    011.44.1344.429268	04/10/01	SA_MAN	14000	0.4	100	80
146	Karen	Partners	KPARTNER	011.44.1344.467268	05/01/05	SA_MAN	13500	0.3	100	80
147	Alberto	Errazuriz	AERRAZUR	011.44.1344.429278	05/03/10	SA_MAN	12000	0.3	100	80
148	Gerald	Cambrault	GCAMBRAU	011.44.1344.619268	07/10/15	SA_MAN	11000	0.3	100	80
149	Eleni	Zlotkey	    EZLOTKEY	011.44.1344.429018	08/01/29	SA_MAN	10500	0.2	100	80
*/


--7. 각 job 별 최대급여를 구하여 출력 job_id, job_title, job별 최대급여 조회
--19건
SELECT j.job_id
     , j.job_title
     , J.MAX_SALARY     
  FROM jobs j
;
/* JOB_ID, JOB_TITLE, MAX_SALARY
----------------------------------------------------
AD_PRES	    President	                    40000
AD_VP	    Administration Vice President	30000
AD_ASST 	Administration Assistant	    6000
FI_MGR	    Finance Manager	                16000
FI_ACCOUNT	Accountant	                    9000
AC_MGR	    Accounting Manager	            16000
AC_ACCOUNT	Public Accountant	            9000
SA_MAN	    Sales Manager	                20080
SA_REP	    Sales Representative	        12008
PU_MAN	    Purchasing Manager	            15000
PU_CLERK	Purchasing Clerk	            5500
ST_MAN	    Stock Manager	                8500
ST_CLERK	Stock Clerk	                    5000
SH_CLERK	Shipping Clerk	                5500
IT_PROG	    Programmer	                    10000
MK_MAN	    Marketing Manager	            15000
MK_REP	    Marketing Representative	    9000
HR_REP	    Human Resources Representative	9000
PR_REP	    Public Relations Representative	10500
*/
 
--8. 각 Job 별 최대급여를 받는 사람의 정보를 출력,
--  급여가 높은 순서로 출력
SELECT JOB_ID
     , MAX(salary)
  FROM employees
 GROUP BY JOB_ID
;
----서브쿼리 이용
SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME
     , e.LAST_NAME
     , e.EMAIL
     , e.HIRE_DATE
     , e.JOB_ID
     , e.SALARY
  FROM EMPLOYEES e
 WHERE (JOB_ID, salary) IN (SELECT JOB_ID
                                 , MAX(salary)
                              FROM employees
                             GROUP BY JOB_ID)
 ;
----join 이용

--20건

--9. 7번 출력시 job_id 대신 Job_name, manager_id 대신 Manager의 last_name, department_id 대신 department_name 으로 출력
--20건


--10. 전체 직원의 급여 평균을 구하여 출력


--11. 전체 직원의 급여 평균보다 높은 급여를 받는 사람의 목록 출력. 급여 오름차순 정렬
--51건

--12. 각 부서별 평균 급여를 구하여 출력
--12건

--13. 12번의 결과에 department_name 같이 출력
--12건


--14. employees 테이블이 각 job_id 별 인원수와 job_title을 같이 출력하고 job_id 오름차순 정렬


--15. employees 테이블의 job_id별 최저급여,
--   최대급여를 job_title과 함께 출력 job_id 알파벳순 오름차순 정렬


 
--16. Employees 테이블에서 인원수가 가장 많은 job_id를 구하고
--   해당 job_id 의 job_title 과 그 때 직원의 인원수를 같이 출력




--17.사번,last_name, 급여, 직책이름(job_title), 부서명(department_name), 부서매니저이름
--  부서 위치 도시(city), 나라(country_name), 지역(region_name) 을 출력
----------- 부서가 배정되지 않은 인원 고려 ------


--18.부서 아이디, 부서명, 부서에 속한 인원숫자를 출력



--19.인원이 가장 많은 상위 다섯 부서아이디, 부서명, 인원수 목록 출력


 
--20. 부서별, 직책별 평균 급여를 구하여라.
--   부서이름, 직책이름, 평균급여 소수점 둘째자리에서 반올림으로 구하여라.



--21.각 부서의 정보를 부서매니저 이름과 함께 출력(부서는 모두 출력되어야 함)


 
--22. 부서가 가장 많은 도시이름을 출력



--23. 부서가 없는 도시 목록 출력
--조인사용

--집합연산 사용

--서브쿼리 사용

  
--24.평균 급여가 가장 높은 부서명을 출력



--25. Finance 부서의 평균 급여보다 높은 급여를 받는 직원의 목록 출력


-- 26. 각 부서별 인원수를 출력하되, 인원이 없는 부서는 0으로 나와야 하며
--     부서는 정식 명칭으로 출력하고 인원이 많은 순서로 정렬.



--27. 지역별 등록된 나라의 갯수 출력(지역이름, 등록된 나라의 갯수)



 
--28. 가장 많은 나라가 등록된 지역명 출력
