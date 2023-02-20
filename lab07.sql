set linesize 1000;
set pagesize 1000;

ALTER TABLE orders DROP FOREIGN KEY;
ALTER TABLE sales_orders DROP FOREIGN KEY;

-- Question 1
UPDATE agent SET country = 'India' WHERE agent_code = 'Ac002';
UPDATE agent SET country = 'London' WHERE agent_code = 'Ac004';
ALTER TABLE agent ADD PRIMARY KEY (agent_code);
UPDATE orders SET agent_code = 'Ac002' WHERE ord_num = '010';
UPDATE orders SET agent_code = 'Ac004' WHERE ord_num = '009';
ALTER TABLE orders ADD FOREIGN KEY (agent_code) REFERENCES agent(agent_code);

-- 1.a: Find ord_num, ord_amount, ord_date, cust_code and agent_code lives in same country or working area is same.
SELECT ord_num, ord_amount, ord_date, cust_code, agent_code FROM orders
WHERE agent_code IN (
    SELECT a1.agent_code FROM agent a1, agent a2
    WHERE a1.agent_code <> a2.agent_code AND
    (a1.working_area = a2.working_area OR a1.country = a2.country)
);

-- 1.b: Retrive ord_num, ord_amount, cust_code and agent_code from the table orders where the
-- agent_code of orders table must be the same agent_code of agents table and agent_name of
-- agents table have atleast one ‘a’ having different working_area.
SELECT ord_num, ord_amount, cust_code, agent_code FROM orders
WHERE agent_code IN (
    SELECT agent_code FROM agent WHERE agent_name LIKE '%a%'
    AND working_area IN (
        SELECT working_area FROM agent
        GROUP BY working_area HAVING COUNT(agent_code) = 1
    )
);


-- Question 2
ALTER TABLE employees ADD PRIMARY KEY (employee_id);

-- 2.a: Display the employee_id, manager_id, first_name and last_name of those employees
-- who manage other employees having individual salary less than average salary of
-- person whose last_name starts with ‘p’
SELECT employee_id, manager_id, first_name, last_name FROM employees
WHERE manager_id IN (
    SELECT employee_id FROM employees 
    WHERE salary < (SELECT AVG(salary) FROM employees WHERE last_name LIKE 'P%')
);


-- Question 3
UPDATE salesman SET city = 'Chennai' WHERE salesman_id = 'si123@19';
UPDATE salesman SET city = 'Kolkata' WHERE salesman_id = 'si123@67';
ALTER TABLE salesman ADD PRIMARY KEY (salesman_id);
ALTER TABLE sales_orders ADD CONSTRAINT sales_fk FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id);

-- 3.a: Display all the orders for the salesman who belongs to the same city and the individual
-- commission of salesman is greater than the average commission of city.
SELECT * FROM sales_orders
WHERE salesman_id IN (
    SELECT s1.salesman_id FROM salesman s1, salesman s2
    WHERE s1.salesman_id != s2.salesman_id AND
    s1.city = s2.city AND
    s1.commission > (SELECT AVG(commission) FROM salesman WHERE city = s1.city)
);

-- 3.b: Delete the salesman_id from table salesman whose commisson is greater than 0.2 and
-- set NA for the values not available in table orders.
ALTER TABLE sales_orders DISABLE CONSTRAINT sales_fk;
DELETE FROM salesman WHERE commission > 0.2;
UPDATE sales_orders SET salesman_id = 'NA'
WHERE salesman_id NOT IN (SELECT salesman_id FROM salesman);

SELECT * FROM salesman;
SELECT * FROM sales_orders;