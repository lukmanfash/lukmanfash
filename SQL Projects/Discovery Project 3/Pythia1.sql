SELECT * FROM SCHOOL_ATTEND WHERE STUDENT_ID= 1007;


UPDATE SCHOOL_Attend
   SET End_Date = '20-DEC-2010'
 WHERE (SCHOOL_ID = 12106 AND STUDENT_ID=1007);
  ROLLBACK;
 
 SELECT * FROM SCHOOL_ATTEND
  WHERE (SCHOOL_ID = 12106 AND STUDENT_ID=1007);
  
  Student_id = 1007
  
SELECT * FROM GUARDIAN
   WHERE GUARDIAN_ID=22583;
 
 
    ---Part 2: (Q2)Tables used: STUDENT & SCHOOL_APPLY---
 SELECT STUDENT.LAST_NAME, STUDENT.FIRST_NAME,COUNT(SCHOOL_APPLY.DECISION), COUNT(SCHOOL_APPLY.SCHOOL_ID)
        FROM STUDENT, SCHOOL_APPLY 
    WHERE STUDENT.STUDENT_ID=SCHOOL_APPLY.STUDENT_ID
        AND GRADE_LEVEL= '8'
        AND DECISION = 'ACCEPTED'
    GROUP BY 'SCHOOL_APPLY.DECISION', AND 'SCHOOL_APPLY.SCHOOL_ID'
    HAVING SUM(DECISION) <='2';
/---MISSING EXPRESSION ERROR--/
 
 
 
 
SELECT NAME, 
       SCORE,
       STUDENT_EXAM.EXAM_ID, 
      STUDENT_ID, 
      TEST_DATE
    FROM STUDENT_EXAM, EXAM
    WHERE EXAM.EXAM_ID = STUDENT_EXAM.EXAM_ID
    AND TEST_DATE >= '01-JAN-2006'
    GROUP BY NAME;
    
    
---GROUPING--
SELECT STUDENT_EXAM.EXAM_ID, NAME, SCORE
    FROM STUDENT_EXAM, EXAM
    WHERE EXAM.EXAM_ID = STUDENT_EXAM.EXAM_ID
    AND TEST_DATE >= '01-JAN-2006'
    GROUP BY NAME AS NAME;





SELECT EXAM_ID, NAME, TEST DATE
    FROM STUDENT_EXAM, EXAM;
       AVG(SCORE)
    FROM STUDENT_EXAM;
    
    
--/ SOLUTION TO PART2 Q1../
SELECT EXAM.NAME, AVG(SCORE), COUNT (STUDENT_EXAM.STUDENT_ID)
        FROM STUDENT_EXAM, EXAM 
    WHERE STUDENT_EXAM.EXAM_ID=EXAM.EXAM_ID
    AND TEST_DATE >= '01-JAN-2006'
    GROUP BY EXAM.NAME
    ORDER BY COUNT(STUDENT_EXAM.EXAM_ID) DESC;
    
    
    
select s.last_name, s.first_name, count(*) from student s
join school_apply sa on sa.student_id=s.student_id
join school sch on sch.school_id=sa.school_id
    where s.grade_level= 8 and sa.decision='accepted'
    group by s.last_name, s.first_name
    having count(*)<=2;
    
    
    
    
--Trying to count the numb of accptance--
select student.last_name, student.first_name, decision count (*) 
    from Student, school_apply
    Where student.student_id=school_apply.student_id
          school_apply.Decision='Accepted'
          group by school_apply.Decision
    /---/error
    
          
    --Q3---
select * from school sch;

select last_name, first_name, count (*) 
        from school sch
        where State='GA'
        Group by last_name, first_name;
        
        
select s.last_name, s.first_name, sch.name
    from student s, School sch, School_Attend sa
    where s.Student_id=sa_student_id;
    and where sa.School_id=sch.school_id;
 where Name='AP';
    Where sa.Student_id=s.student_id;





from school
        where Name ='AP';
        Group by last_name, first_name;
    
Describe Activity;



