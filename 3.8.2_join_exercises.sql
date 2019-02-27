-- Use the join_example_db. Select all the records from both the users and roles tables.
-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.

USE join_example_db;

SELECT * FROM users;

SELECT * FROM roles;

SELECT * FROM users JOIN roles
ON roles.id = users.role_id;

SELECT * FROM users LEFT JOIN roles
ON roles.id = users.role_id;

SELECT * FROM users RIGHT JOIN roles
ON roles.id = users.role_id;

SELECT * FROM roles LEFT JOIN users
ON roles.id = users.role_id;

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.

SELECT roles.name, COUNT(users.role_id) 
FROM roles JOIN users
ON roles.id = users.role_id
GROUP BY roles.name;

-- Use the employees database.
-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

USE employees;

SELECT * FROM dept_manager;

SELECT 
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) AS full_name,
    departments.dept_name
FROM
    dept_manager
        JOIN
    employees ON dept_manager.emp_no = employees.emp_no
        JOIN
    departments ON departments.dept_no = dept_manager.dept_no
WHERE
    dept_manager.to_date = '9999-01-01'
ORDER BY dept_name ASC;

-- Find the name of all departments currently managed by women.
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS full_name, departments.dept_name
FROM dept_manager JOIN employees
ON dept_manager.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date = '9999-01-01' AND employees.gender = 'F'
ORDER BY dept_name ASC;

-- Find the current titles of employees currently working in the Customer Service department.
SELECT titles.title, COUNT(*)
FROM titles JOIN dept_emp
ON titles.emp_no = dept_emp.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date = '9999-01-01' 
AND titles.to_date = '9999-01-01' 
AND departments.dept_name = 'Customer Service'
GROUP BY titles.title
ORDER BY titles.title;

-- Find the current salary of all current managers.
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS Name, departments.dept_name AS Department, salaries.salary AS Salary
FROM dept_manager JOIN employees
ON dept_manager.emp_no = employees.emp_no
JOIN salaries
ON salaries.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date = '9999-01-01'
AND salaries.to_date = '9999-01-01'
ORDER BY dept_name ASC;

-- Find the number of employees in each department.
SELECT dept_emp.dept_no, departments.dept_name, COUNT(dept_emp.emp_no) AS num_employees
FROM dept_emp JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date = '9999-01-01' 
GROUP BY departments.dept_name
ORDER BY departments.dept_no;

-- Which department has the highest average salary?
SELECT departments.dept_name, AVG(salaries.salary)
FROM departments JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
JOIN salaries
ON dept_emp.emp_no = salaries.emp_no
WHERE dept_emp.to_date = '9999-01-01'
AND salaries.to_date = '9999-01-01'
GROUP BY departments.dept_name
ORDER BY AVG(salaries.salary) DESC
LIMIT 1;

-- Who is the highest paid employee in the Marketing department?
SELECT employees.first_name, employees.last_name
FROM employees JOIN salaries
	ON employees.emp_no = salaries.emp_no
JOIN dept_emp
	ON dept_emp.emp_no = employees.emp_no
JOIN departments 
	ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date = '9999-01-01'
	AND salaries.to_date = '9999-01-01'
	AND departments.dept_name = 'Marketing'
ORDER BY salaries.salary DESC
LIMIT 1;
 
-- Which current department manager has the highest salary?
SELECT 
    employees.first_name,
    employees.last_name,
    salaries.salary,
    departments.dept_name
FROM
    employees
        JOIN
    salaries ON employees.emp_no = salaries.emp_no
        JOIN
    dept_manager ON employees.emp_no = dept_manager.emp_no
        JOIN
    departments ON departments.dept_no = dept_manager.dept_no
WHERE
    dept_manager.to_date = '9999-01-01'
        AND salaries.to_date = '9999-01-01'
ORDER BY salaries.salary DESC
LIMIT 1;

-- Bonus: Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS 'Employe Name', 
	departments.dept_name AS 'Department Name',
    CONCAT(e.first_name, ' ', e.last_name) AS 'Manager Name'
FROM employees
	JOIN dept_emp
		ON dept_emp.emp_no = employees.emp_no
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
	JOIN dept_manager
		ON dept_manager.dept_no = departments.dept_no
	JOIN employees e
		ON dept_manager.emp_no = e.emp_no
WHERE 
	dept_manager.to_date = '9999-01-01'
		AND dept_emp.to_date = '9999-01-01'
ORDER BY departments.dept_name;

-- Bonus: Find the highest paid employee in each department.

