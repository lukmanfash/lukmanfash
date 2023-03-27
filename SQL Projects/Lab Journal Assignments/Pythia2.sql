
DROP TABLE Enrollment CASCADE CONSTRAINTS;

DROP TABLE Section CASCADE CONSTRAINTS;


CREATE TABLE Enrollment
(
    Subject VARCHAR2(20)NOT NULL,
    No NUMBER NOT NULL,
    Section NUMBER NOT NULL,
    Student_id NUMBER,
    
    CONSTRAINT Enrollment_PK PRIMARY KEY (Subject, No, Section),
    
    CONSTRAINT Person_FK FOREIGN KEY (Student_id) REFERENCES Person (person_id)
);


CREATE TABLE Section
(
    Subject VARCHAR2(20)NOT NULL,
    No NUMBER NOT NULL,
    Section NUMBER NOT NULL,
    Title VARCHAR2(100),
    Credit_hours NUMBER(2,1),
    Instructor_id NUMBER,
    Days VARCHAR2(15),
    Start_time VARCHAR2(10),
    End_time VARCHAR2(10),
    
    CONSTRAINT Section_PK PRIMARY KEY (Subject,No,Section),
    
    CONSTRAINT Enrollment_FK FOREIGN KEY (Subject, No, Section) REFERENCES Enrollment (Subject, No, Section)
);