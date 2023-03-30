DROP TABLE student;
DROP TABLE department;
DROP TABLE professor;
DROP TABLE enrollment;
DROP TABLE teaching;
DROP TABLE prof02;
DROP TABLE prof02join;
DROP TABLE enroll02;

CREATE TABLE student(
    rollNo VARCHAR2(10),
    name VARCHAR2(20),
    degree VARCHAR2(10),
    year VARCHAR2(4),
    sex VARCHAR2(1),
    deptNo VARCHAR2(4),
    advisor VARCHAR2(10)
);

CREATE TABLE department(
    deptId VARCHAR2(4),
    name VARCHAR2(20),
    hod VARCHAR2(10),
    phone VARCHAR2(10)
);

CREATE TABLE professor(
    empId VARCHAR2(10),
    name VARCHAR2(20),
    sex VARCHAR2(1),
    startYear NUMBER(4),
    deptNo VARCHAR2(4),
    phone VARCHAR2(10)
);

CREATE TABLE enrollment(
    rollNo VARCHAR2(10),
    courseId VARCHAR2(5),
    sem VARCHAR2(4),
    year VARCHAR2(4),
    grade VARCHAR2(1)
);

CREATE TABLE teaching(
    empId VARCHAR2(10),
    courseId VARCHAR2(5),
    sem VARCHAR2(4),
    year VARCHAR2(4),
    classRoom VARCHAR2(5)
);

INSERT INTO student VALUES('CS02B2018', 'Abhishek', 'B.Tech', '2002', 'M', '001', 'CS01');

INSERT INTO department VALUES('001', 'Computer Science', 'CS01', '1234567890');

INSERT INTO professor VALUES('CS01', 'Masilamani', 'M', '2000', '001', '1234567899');
INSERT INTO professor VALUES('CS02', 'Rajesh', 'M', '2000', '001', '1234567888');

INSERT INTO enrollment VALUES('CS02B2018', 'CS101', 'Even', '2002', 'S');

insert into teaching values('CS01', 'CS101', 'Even', '2002', 'H01');



-- Question 1
SELECT name, rollNo FROM student
WHERE advisor IN (
    SELECT hod FROM department WHERE name = 'Computer Science'
);


-- Question 2
CREATE TABLE prof02 AS
SELECT empId FROM teaching WHERE year = 2002;

CREATE TABLE prof02join AS
SELECT p.name, p.startYear FROM professor p INNER JOIN prof02 p02 ON p.empId = p02.empId;

SELECT * FROM prof02join WHERE startYear = (
    SELECT MIN(startYear) FROM prof02join
);


-- Question 3
CREATE TABLE enroll02 AS
SELECT * FROM enrollment WHERE year = 2002;

SELECT DISTINCT rollNo FROM enroll02
MINUS
SELECT DISTINCT rollNO FROM enroll02 WHERE grade != 'S';