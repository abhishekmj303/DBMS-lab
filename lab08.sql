set linesize 1000;
set pagesize 1000;

DROP TABLE Course_Taken;
DROP TABLE Course_Required;
DROP TABLE Bank;
DROP TABLE Account_Holder;
DROP TABLE ct_distinct;

CREATE TABLE Course_Taken (Student_Name VARCHAR2(20), Course VARCHAR2(25));
CREATE TABLE Course_Required (Course VARCHAR2(25));

INSERT INTO Course_Taken VALUES ('Robert', 'Databases');
INSERT INTO Course_Taken VALUES ('Robert', 'Programming Languages');
INSERT INTO Course_Taken VALUES ('David', 'Databases');
INSERT INTO Course_Taken VALUES ('Hannah', 'Programming Languages');
INSERT INTO Course_Taken VALUES ('Hannah', 'Programming Languages');
INSERT INTO Course_Taken VALUES ('Tom', 'Operating systems');
INSERT INTO Course_Taken VALUES ('David', 'Operating systems');

INSERT INTO Course_Required VALUES ('Databases');
INSERT INTO Course_Required VALUES ('Programming Languages');

-- Question 1.a
-- Create a set of all students that have taken courses.
create table allstud as SELECT DISTINCT Student_Name FROM Course_Taken;

-- Question 1.b
-- Find and create set of all the student and the courses required to graduate.
create table allreq as SELECT * FROM (allstud), Course_Required;

-- Question 1.c
-- Find and create all the students and the required courses they have not taken. (Join not allowed)
CREATE table as allreqnottaken AS
allreq
MINUS
SELECT * FROM Course_Taken;

-- Question 1.d
-- Find and create all the students who cannot graduate. (Join not allowed)
CREATE TABLE cannotgrad AS
SELECT DISTINCT Student_Name FROM (
    allreqnottaken
);

-- Question 1.e
-- Find and create all the students who can graduate. (Join not allowed)
CREATE TABLE cangrad AS
allstud
MINUS
cannotgrad;

-- Question 2
-- Write another three solutions for the query students who cannot graduate.

-- Solution 2.1
SELECT DISTINCT ct1.Student_Name FROM Course_Taken ct1
WHERE EXISTS(
    SELECT * FROM Course_Required cr
    WHERE NOT EXISTS(
        SELECT * FROM Course_Taken ct2
        WHERE ct2.Student_name = ct1.Student_name AND ct2.Course = cr.Course
    )
);

-- Solution 2.2
CREATE TABLE ct_distinct AS (SELECT * FROM Course_Taken GROUP BY Student_Name, Course);
SELECT Student_Name FROM ct_distinct
GROUP BY Student_Name
HAVING (SELECT COUNT(*) FROM Course_Required) > COUNT(
    CASE WHEN Course IN (SELECT Course FROM Course_Required)
    THEN 1 END
);

-- Solution 2.3
SELECT DISTINCT Student_Name FROM (
    SELECT * FROM (SELECT DISTINCT Student_Name FROM Course_Taken), Course_Required
    MINUS
    SELECT * FROM Course_Taken
);

-- Question 3

CREATE TABLE Bank (Bank_name VARCHAR2(10), State VARCHAR2(20));
CREATE TABLE Account_Holder (Account_Name VARCHAR2(10), Bank_name VARCHAR2(10), State_Name VARCHAR2(20));

INSERT INTO Bank VALUES ('SBI', 'ANDHRA PRADESH');
INSERT INTO Bank VALUES ('SBI', 'TAMILNADU');
INSERT INTO Bank VALUES ('SBI', 'KARNATAKA');
INSERT INTO Bank VALUES ('ICICI', 'TAMILNADU');
INSERT INTO Bank VALUES ('ICICI', 'KARNATAKA');

INSERT INTO Account_Holder VALUES ('RAMESH', 'ICICI', 'TAMILNADU');
INSERT INTO Account_Holder VALUES ('DINESH', 'SBI', 'ANDHRA PRADESH');
INSERT INTO Account_Holder VALUES ('ROBERT', 'SBI', 'TAMILNADU');
INSERT INTO Account_Holder VALUES ('ROBERT', 'ICICI', 'KARNATAKA');
INSERT INTO Account_Holder VALUES ('ROBERT', 'SBI', 'ANDHRA PRADESH');
INSERT INTO Account_Holder VALUES ('KARTHIK', 'SBI', 'ANDHRA PRADESH');

-- Question 3.a
-- Find the ACCOUNT_NAME having account in all banks.
SELECT DISTINCT Account_Name FROM Account_Holder
MINUS
SELECT DISTINCT Account_Name FROM (
    SELECT * FROM (SELECT DISTINCT Account_Name FROM Account_Holder),
    (SELECT DISTINCT Bank_name FROM Bank)
    MINUS
    SELECT Account_Name, Bank_name FROM Account_Holder
);

-- Question 3.b
-- Find the bank available in all the state.
SELECT DISTINCT Bank_name FROM Bank
MINUS
SELECT DISTINCT Bank_name FROM (
    SELECT * FROM (SELECT DISTINCT Bank_name FROM Bank),
    (SELECT DISTINCT State FROM Bank)
    MINUS
    SELECT Bank_name, State FROM Bank
);

-- Question 3.c
-- Find the bank not available in all the state.
SELECT DISTINCT Bank_name FROM (
    SELECT * FROM (SELECT DISTINCT Bank_name FROM Bank),
    (SELECT DISTINCT State FROM Bank)
    MINUS
    SELECT Bank_name, State FROM Bank
);

-- Question 3.d
-- Find the ACCOUNT_NAME having account in all the state
SELECT DISTINCT Account_Name FROM Account_Holder
MINUS
SELECT DISTINCT Account_Name FROM (
    SELECT * FROM (SELECT DISTINCT Account_Name FROM Account_Holder),
    (SELECT DISTINCT State_Name FROM Account_Holder)
    MINUS
    SELECT Account_Name, State_Name FROM Account_Holder
);