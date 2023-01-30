DROP TABLE committees;
DROP TABLE member;

CREATE TABLE committees(committee_id VARCHAR2(6), name VARCHAR2(20));
CREATE TABLE member(member_id VARCHAR2(6), name VARCHAR2(20));

INSERT INTO committees VALUES('101', 'Ramesh');
INSERT INTO committees VALUES('102', 'Suresh');
INSERT INTO committees VALUES('103', 'Hritik');

INSERT INTO member VALUES('m101', 'Ramesh');
INSERT INTO member VALUES('m102', 'Suresh');
INSERT INTO member VALUES('m103', 'Rakesh');

-- Question 1
-- a. Find Name of person in committees who is not a member
SELECT committees.name FROM committees
LEFT JOIN member
    ON committees.name = member.name
WHERE member.name IS NULL;

-- b. Find the Name of member who is not in committees list
SELECT member.name FROM member
LEFT JOIN committees
    ON member.name = committees.name
WHERE committees.name IS NULL;

-- c. Find the name of person in committees having same age
--    (Add column age in committees and set value 20,20,30 respectively)
ALTER TABLE committees ADD age NUMBER(2);
UPDATE committees SET age = 20 WHERE committee_id = '101';
UPDATE committees SET age = 20 WHERE committee_id = '102';
UPDATE committees SET age = 30 WHERE committee_id = '103';

SELECT a.name FROM committees a, committees b
WHERE a.age = b.age AND a.name <> b.name;


-- Question 2
-- Find the roll number and names of students who have taken atleast one course taught by his or her advisor.
SELECT DISTINCT(student.rollNo), student.name FROM student
INNER JOIN enrollment
    ON student.rollNo = enrollment.rollNo
INNER JOIN teaching
    ON student.advisor = teaching.empId
WHERE enrollment.courseId = teaching.courseId;


-- Question 3
-- What are those courses that are either pre-requisites of 608 or pre-requisites of
-- the prerequisites of the course 608(give course numbers, and course names)?
SELECT DISTINCT(course.courseId), course.cname FROM course
INNER JOIN prerequisite
    ON course.courseId = prerequisite.preReqCourse
WHERE prerequisite.courseId = '608'
    OR prerequisite.courseId IN (SELECT preReqCourse FROM prerequisite WHERE courseId = '608');


-- Question 4
-- Find all the students who have not taken any course offered by the teachers of course 319
SELECT DISTINCT(student.rollNo), student.name FROM student
INNER JOIN enrollment
    ON student.rollNo = enrollment.rollNo
LEFT JOIN (SELECT a.courseId FROM teaching a, teaching b WHERE a.empId = b.empId AND b.courseId = '319') c
    ON c.courseId = enrollment.courseId
MINUS
SELECT DISTINCT(student.rollNo), student.name FROM student
INNER JOIN enrollment
    ON student.rollNo = enrollment.rollNo
INNER JOIN (SELECT a.courseId FROM teaching a, teaching b WHERE a.empId = b.empId AND b.courseId = '319') c
    ON c.courseId = enrollment.courseId;


-- Question 5
-- Find roll no of students who have got S grade in all prerequisites of the course 760
SELECT DISTINCT(enrollment.rollNo) FROM enrollment
INNER JOIN (SELECT DISTINCT(preReqCourse) FROM prerequisite WHERE courseId = '760') a
    ON enrollment.courseId = a.preReqCourse
WHERE enrollment.grade = 'S';


-- Question 6
-- Find name and roll no of student who have taken course multiple times
SELECT DISTINCT(student.rollNo), student.name FROM student
INNER JOIN (SELECT a.rollNo FROM enrollment a, enrollment b
    WHERE a.rollNo = b.rollNo AND a.courseId = b.courseId AND (a.sem <> b.sem OR a.year <> b.year)) e
    ON student.rollNo = e.rollNo;