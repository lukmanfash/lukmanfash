 SELECT * FROM Student_Exam;
 
 SELECT COUNT (*) From Student_Exam;
 
 SELECT Name From Exam;
 
 SELECT Avg (Score) As "Exam Avg Score" 
    From Student_Exam;
 
 SELECT * From Student_Exam
    where Exam_ID = 1;
 
 SELECT COUNT (*) From Student_Exam
    where Exam_ID = 1;
    
SELECT AVG(score)from Student_Exam
    WHERE EXAM_ID IN (2);
    

SELECT COUNT (DISTINCT(STUDENT_ID)) FROM STUDENT_EXAM;


SELECT NAME, SCORE,STUDENT_EXAM.EXAM_ID, STUDENT_ID, TEST_DATE
    FROM STUDENT_EXAM, EXAM
    WHERE EXAM.EXAM_ID = STUDENT_EXAM.EXAM_ID
    AND TEST_DATE >= '01-JAN-2006';

SELECT COUNT(EXAM_ID)
    WHERE NAME= SAT, OR NAME=ACT, OR NAME= S
    FROM EXAM;