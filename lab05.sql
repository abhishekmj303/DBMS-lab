set linesize 1000;
set pagesize 1000;
alter session set NLS_DATE_FORMAT = 'DD-MON-YYYY';

DROP TABLE orders;
DROP TABLE agent;
DROP TABLE employees;
DROP TABLE salesman;
DROP TABLE sales_orders;


--Question 1 Tables
CREATE TABLE orders(ord_num VARCHAR2(3), ord_amount NUMBER(8), advance_amount NUMBER(8), ord_date VARCHAR2(20), cust_code VARCHAR2(5), agent_code VARCHAR2(10), ord_description VARCHAR2(20));
INSERT INTO orders VALUES('004',200,3000,'15-aug-2020','C004','Ac001','Masala kulcha');
INSERT INTO orders VALUES('007',600,5000,'17-sept-2020','C006','Ac003','Biriyani');
INSERT INTO orders VALUES('008',700,100,'19-feb-2019','C007','Ac005',NULL);
INSERT INTO orders VALUES('009',10000,600,'21-march-2010','C009','Ac008','Masala dosa');
INSERT INTO orders VALUES('010',20,600,'21-april-2012','C006','Ac005',NULL);

CREATE TABLE agent(agent_code VARCHAR2(10), agent_name VARCHAR2(20), working_area VARCHAR2(15), commission NUMBER(4,3), phone_no VARCHAR2(15), country VARCHAR2(15));
INSERT INTO agent VALUES('Ac001','Ramesh','Bangalore',.15,'0331234567','India');
INSERT INTO agent VALUES('Ac002','Dinesh','Bangalore',.25,'0331234568',NULL);
INSERT INTO agent VALUES('Ac003','Suresh','Mumbai',.35,'0331234569','London');
INSERT INTO agent VALUES('Ac004','Kamlesh','New jersey',.68,'0331234564',NULL);
INSERT INTO agent VALUES('Ac005','Kartik','Chennai',.73,'0331234563','India');

--Question 2 Tables
CREATE TABLE employees(employee_id NUMBER(3), first_name VARCHAR2(20), last_name VARCHAR2(20), email VARCHAR2(20), phone_number VARCHAR2(15), hire_date DATE, job_id VARCHAR2(10), salary NUMBER(8), manager_id NUMBER(3), department_id NUMBER(3));
INSERT INTO employees VALUES(700,'Hasmukh','Patel','hp@gmail.com','7003216160','15-aug-2020','Hp003',7000,NULL,90);
INSERT INTO employees VALUES(800,'Kamlesh','Paul','kp@gmail.com','7003216170','17-feb-2020','Kp004',8000,506,90);
INSERT INTO employees VALUES(900,'Dinesh','Gandhi','dp@yahoo.com','9136278563','19-march-2101','Dg006',20000,508,80);
INSERT INTO employees VALUES(701,'Suresh','Modi','sm@dg.com','9187653294','20-april-2015','Sm009',15000,NULL,80);

--Question 3 Tables
CREATE TABLE salesman(salesman_id VARCHAR2(10), name VARCHAR2(20), city VARCHAR2(15), commission NUMBER(4,3));
INSERT INTO salesman VALUES('si123@06','Lakshmi','Kolkata',.5);
INSERT INTO salesman VALUES('si123@09','Ganesh','London',.6);
INSERT INTO salesman VALUES('si123@90','Dinesh','London',.3);
INSERT INTO salesman VALUES('si123@10','Joseph','Chennai',.6);
INSERT INTO salesman VALUES('si123@19','Mahesh','Hyderabad',.65);
INSERT INTO salesman VALUES('si123@26','Paul Adam','London',.1);
INSERT INTO salesman VALUES('si123@67','Rahul','Delhi',.4);

CREATE TABLE sales_orders(ord_no NUMBER(3), purch_amt NUMBER(8), ord_date VARCHAR2(20), customer_id VARCHAR2(5), salesman_id VARCHAR2(10));
INSERT INTO sales_orders VALUES(123,600,'20-aug-2010','003cd','si123@19');
INSERT INTO sales_orders VALUES(576,750,'20-feb-2018','004cd','si123@19');
INSERT INTO sales_orders VALUES(579,800,'20-may-2012','004cd','si123@26');
INSERT INTO sales_orders VALUES(600,60000,'20-jan-2021','006cd','si123@10');
INSERT INTO sales_orders VALUES(700,745,'26-jan-2021','007cd','si123@09');
INSERT INTO sales_orders VALUES(800,860,'29-jan-2019','007cd','si123@26');


--Question 1.a
SELECT ord_num, ord_amount, ord_date, cust_code, agent_code FROM orders
WHERE agent_code IN (SELECT agent_code FROM agent WHERE working_area = 'Bangalore');

--Question 1.b
SELECT ord_num, ord_amount, cust_code, agent_code FROM orders
WHERE agent_code IN (SELECT agent_code FROM agent WHERE agent_name = 'Ramesh');

--Question 2.a
SELECT employee_id, manager_id, first_name, last_name FROM employees
WHERE manager_id IS NOT NULL;

--Question 2.b
SELECT employee_id, manager_id, first_name, last_name FROM employees
WHERE manager_id IS NULL;

--Question 3.a
SELECT * from sales_orders WHERE salesman_id IN (SELECT salesman_id FROM salesman WHERE name = 'Paul Adam');
SELECT * from sales_orders WHERE salesman_id IN (SELECT salesman_id FROM salesman WHERE city = 'London');
