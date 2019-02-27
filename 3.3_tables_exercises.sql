USE employees;

SHOW TABLES;

DESCRIBE employees;

-- tables: current_dept_emp, departments, dept_emp, dept_emp_latest_date, dept_manager, employees, salaries, titles
-- data type: integer, date, varchar, enum
-- numeric type column: dept_emp, dept_manager, employees, salaries, titles
-- string type: departments, dept_emp, dept_manager, employees, titles
-- date: employees, dept_emp, titles, salaries
-- departments and employees are both tables under the schema employees; both have employee number fields

SHOW CREATE TABLE dept_manager;
