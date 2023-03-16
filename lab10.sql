set linesize 1000;
set pagesize 1000;

DROP VIEW CSCourse;
DROP VIEW MaleAAStudent;
DROP VIEW EnrolledNot1819;
DROP VIEW MinCreditCourse;
DROP VIEW CourseNotEnrolled2020;
DROP VIEW StudentCountCity;
DROP VIEW StudentCoursesCount5;
DROP VIEW CourseCountCS99;
DROP VIEW Level5Course;
DROP VIEW StudentCountCS;
DROP VIEW Enrolled2020MoreThan4;
DROP VIEW CourseEnrolledMaxFemaleDelhi;
DROP VIEW StudentGmailYahoo;
DROP VIEW StudentEnrolledAllCourse;
DROP TABLE Enrolled;
DROP TABLE Course;
DROP TABLE Student;

CREATE TABLE Student(RollNo varchar2(8), SName varchar2(20), 
Gender varchar2(1), City varchar2(20), PRIMARY KEY(RollNo));

INSERT INTO Student VALUES('1901CS99', 'Rahul', 'M', 'Kolkata');
INSERT INTO Student VALUES('1901CS98', 'Rajat', 'M', 'Bengalore');
INSERT INTO Student VALUES('1901CS97', 'Srishti', 'F', 'Chennai');
INSERT INTO Student VALUES('1901CS96', 'Ramesh', 'M', 'Hyderabad');
INSERT INTO Student VALUES('1901EC95', 'Rahul', 'M', 'Chennai');
INSERT INTO Student VALUES('1901CS94', 'Anya', 'F', 'Delhi');
INSERT INTO Student VALUES('1901CS93', 'Thanya', 'F', 'Delhi');

CREATE TABLE Course(CCode varchar2(5), CName varchar2(20), Credit number, PRIMARY KEY(CCode));

INSERT INTO Course VALUES('CS354', 'Database System', 4);
INSERT INTO Course VALUES('ME305', 'Eng. Mechanics', 3);
INSERT INTO Course VALUES('CS535', 'Operating System', 2);
INSERT INTO Course VALUES('CS356', 'Computer Networks', 3);
INSERT INTO Course VALUES('CS537', 'Compiler Design', 4);
INSERT INTO Course VALUES('CS538', 'Data Mining', 3);

CREATE TABLE Enrolled(RollNo varchar2(8), CCode varchar2(5), YoE number);

INSERT INTO Enrolled VALUES('1901CS93', 'CS354', 2019);
INSERT INTO Enrolled VALUES('1901CS94', 'CS354', 2020);
INSERT INTO Enrolled VALUES('1901CS97', 'CS354', 2020);
INSERT INTO Enrolled VALUES('1901CS97', 'CS356', 2020);
INSERT INTO Enrolled VALUES('1901CS97', 'CS537', 2020);
INSERT INTO Enrolled VALUES('1901CS97', 'ME305', 2020);
INSERT INTO Enrolled VALUES('1901CS94', 'CS535', 2019);
INSERT INTO Enrolled VALUES('1901CS97', 'CS535', 2020);
INSERT INTO Enrolled VALUES('1901CS99', 'CS535', 2021);
INSERT INTO Enrolled VALUES('1901CS96', 'CS537', 2019);
INSERT INTO Enrolled VALUES('1901CS96', 'CS354', 2019);
INSERT INTO Enrolled VALUES('1901CS96', 'ME305', 2019);
INSERT INTO Enrolled VALUES('1901CS96', 'CS535', 2019);
INSERT INTO Enrolled VALUES('1901CS96', 'CS538', 2019);
INSERT INTO Enrolled VALUES('1901CS96', 'CS356', 2019);

ALTER TABLE Enrolled ADD CONSTRAINT FK_Enrolled_Student FOREIGN KEY (RollNo) REFERENCES Student(RollNo);
ALTER TABLE Enrolled ADD CONSTRAINT FK_Enrolled_Course FOREIGN KEY (CCode) REFERENCES Course(CCode);

-- Question A
ALTER TABLE Course ADD CType varchar2(20);
ALTER TABLE Student ADD Email varchar2(30);
ALTER TABLE Student ADD CONSTRAINT UC_Email UNIQUE (Email);

UPDATE Course SET CType = 'Core' WHERE CCode = 'CS354';
UPDATE Course SET CType = 'Elective' WHERE CCode = 'ME305';
UPDATE Course SET CType = 'Open Elective' WHERE CCode = 'CS535';
UPDATE Course SET CType = 'Elective' WHERE CCode = 'CS356';
UPDATE Course SET CType = 'Open Elective' WHERE CCode = 'CS537';
UPDATE Course SET CType = 'Open Elective' WHERE CCode = 'CS538';

UPDATE Student SET Email = 'rahul@gmail.com' WHERE RollNo = '1901CS99';
UPDATE Student SET Email = 'rajat@yahoo.com' WHERE RollNo = '1901CS98';
UPDATE Student SET Email = 'srishti@outlook.com' WHERE RollNo = '1901CS97';
UPDATE Student SET Email = 'ramesh@proton.me' WHERE RollNo = '1901CS96';
UPDATE Student SET Email = 'rahul@yahoo.com' WHERE RollNo = '1901EC95';
UPDATE Student SET Email = 'anya@gmail.com' WHERE RollNo = '1901CS94';
UPDATE Student SET Email = 'thanya@outlook.com' WHERE RollNo = '1901CS93';

-- Question B
CREATE VIEW CSCourse AS
SELECT CName FROM Course WHERE CCode LIKE 'CS%';
SELECT * FROM CSCourse;

-- Question C
CREATE VIEW MaleAAStudent AS
SELECT SName FROM Student WHERE Gender = 'M' AND SName LIKE '%a%a%';
SELECT * FROM MaleAAStudent;

-- Question D
CREATE VIEW EnrolledNot1819 AS
SELECT RollNo FROM Enrolled WHERE YoE NOT BETWEEN 2018 AND 2019;
SELECT * FROM EnrolledNot1819;

-- Question E
CREATE VIEW MinCreditCourse AS
SELECT * FROM Course WHERE Credit = (SELECT MIN(Credit) FROM Course);
SELECT * FROM MinCreditCourse;

-- Question F
CREATE VIEW CourseNotEnrolled2020 AS
SELECT CName FROM Course WHERE CCode NOT IN (SELECT CCode FROM Enrolled WHERE YoE = 2020);
SELECT * FROM CourseNotEnrolled2020;

-- Question G
CREATE VIEW StudentCountCity AS
SELECT City, COUNT(*) AS CityCount FROM Student GROUP BY City;
SELECT * FROM StudentCountCity;

-- Question H
CREATE VIEW StudentCoursesCount5 AS
SELECT RollNo FROM Enrolled GROUP BY RollNo HAVING COUNT(CCode) = 5;
SELECT * FROM StudentCoursesCount5;

-- Question I
CREATE VIEW CourseCountCS99 AS
SELECT COUNT(CCode) AS CourseCount FROM Enrolled WHERE RollNo = '1901CS99';
SELECT * FROM CourseCountCS99;

--Question J
CREATE VIEW Level5Course AS
SELECT * FROM Course WHERE CCode LIKE '__5%';
SELECT * FROM Level5Course;

-- Question K
CREATE VIEW StudentCountCS AS
SELECT COUNT(RollNo) AS StudCount FROM Student WHERE RollNo LIKE '%CS%';
SELECT * FROM StudentCountCS;

-- Question L
CREATE VIEW Enrolled2020MoreThan4 AS
SELECT RollNo FROM Enrolled WHERE YoE = 2020 GROUP BY RollNo HAVING COUNT(CCode) > 4;
SELECT * FROM Enrolled2020MoreThan4;

-- Question M
CREATE VIEW CourseEnrolledMaxFemaleDelhi AS
WITH FemaleDelhiStudents AS (
    SELECT RollNo FROM Student WHERE Gender = 'F' AND City = 'Delhi'
),
MaxEnrollment AS (
    SELECT MAX(COUNT(*)) AS MaxCount
    FROM Enrolled
    WHERE RollNo IN (SELECT RollNo FROM FemaleDelhiStudents)
    GROUP BY CCode
)
SELECT CCode
FROM Enrolled
WHERE RollNo IN (SELECT RollNo FROM FemaleDelhiStudents)
GROUP BY CCode
HAVING COUNT(*) = (SELECT MaxCount FROM MaxEnrollment);
SELECT * FROM CourseEnrolledMaxFemaleDelhi;

-- Question N
CREATE VIEW StudentGmailYahoo AS
SELECT SName FROM Student WHERE Email LIKE '%@gmail.com' OR Email LIKE '%@yahoo.com';
SELECT * FROM StudentGmailYahoo;

-- Question O
CREATE VIEW StudentEnrolledAllCourse AS
SELECT SName FROM Student WHERE RollNo IN (
    SELECT RollNo FROM Enrolled GROUP BY RollNo
    HAVING COUNT(CCode) = (SELECT COUNT(*) FROM Course)
);
SELECT * FROM StudentEnrolledAllCourse;

