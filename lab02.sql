CREATE TABLE student(rollno VARCHAR2(9),name VARCHAR2(20),degree VARCHAR2(5),year NUMBER(4),sex VARCHAR2(10),deptno VARCHAR2(3),advisor VARCHAR2(20),phone NUMBER(10));

INSERT ALL
INTO student VALUES ('CS21B2018', 'Abhishek', 'BTech', 2021, 'Male', 'D01', 'Preeth', '8732911221')
INTO student VALUES ('CS22M2019', 'John', 'MTech', 2022, 'Male', 'D01', 'James', '8732911222')
INTO student VALUES ('EC21B2020', 'Sophie', 'BTech', 2021, 'Female', 'D02', 'Robert', '8732911223')
INTO student VALUES ('ME21M2021', 'Emily', 'MTech', 2021, 'Female', 'D04', 'Michael', '8732911224')
INTO student VALUES ('EE21B2022', 'Jacob', 'BTech', 2021, 'Male', 'D03', 'David', '8732911225')
INTO student VALUES ('CV21M2023', 'Isabella', 'MTech', 2021, 'Female', 'D05', 'Christopher', '8732911226')
INTO student VALUES ('CH21B2024', 'Lucas', 'BTech', 2021, 'Male', 'D06', 'Brian', '8732911227')
SELECT 1 FROM dual;

CREATE TABLE department(deptno varchar2(3),name varchar2(10),hod varchar2(20),phone NUMBER(10));

INSERT ALL
INTO department VALUES('D01','CSE','Dr. Sadagopan',8730129912)
INTO department VALUES('D02','ECE','Dr. Srinivasan',8730129913)
INTO department VALUES('D03','EEE','Dr. Mahesh',8730129914)
INTO department VALUES('D04','MECH','Dr. Suresh',8730129915)
INTO department VALUES('D05','CIVIL','Dr. Ramesh',8730129916)
INTO department VALUES('D06','CHEM','Dr. Sathish',8730129917)
INTO department VALUES('D07','MATH','Dr. Sivakumar',8730129918)
SELECT 1 FROM dual;

CREATE TABLE professor(empid VARCHAR2(10),name VARCHAR2(20),sex VARCHAR2(10),startyear NUMBER(4),deptno VARCHAR2(3),phone VARCHAR2(10));

INSERT ALL
INTO professor VALUES('CS001', 'Dr. Sadagopan', 'Male', 1990, 'D01', '8730129912')
INTO professor VALUES('EC002', 'Dr. Srinivasan','Male', 1993, 'D02', '8730129913')
INTO professor VALUES('CS003', 'Dr. Anuja', 'Female', 1995, 'D01', '8730129814')
INTO professor VALUES('EE004', 'Dr. Mahesh', 'Male', 1996, 'D03', '8730129914')
INTO professor VALUES('ME005', 'Dr. Suresh', 'Male', 1993, 'D04', '8730129915')
INTO professor VALUES('CV003', 'Dr. Ramesh', 'Male', 1995, 'D05', '8730129916')
INTO professor VALUES('CH003', 'Dr. Sathish', 'Male', 2000, 'D06', '8730129916')
SELECT 1 FROM dual;

CREATE TABLE course(courseid varchar2(5),cname varchar2(20),credits number(2),deptno VARCHAR2(3));

INSERT ALL
INTO course VALUES('CS101','Intro to CS',4,'D01')
INTO course VALUES('CS102','Data Structures',4,'D01')
INTO course VALUES('CS103','Algorithms',4,'D01')
INTO course VALUES('EC101', 'Intro to ECE', 4, 'D02')
INTO course VALUES('EC102', 'Microprocessors', 4, 'D02')
INTO course VALUES('EC103', 'Digital Logic', 4, 'D02')
INTO course VALUES('ME101', 'Intro to ME', 4, 'D03')
INTO course VALUES('ME102', 'Thermodynamics', 4, 'D03')
INTO course VALUES('ME103', 'Fluid Mechanics', 4, 'D03')
SELECT 1 FROM dual;


CREATE TABLE enrollment(rollno VARCHAR2(9),courseid VARCHAR2(5),sem NUMBER(1),year NUMBER(4),grade VARCHAR2(1));

INSERT ALL
INTO enrollment VALUES('CS21B2018', 'CS101', 1, 2021, 'A')
INTO enrollment VALUES('CS21B2018', 'CS102', 2, 2021, 'B')
INTO enrollment VALUES('CS21B2018', 'CS103', 3, 2022, 'S')
INTO enrollment VALUES('EC21B2020', 'EC101', 1, 2021, 'A')
INTO enrollment VALUES('EC21B2020', 'EC102', 2, 2021, 'B')
INTO enrollment VALUES('EC21B2020', 'EC103', 3, 2022, 'S')
INTO enrollment VALUES('ME21M2021', 'ME101', 1, 2021, 'A')
INTO enrollment VALUES('ME21M2021', 'ME102', 2, 2021, 'B')
INTO enrollment VALUES('ME21M2021', 'ME103', 3, 2022, 'S')
SELECT 1 FROM dual;

CREATE TABLE teaching (empid VARCHAR2(10),courseid VARCHAR2(5),sem NUMBER(1),year NUMBER(4),classroom VARCHAR2(3));

INSERT ALL
INTO teaching VALUES('CS001', 'CS101', 1, 2021, 'H01')
INTO teaching VALUES('CS003', 'CS102', 2, 2021, 'H13')
INTO teaching VALUES('EC002', 'EC101', 1, 2021, 'H24')
INTO teaching VALUES('EE004', 'EC102', 3, 2022, 'H21')
INTO teaching VALUES('ME005', 'ME101', 1, 2021, 'H02')
INTO teaching VALUES('ME005', 'ME102', 3, 2022, 'H03')
SELECT 1 FROM dual;

CREATE TABLE prerequisite (precourseid VARCHAR2(5),courseid VARCHAR2(5));

INSERT ALL
INTO prerequisite VALUES('CS101', 'CS102')
INTO prerequisite VALUES('CS101', 'CS103')
INTO prerequisite VALUES('EC101', 'EC102')
INTO prerequisite VALUES('EC101', 'EC103')
INTO prerequisite VALUES('ME101', 'ME102')
INTO prerequisite VALUES('ME101', 'ME103')
SELECT 1 FROM dual;


SELECT * FROM student;
SELECT * FROM department;
SELECT * FROM course;
SELECT * FROM professor;
SELECT * FROM enrollment;
SELECT * FROM teaching;
SELECT * FROM prerequisite;


-- after two year three student left the college. Update all the tables accordingly
DELETE FROM student WHERE rollno = 'CV21M2023';
DELETE FROM student WHERE rollno = 'CH21B2024';
DELETE FROM student WHERE rollno = 'EE21B2022';


-- missing column email-id is added to student, professor table
ALTER TABLE student ADD email VARCHAR2(30);
UPDATE student SET email = 'cs21b2018@iiitdm.ac.in' WHERE rollno = 'CS21B2018';
UPDATE student SET email = 'cs22m2019@iiitdm.ac.in' WHERE rollno = 'CS22M2019';
UPDATE student SET email = 'ec21b2020@iiitdm.ac.in' WHERE rollno = 'EC21B2020';
UPDATE student SET email = 'me21b2021@iiitdm.ac.in' WHERE rollno = 'ME21M2021';

ALTER TABLE professor ADD email VARCHAR2(30);
UPDATE professor SET email = 'sadagopan@iiitdm.ac.in' WHERE empid = 'CS001';
UPDATE professor SET email = 'srinivasan@iiitdm.ac.in' WHERE empid = 'EC002';
UPDATE professor SET email = 'anuja@iiitdm.ac.in' WHERE empid = 'CS003';
UPDATE professor SET email = 'mahesh@iiitdm.ac.in' WHERE empid = 'EE004';
UPDATE professor SET email = 'suresh@iiitdm.ac.in' WHERE empid = 'ME005';
UPDATE professor SET email = 'ramesh@iiitdm.ac.in' WHERE empid = 'CV003';
UPDATE professor SET email = 'sathish@iiitdm.ac.in' WHERE empid = 'CH003';


-- after 3 years four hod has changed
UPDATE department SET hod = 'Dr. Suresh' WHERE deptno = 'D01';
UPDATE department SET hod = 'Dr. Ramesh' WHERE deptno = 'D02';
UPDATE department SET hod = 'Dr. Sathish' WHERE deptno = 'D03';
UPDATE department SET hod = 'Dr. Anuja' WHERE deptno = 'D04';


-- 3 students and 2 professors have changed their phone numbers
UPDATE student SET phone = '8732911228' WHERE rollno = 'CS21B2018';
UPDATE student SET phone = '8732911229' WHERE rollno = 'CS22M2019';
UPDATE student SET phone = '8732911230' WHERE rollno = 'EC21B2020';
UPDATE professor SET phone = '8730129917' WHERE empid = 'CS001';
UPDATE professor SET phone = '8730129918' WHERE empid = 'EC002';

SELECT * FROM student;
SELECT * FROM department;
SELECT * FROM professor;