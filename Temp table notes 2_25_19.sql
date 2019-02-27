USE ada_667;

CREATE TABLE my_numbers(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    n INT UNSIGNED NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO my_numbers(n) VALUES
	(1), (123), (45), (42);
    
DELETE FROM my_numbers WHERE n = 1;
    
SELECT * FROM my_numbers;

-- affects all rows
UPDATE my_numbers SET n = n-1;

-- only affects certain rows
UPDATE my_numbers SET n = n*2 WHERE n > 100;

-- delete data
DELETE FROM my_numbers WHERE n = 0;

-- Deletes all data from table
DELETE FROM my_numbers;
-- if you add more values after, the id will continue numbering, not start back at 1. 

-- deletes whole table and all data in it
DROP TABLE my_numbers;

CREATE TEMPORARY TABLE employees_with_current_salaries AS 
SELECT 
	e.emp_no, birth_date, first_name, last_name, gender, hire_date, salary as current_salary
FROM employees.employees e 
JOIN employees.salaries s 
	ON e.emp_no = s.emp_no
WHERE to_date > NOW() 
LIMIT 100;

-- ON e.emp_no = s.emp_no can also be done as... USING(emp_no)... if names are identical

SELECT * FROM employees_with_current_salaries;

ALTER TABLE my_numbers ADD n_plus_one INT UNSIGNED;

UPDATE my_numbers SET n_plus_one = n + 1;

SELECT * FROM my_numbers;

ALTER TABLE my_numbers ADD n2 INT UNSIGNED;

SELECT * FROM my_numbers;

UPDATE my_numbers SET n2 = (n*3)+6;

SELECT * FROM my_numbers;

ALTER TABLE my_numbers DROP COLUMN n;