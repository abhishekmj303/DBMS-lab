set linesize 1000;
set pagesize 1000;

set serveroutput on;
DROP TABLE empinfo;

-- Question 1
-- Find a maximum between three numbers.
DECLARE
    a NUMBER;
    b NUMBER;
    c NUMBER;
    mx NUMBER;
BEGIN
    a := &a;
    b := &b;
    c := &c;

    IF a > b THEN
        IF a > c THEN
            mx := a;
        ELSE
            mx := c;
        END IF;
    ELSE
        IF b > c THEN
            mx := b;
        ELSE
            mx := c;
        END IF;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Max: ' || mx);
END;
/

-- Question 2
-- Check whether a number is divisible by 5 and 11 or not.
DECLARE
    a NUMBER;
BEGIN
    a := &a;

    IF MOD(a, 5) = 0 AND MOD(a, 11) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Divisible by 5 and 11');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Not divisible by 5 and 11');
    END IF;
END;
/

-- Question 3
-- Find the area of rectangle, triangle, and square.
DECLARE
    length NUMBER;
    breadth NUMBER;
    base NUMBER;
    height NUMBER;
    side NUMBER;
    area NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('1. Rectangle');
    length := &length;
    breadth := &breadth;
    area := length * breadth;
    DBMS_OUTPUT.PUT_LINE('Area: ' || area);

    DBMS_OUTPUT.PUT_LINE('2. Triangle');
    base := &base;
    height := &height;
    area := 0.5 * base * height;
    DBMS_OUTPUT.PUT_LINE('Area: ' || area);

    DBMS_OUTPUT.PUT_LINE('3. Square');
    side := &side;
    area := side * side;
    DBMS_OUTPUT.PUT_LINE('Area: ' || area);
END;
/

-- Question 4
-- Program to input marks of five subjects Physics, Chemistry, Biology,
-- Mathematics and Computer. Calculate percentage and grade according to following:
-- Percentage >= 90% : Grade A
-- Percentage >= 80% : Grade B
-- Percentage >= 70% : Grade C
-- Percentage >= 60% : Grade D
-- Percentage >= 40% : Grade E
-- Percentage < 40% : Grade F
DECLARE
    phy NUMBER;
    chem NUMBER;
    bio NUMBER;
    math NUMBER;
    comp NUMBER;
    perc NUMBER;
BEGIN
    phy := &phy;
    chem := &chem;
    bio := &bio;
    math := &math;
    comp := &comp;

    perc := (phy + chem + bio + math + comp) / 5;

    IF perc >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('Grade: A');
    ELSIF perc >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('Grade: B');
    ELSIF perc >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('Grade: C');
    ELSIF perc >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('Grade: D');
    ELSIF perc >= 40 THEN
        DBMS_OUTPUT.PUT_LINE('Grade: E');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Grade: F');
    END IF;
END;
/

-- Question 5
-- Find sum of 100 natural number using loop.
DECLARE
    i NUMBER;
    numsum NUMBER;
BEGIN
    i := 1;
    numsum := 0;

    WHILE i <= 100 LOOP
        numsum := numsum + i;
        i := i + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Sum: ' || numsum);
END;
/

-- Question 6
CREATE TABLE empinfo (id NUMBER, name VARCHAR2(20), age NUMBER, address VARCHAR2(20), salary NUMBER);

INSERT INTO empinfo VALUES (1, 'Ramesh', 32, 'Ahmedabad', 2000);
INSERT INTO empinfo VALUES (2, 'Khilan', 25, 'Delhi', 1500);
INSERT INTO empinfo VALUES (3, 'kaushik', 23, 'Kota', 2000);
INSERT INTO empinfo VALUES (4, 'Chaitali', 25, 'Mumbai', 6500);
INSERT INTO empinfo VALUES (5, 'Hardik', 27, 'Bhopal', 8500);
INSERT INTO empinfo VALUES (6, 'Komal', 22, 'MP', 4500);

ALTER TABLE empinfo ADD CONSTRAINT empinfo_pk PRIMARY KEY (id);

-- Question 6.A
-- Find the name of person having id =1
DECLARE
    e_id empinfo.id%TYPE := 1;
    e_name empinfo.name%TYPE;
BEGIN
    SELECT name INTO e_name FROM empinfo WHERE id = e_id;
    DBMS_OUTPUT.PUT_LINE('The name of person having id=' || e_id || ' is ' || e_name);
END;
/

-- Question 6.B
-- Find the name, age, salary lives in kota.
DECLARE
    e_city empinfo.address%TYPE := 'Kota';
    e_name empinfo.name%TYPE;
    e_age empinfo.age%TYPE;
    e_salary empinfo.salary%TYPE;
BEGIN
    SELECT name, age, salary INTO e_name, e_age, e_salary
    FROM empinfo WHERE address = e_city;
    DBMS_OUTPUT.PUT_LINE('The name, age, salary who lives in ' 
    || e_city || ' is ' || e_name || ', ' || e_age || ', ' || e_salary);
END;
/
