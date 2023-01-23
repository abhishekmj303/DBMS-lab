-- Question 02
SELECT rollno FROM student WHERE name LIKE '%o%';

-- Question 03
SELECT sex, COUNT(sex) FROM professor WHERE name LIKE '%a' AND startyear > 2000 GROUP BY sex;

-- Question 04
SELECT name FROM department WHERE deptid >= 10 AND phone LIKE '%55%';

-- Question 05
-- select name and startyear of hod having min(startyear in hod table)
SELECT name, empid, startyear FROM professor WHERE empid IN (SELECT hod FROM department) AND startyear = (SELECT MIN(startyear) FROM professor WHERE empid IN (SELECT hod FROM department));

-- Question 06
SELECT year, COUNT(grade) as Grade_A FROM enrollment WHERE grade = 'A' GROUP BY year ORDER BY year;

-- Question 07
-- Determine the number of courses for which each course serve as a prerequisite.
SELECT courseid, COUNT(courseid) FROM prerequisite GROUP BY courseid;

-- Question 08
SELECT sem, COUNT(sem) FROM teaching WHERE classroom LIKE '%R1%' GROUP BY sem;