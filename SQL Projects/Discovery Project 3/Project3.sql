--------------------------------------------------------
--  DROP Tables
--------------------------------------------------------
DROP TABLE ACTIVITY cascade constraints PURGE;
DROP TABLE VOLUNTEER_WORK cascade constraints PURGE;
DROP TABLE STUDENT_GUARDIAN cascade constraints PURGE;
DROP TABLE STUDENT_EXAM cascade constraints PURGE;
DROP TABLE STUDENT cascade constraints PURGE;
DROP TABLE SCHOOL_ATTEND cascade constraints PURGE;
DROP TABLE SCHOOL_APPLY cascade constraints PURGE;
DROP TABLE GUARDIAN cascade constraints PURGE;
DROP TABLE SCHOOL cascade constraints PURGE;
DROP TABLE EXAM cascade constraints PURGE;
--------------------------------------------------------
--  DDL for Table STUDENT
--------------------------------------------------------

  CREATE TABLE STUDENT 
   (	STUDENT_ID NUMBER(38), 
      FIRST_NAME VARCHAR2(255), 
      LAST_NAME VARCHAR2(255), 
      SSN CHAR(9), 
      GENDER CHAR(1), 
      STREET_ADDR VARCHAR2(255), 
      STREET_ADDR2 VARCHAR2(255), 
      CITY VARCHAR2(255), 
      STATE CHAR(2), 
      ZIP CHAR(5), 
      PHONE CHAR(10), 
      GRADE_LEVEL NUMBER(38), 
      ENROLL_DATE DATE, 
      END_DATE DATE, 
      END_REASON VARCHAR2(255), 
      COMMENTS VARCHAR2(255),
      UNIQUE(SSN),
      CONSTRAINT STUDENT_PK PRIMARY KEY (STUDENT_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table GUARDIAN
--------------------------------------------------------

  CREATE TABLE GUARDIAN 
   (	GUARDIAN_ID NUMBER(38), 
      FIRST_NAME VARCHAR2(255), 
      LAST_NAME VARCHAR2(255), 
      STREET_ADDR VARCHAR2(255), 
      STREET_ADDR2 VARCHAR2(255), 
      CITY VARCHAR2(255), 
      STATE CHAR(2), 
      ZIP CHAR(5), 
      PHONE CHAR(10),
      CONSTRAINT GUARDIAN_PK PRIMARY KEY (GUARDIAN_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table SCHOOL
--------------------------------------------------------

  CREATE TABLE SCHOOL 
   (	SCHOOL_ID NUMBER(38), 
      NAME VARCHAR2(255), 
      CITY VARCHAR2(255), 
      STATE CHAR(2), 
      TYPE CHAR(1),
      CONSTRAINT SCHOOL_PK PRIMARY KEY (SCHOOL_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table EXAM
--------------------------------------------------------

  CREATE TABLE EXAM 
   (	EXAM_ID NUMBER(38), 
      NAME VARCHAR2(50), 
      ABBR VARCHAR2(10), 
      EXAM_LEVEL CHAR(1),
      CONSTRAINT EXAM_PK PRIMARY KEY (EXAM_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table ACTIVITY
--------------------------------------------------------

  CREATE TABLE ACTIVITY 
   (	STUDENT_ID NUMBER(38), 
      ACTIVITY_ID NUMBER(38), 
      DESCRIPTION VARCHAR2(255), 
      START_DATE DATE, 
      END_DATE DATE, 
      COMMENTS VARCHAR2(255),
      CONSTRAINT ACTIVITY_PK PRIMARY KEY (STUDENT_ID, ACTIVITY_ID),
      CONSTRAINT FK_ACTIVITY_STUDENT_ID FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT (STUDENT_ID)
   ) ;
   SELECT COUNT (*)
   FROM Student;
/
--------------------------------------------------------
--  DDL for Table VOLUNTEER_WORK
--------------------------------------------------------

  CREATE TABLE VOLUNTEER_WORK 
   (	STUDENT_ID NUMBER(38), 
      VOLUNTEER_WORK_ID NUMBER(38), 
      DESCRIPTION VARCHAR2(255), 
      START_DATE DATE, 
      END_DATE DATE, 
      ASSIGNED_BY VARCHAR2(255), 
      COMMENTS CLOB,
      CONSTRAINT VOLUNTEER_WORK_PK PRIMARY KEY (STUDENT_ID, VOLUNTEER_WORK_ID),
      CONSTRAINT FK_VOLUNTEER_WORK_STUDENT_ID FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT (STUDENT_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table STUDENT_GUARDIAN
--------------------------------------------------------

  CREATE TABLE STUDENT_GUARDIAN 
   (	STUDENT_ID NUMBER(38), 
      GUARDIAN_ID NUMBER(38), 
      RELATION VARCHAR2(255),
      CONSTRAINT STUDENT_GUARDIAN_PK PRIMARY KEY (STUDENT_ID, GUARDIAN_ID),
      CONSTRAINT FK_STUDENT_GUARDIAN_STUDENT_ID FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT (STUDENT_ID),
      CONSTRAINT FK_STUDENT_GUARDIAN_G_ID FOREIGN KEY (GUARDIAN_ID)
        REFERENCES GUARDIAN (GUARDIAN_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table STUDENT_EXAM
--------------------------------------------------------

  CREATE TABLE STUDENT_EXAM 
   (	STUDENT_ID NUMBER(38), 
      EXAM_ID NUMBER(38), 
      TEST_DATE DATE, 
      SCORE NUMBER(38),
      CONSTRAINT STUDENT_EXAM_PK PRIMARY KEY (STUDENT_ID, EXAM_ID, TEST_DATE),
      CONSTRAINT FK_STUDENT_EXAM_EXAM_ID FOREIGN KEY (EXAM_ID)
        REFERENCES EXAM (EXAM_ID),
      CONSTRAINT FK_STUDENT_EXAM_STUDENT_ID FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT (STUDENT_ID)
   ) ;
/

--------------------------------------------------------
--  DDL for Table SCHOOL_ATTEND
--------------------------------------------------------

  CREATE TABLE SCHOOL_ATTEND 
   (	STUDENT_ID NUMBER(38), 
      SCHOOL_ID NUMBER(38), 
      ENROLL_DATE DATE, 
      END_DATE DATE, 
      END_REASON VARCHAR2(255),
      CONSTRAINT SCHOOL_ATTEND_PK PRIMARY KEY (STUDENT_ID, SCHOOL_ID),
      CONSTRAINT FK_SCHOOL_ATTEND_SCHOOL_ID FOREIGN KEY (SCHOOL_ID)
        REFERENCES SCHOOL (SCHOOL_ID),
      CONSTRAINT FK_SCHOOL_ATTEND_STUDENT_ID FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT (STUDENT_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table SCHOOL_APPLY
--------------------------------------------------------

  CREATE TABLE SCHOOL_APPLY 
   (	STUDENT_ID NUMBER(38), 
      SCHOOL_ID NUMBER(38), 
      DECISION VARCHAR2(255),
      CONSTRAINT SCHOOL_APPLY_PK PRIMARY KEY (STUDENT_ID, SCHOOL_ID),
      CONSTRAINT FK_SCHOOL_APPLY_SCHOOL_ID FOREIGN KEY (SCHOOL_ID)
        REFERENCES SCHOOL (SCHOOL_ID),
      CONSTRAINT FK_SCHOOL_APPLY_STUDENT_ID FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT (STUDENT_ID)
   ) ;
/

  ALTER TABLE ACTIVITY DISABLE CONSTRAINT FK_ACTIVITY_STUDENT_ID;
  ALTER TABLE VOLUNTEER_WORK DISABLE CONSTRAINT FK_VOLUNTEER_WORK_STUDENT_ID;
  ALTER TABLE STUDENT_GUARDIAN DISABLE CONSTRAINT FK_STUDENT_GUARDIAN_STUDENT_ID;
  ALTER TABLE STUDENT_GUARDIAN DISABLE CONSTRAINT FK_STUDENT_GUARDIAN_G_ID;
  ALTER TABLE STUDENT_EXAM DISABLE CONSTRAINT FK_STUDENT_EXAM_EXAM_ID;
  ALTER TABLE STUDENT_EXAM DISABLE CONSTRAINT FK_STUDENT_EXAM_STUDENT_ID;
  ALTER TABLE SCHOOL_ATTEND DISABLE CONSTRAINT FK_SCHOOL_ATTEND_SCHOOL_ID;
  ALTER TABLE SCHOOL_ATTEND DISABLE CONSTRAINT FK_SCHOOL_ATTEND_STUDENT_ID;
  ALTER TABLE SCHOOL_APPLY DISABLE CONSTRAINT FK_SCHOOL_APPLY_SCHOOL_ID;
  ALTER TABLE SCHOOL_APPLY DISABLE CONSTRAINT FK_SCHOOL_APPLY_STUDENT_ID;
/

  INSERT INTO ACTIVITY SELECT * FROM ACADEMY_PREP.ACTIVITY;
  INSERT INTO EXAM SELECT * FROM ACADEMY_PREP.EXAM;
  INSERT INTO GUARDIAN SELECT * FROM ACADEMY_PREP.GUARDIAN;
  INSERT INTO SCHOOL SELECT * FROM ACADEMY_PREP.SCHOOL;
  INSERT INTO SCHOOL_APPLY SELECT * FROM ACADEMY_PREP.SCHOOL_APPLY;
  INSERT INTO SCHOOL_ATTEND SELECT * FROM ACADEMY_PREP.SCHOOL_ATTEND;
  INSERT INTO STUDENT SELECT * FROM ACADEMY_PREP.STUDENT;
  INSERT INTO STUDENT_EXAM SELECT * FROM ACADEMY_PREP.STUDENT_EXAM;
  INSERT INTO STUDENT_GUARDIAN SELECT * FROM ACADEMY_PREP.STUDENT_GUARDIAN;
  INSERT INTO VOLUNTEER_WORK SELECT * FROM ACADEMY_PREP.VOLUNTEER_WORK;
/
  ALTER TABLE ACTIVITY ENABLE CONSTRAINT FK_ACTIVITY_STUDENT_ID;
  ALTER TABLE VOLUNTEER_WORK ENABLE CONSTRAINT FK_VOLUNTEER_WORK_STUDENT_ID;
  ALTER TABLE STUDENT_GUARDIAN ENABLE CONSTRAINT FK_STUDENT_GUARDIAN_STUDENT_ID;
  ALTER TABLE STUDENT_GUARDIAN ENABLE CONSTRAINT FK_STUDENT_GUARDIAN_G_ID;
  ALTER TABLE STUDENT_EXAM ENABLE CONSTRAINT FK_STUDENT_EXAM_EXAM_ID;
  ALTER TABLE STUDENT_EXAM ENABLE CONSTRAINT FK_STUDENT_EXAM_STUDENT_ID;
  ALTER TABLE SCHOOL_ATTEND ENABLE CONSTRAINT FK_SCHOOL_ATTEND_SCHOOL_ID;
  ALTER TABLE SCHOOL_ATTEND ENABLE CONSTRAINT FK_SCHOOL_ATTEND_STUDENT_ID;
  ALTER TABLE SCHOOL_APPLY ENABLE CONSTRAINT FK_SCHOOL_APPLY_SCHOOL_ID;
  ALTER TABLE SCHOOL_APPLY ENABLE CONSTRAINT FK_SCHOOL_APPLY_STUDENT_ID;
/



------------Part 1: Modifying Data---
-----Question Q1) Student Record Update: Justin Haberman’s name as Justin Haberman-McHadden
 
 UPDATE Student
    SET Last_Name = 'Haberman-McHadden'
 WHERE Student_ID = 10390;
 COMMIT;
 
 SELECT * FROM Student WHERE Student_ID = 10390;
 
 
-----Question Q2) Students' SSAT test scores:-----a,b,c) 
---Question Q2a---
 INSERT INTO STUDENT_EXAM (Student_ID, Exam_ID, Test_Date, Score) VALUES (46, 0, '14-MAR-2011', 924);
 
---Question Q2b---
 INSERT INTO STUDENT_EXAM (Student_ID, Exam_ID, Test_Date, Score) VALUES (1850, 0, '14-MAR-2011', 1232);
 
 ---Question Q2c---
 INSERT INTO STUDENT_EXAM (Student_ID, Exam_ID, Test_Date, Score) VALUES (2844, 0, '14-MAR-2011', 1109);
 COMMIT;
---Confirming my result, for example---
SELECT * FROM STUDENT_EXAM WHERE (student_id = 2844 AND TEST_DATE = '14-MAR-2011');



-----Question Q3) Removing Anne Benjamin (student ID 18949):----
DELETE FROM STUDENT
 WHERE Student_id = 18949;
 
 ----Failed execution
 ---Error report - ORA-02292: integrity constraint (FASHINAL.FK_ACTIVITY_STUDENT_ID) violated - child record found
 --- Possible Reason:  
    
    
    
---- Question 4) Updating Antony Podaras (student ID 1007)school attendance---
----Question 4a) Update Antony’s school attendance for the University of Miami to have an end date of 12-20-2010 and an end reason of Transfer
UPDATE SCHOOL_Attend
    SET End_Date = '20-DEC-2010',
        End_Reason = 'Transferred'
    WHERE (STUDENT_ID=1007 AND  SCHOOL_ID = 12106);
---Confirming my output---
Select * from School_Attend where (STUDENT_ID=1007 AND  SCHOOL_ID = 12106);

 
  
----Question 4b) Add a new school attendance for Antony for the University of South Florida with a start date of 01-15-2011---
INSERT INTO SCHOOL_ATTEND (STUDENT_ID, SCHOOL_ID, ENROLL_DATE) VALUES (1007, 12460, '15-JAN-2011');
COMMIT;

---- CONFIRMING MY RESULT OF 4b---
 SELECT * FROM SCHOOL_ATTEND
  WHERE (SCHOOL_ID = 12460 AND STUDENT_ID=1007);


------Question 5. Carlie Goldsmith (student ID 8992) has received a new legal guardian.----
---Question 5a) Enter Margaret Yuters details as a new guardian
INSERT INTO GUARDIAN (GUARDIAN_ID, FIRST_NAME, LAST_NAME, STREET_ADDR, CITY, STATE, ZIP, PHONE) VALUES (22583, 'Margaret', 'Yuters', '1382 N. 5th Ave.', 'Sarasota', 'FL', 34234, 9413411961);
COMMIT;

----Question 5b) Associate Margaret as being Carlie’s new Legal Guardian----
 UPDATE STUDENT_GUARDIAN
    SET GUARDIAN_ID = 22583
    WHERE (GUARDIAN_ID = 9914 AND STUDENT_ID=8992);
---- CONFIRMING THE RESULT OF 5b STATEMENT---
 SELECT * FROM STUDENT_GUARDIAN WHERE GUARDIAN_ID=9914;
  
  
  
  
  
---Part 2---
----Question 1)Table(s) used: EXAM & STUDENT_EXAM---
SELECT EXAM.NAME, AVG(SCORE), COUNT (STUDENT_EXAM.STUDENT_ID)
        FROM STUDENT_EXAM, EXAM 
    WHERE STUDENT_EXAM.EXAM_ID=EXAM.EXAM_ID
    AND TEST_DATE >= '01-JAN-2006'
    GROUP BY EXAM.NAME
    ORDER BY COUNT(STUDENT_EXAM.EXAM_ID) DESC;
---Part 2: Q1 Answered---
 
  
  
---Part 2 Question 2)Table(s) used: STUDENT, SCHOOL_APPLY and SCHOOL---
select s.last_name, s.first_name, count(*) from student s
join school_apply sa on sa.student_id=s.student_id
join school sch on sch.school_id=sa.school_id
    where s.grade_level= 8 and sa.decision='accepted'
    group by s.last_name, s.first_name
    having count(*)<=2 
    ORDER BY COUNT(*) DESC, s.last_name, s.first_name;
---Part 2: Q2 Answered---
    
    
---Part 2 Question 3)Table(s) used: STUDENT, SCHOOL and SCHOOL_ATTEND----/
select sch.name, s.last_name, s.first_name
from student s, school_attend sa, school sch 
where s.student_id=sa.student_id
 and sch.school_id=sa.school_id
 and s.end_date >= '01-JAN-2006'
 and sa.end_date is null
 and sch.state = 'GA';
---Part 2: Q3 Answered---

---Part 2 Question 4)Table(s) used: Student & Voluteeer Work---
select s.first_name, s.last_name, description, (vw.end_date - vw.start_date)days_on_volunteer_work 
from student s, volunteer_work vw
where s.student_id=vw.student_id
and (vw.end_date - vw.start_date) between 30 and 90
and grade_level = 5
Order by (vw.end_date - vw.start_date) Desc;
---Part 2: Q4 Answered---


---Part 2 Question 5)Table(s) used: Student, Student_Guardian & Guardian---
Select RTRIM(s.last_name) || '' || RTRIM(s.first_name) as student_name, RTRIM(g.last_name) || '' || RTRIM(g.first_name) as guardian_name, sg.relation 
from student s 
join student_guardian sg on s.student_id=sg.student_id 
join guardian g on g.guardian_id=sg.guardian_id 
where s.end_date is null  
and s.city<>g.city  
and (sg.relation = 'Foster Father' or sg.relation = 'Foster Mother')
order by (student_name) Asc; 

---2nd Approach----

Select RTRIM(s.last_name) || '' || RTRIM(s.first_name) as student_name, RTRIM(g.last_name) || '' || RTRIM(g.first_name) as guardian_name, sg.relation 
from student s, student_guardian sg, guardian g
where s.student_id=sg.student_id 
   and g.guardian_id=sg.guardian_id 
   and s.end_date is null  
   and s.city<>g.city 
   and (sg.relation = 'Foster Mother' or sg.relation = 'Foster Father')
   order by (student_name) Asc;
---Part 2: Q5 Answered---

    

---Part 2 Question 6)Table(s) used: Student---
select grade_level, last_name, first_name, phone
    from student s
    where grade_level between 1 and 8
    Order by grade_level, last_name, first_name;
---Part 2: Q6 Answered---



---Part 2 Question 7)Table(s) used: Student---
select grade_level students_per_grade_level, count(*) 
    from student
    where grade_level between 1 and 8
    Group by grade_level
    Order by grade_level;
---Part 2: Q7 Answered---