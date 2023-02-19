set linesize 1000;
set pagesize 1000;

-- Question 1
-- Find the senior most hod in institute (Without using Join).
SELECT * FROM professor
WHERE empid IN (SELECT hod FROM department)
AND startyear = (SELECT MIN(startyear) FROM professor WHERE empid IN (SELECT hod FROM department));

-- Question 2
-- Find the course taught by senior most professor in Biology department
SELECT * FROM course WHERE courseid IN (
    SELECT courseid FROM teaching
    WHERE empid IN (
        SELECT empid FROM professor
        WHERE deptno IN (SELECT deptid FROM department WHERE name = 'Biology')
        AND startyear = (
            SELECT MIN(startyear) FROM professor WHERE deptno IN (
                SELECT deptid FROM department WHERE name = 'Biology'
            )
        )
    )
);

-- Question 3
-- Report department wise, the course that has maximum number of prerequisite
SELECT c.cname, d.name FROM course c INNER JOIN department d ON c.deptno = d.deptid
WHERE c.courseid in (
    SELECT courseid FROM (
        SELECT courseid, count(prereqcourse) cnt FROM prerequisite
        WHERE courseid in (SELECT courseId FROM course WHERE deptNo in (
            SELECT deptNo FROM course GROUP BY deptno
        ))
        GROUP BY courseid
    )
    WHERE cnt in (
        SELECT max(cnt) FROM (
            SELECT courseId, count(prereqcourse) AS cnt FROM prerequisite WHERE courseId in (
                SELECT courseId FROM course WHERE deptNo = 2
            ) group by courseId
        )
    )
);


-- Question 4
-- Report faculty-wise average number of enrollments for course taught in all the semesters during 2002-2004
SELECT empid, AVG(cnt) FROM teaching INNER JOIN (
    SELECT courseid AS cid, COUNT(rollno) AS cnt FROM (
        SELECT t.courseid, t.empid, e.rollno, t.year FROM
        teaching t INNER JOIN enrollment e ON t.courseid = e.courseid
        WHERE t.year IN (2002, 2003, 2004)
    ) GROUP BY courseid
) ON teaching.courseid = cid GROUP BY empid;

-- Question 5
-- What are the total enrollments in the course of the comp. sci. department in Even 2004.
SELECT courseid, COUNT(courseid) FROM enrollment WHERE
courseid IN (SELECT courseid FROM course WHERE deptno = (SELECT deptid FROM department WHERE name='Comp. Sci.'))
AND sem = 'even' AND year = 2004
GROUP BY courseid;