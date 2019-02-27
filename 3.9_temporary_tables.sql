USE ada_667;

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

SELECT * FROM employees_with_departments;

-- 1.a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE employees_with_departments ADD full_name VARCHAR(35);

-- 1.b. Update the table so that full name column contains the correct data
UPDATE employees_with_departments SET full_name = (CONCAT(first_name, ' ', last_name));

-- 1.c. Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;

ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- 2. Create a temporary table based on the payments table from the sakila database.
CREATE TEMPORARY TABLE sakila_payments_temp AS
SELECT payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
FROM sakila.payment;

SELECT * FROM sakila_payments_temp;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
ALTER TABLE sakila_payments_temp ADD amount_cents INT(5);

UPDATE sakila_payments_temp SET amount_cents = amount*100;

ALTER TABLE sakila_payments_temp DROP COLUMN amount;

-- 3. Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?
SELECT AVG(salary), STDDEV(salary)
FROM employees.salaries
WHERE to_date > NOW();

SELECT emp_no, salary, ((salary-72012)/17310) AS z_salary
FROM employees.salaries
WHERE to_date > NOW();

SELECT a.dept_name, AVG(a.z_salary) AS avg_z_salary
FROM (
	SELECT d.dept_name, s.emp_no, s.salary, ((s.salary-72012)/17310) AS z_salary
	FROM employees.salaries s
	JOIN employees.dept_emp de ON s.emp_no = de.emp_no
	JOIN employees.departments d ON de.dept_no = d.dept_no
	WHERE s.to_date > NOW()
    ) a
GROUP BY a.dept_name;

# OPTION 1: create a temp table 
CREATE TEMPORARY TABLE agg AS
SELECT AVG(salary) AS avg_salary, STDDEV(salary) AS stdev_salary
FROM employees.salaries
WHERE to_date > NOW();

# SELECT * FROM agg;

SELECT a.dept_name, AVG(a.z_salary) AS avg_z_salary
FROM  (
SELECT d.dept_name, s.emp_no, s.salary, ((s.salary-a.avg_salary)/a.stdev_salary) AS z_salary
	FROM employees.salaries s
	JOIN agg a
	JOIN employees.dept_emp de ON s.emp_no = de.emp_no
	JOIN departments d ON de.dept_no = d.dept_no
	WHERE s.to_date > NOW()
	) a
GROUP BY a.dept_name;

-- What is the average salary for an employee based on the number of years they have been with the company? Express your answer in terms of the Z-score of salary. Since this data is a little older, scale the years of experience by subtracting the minumum from every row.
SELECT ROUND((DATEDIFF(NOW(), hire_date)) / 365.25) - 19 AS years_with_company,
	   AVG(emp_z_score) AS salary_z_score
FROM employees.employees
JOIN z_scores_table USING (emp_no)
GROUP BY years_with_company;
