-- Find all the employees with the same hire date as employee 101010 using a sub-query. 69 rows

USE employees;

SELECT first_name, last_name, hire_date, emp_no FROM employees 
WHERE hire_date = (
	SELECT hire_date
    FROM employees
    WHERE emp_no = '101010'
);

-- Find all the titles held by all employees with the first name Aamod.
-- 314 total titles, 6 unique titles
SELECT title FROM titles 
WHERE emp_no IN(
	SELECT emp_no
    FROM employees
    WHERE first_name = 'Aamod'
);

SELECT DISTINCT title FROM titles 
WHERE emp_no IN(
	SELECT emp_no
    FROM employees
    WHERE first_name = 'Aamod'
);

-- How many people in the employees table are no longer working for the company?
SELECT COUNT(*) FROM employees
WHERE emp_no NOT IN(
	SELECT emp_no 
    FROM salaries
    WHERE to_date > NOW()
);

-- Find all the current department managers that are female.
SELECT first_name, last_name FROM employees
WHERE emp_no IN(
	SELECT emp_no 
    FROM dept_manager
    WHERE gender = 'F'
    AND to_date > NOW()
);

-- Find all the employees that currently have a higher than average salary.
-- 154543 rows in total. Here is what the first 5 rows will look like
SELECT first_name, last_name, salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no
WHERE salaries.to_date > NOW()
AND salaries.salary > (
	SELECT AVG(salary)
    FROM salaries);

-- How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
-- 78 salaries
SELECT COUNT(*) FROM salaries
WHERE salary > 
	(SELECT MAX(salary) - STD(salary)
    FROM salaries)
	AND to_date > NOW();
   
-- Percentage
SELECT (COUNT(*) / (SELECT COUNT(*) FROM salaries WHERE to_date > NOW())) * 100
FROM salaries
WHERE salary > 
	(SELECT MAX(salary) - STD(salary)
    FROM salaries)
	AND to_date > NOW();

-- BONUS: Find all the department names that currently have female managers.
SELECT dept_name FROM departments
JOIN dept_manager
ON dept_manager.dept_no = departments.dept_no
WHERE emp_no IN(
	SELECT emp_no
    FROM employees
    WHERE gender = 'F'
    AND dept_manager.to_date > NOW()
);

-- BONUS: Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name FROM employees
WHERE emp_no = (
	SELECT emp_no 
    FROM salaries
	ORDER BY salaries.salary DESC
    LIMIT 1
);

-- OR
SELECT first_name, last_name FROM employees
WHERE emp_no =(
	SELECT emp_no FROM salaries
	WHERE salary =(
		SELECT MAX(salary) 
		FROM salaries
);