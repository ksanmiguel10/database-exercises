USE numbers;

SELECT * FROM numbers;

SELECT CONCAT('Here is a number: ',n) FROM numbers;

SELECT CONCAT(n, n) FROM numbers;

SELECT CONCAT(n, ' plus 1 is ', n + 1) FROM numbers;

USE fruits_db;

SELECT * FROM fruits;

SELECT CONCAT('We have ', quantity, ' of the fruit ',name)
FROM fruits;

SELECT name, name REGEXP'.*e$'
FROM fruits;

SELECT name, SUBSTR(name, 3, 5)
FROM fruits;

SELECT name
FROM fruits
WHERE name REGEXP 'e.';

SELECT name, UPPER(name), LOWER(name)
FROM fruits;

SELECT CONCAT(UPPER(SUBSTR(name, 1, 1)), LOWER(SUBSTR(name,2))) AS cap_name
FROM fruits;

SELECT name, REPLACE(name, 'a', 'AAA')
FROM fruits;

SELECT NOW(), CURDATE(), CURTIME();

USE employees;

SELECT * FROM employees
WHERE hire_date < NOW();

SELECT DATEDIFF(NOW(), '2019-02-04') AS days_since_day_one;

SELECT unix_timestamp();
-- time since unix epoch

SELECT CONCAT(
    'Teaching people to code for ',
    UNIX_TIMESTAMP() - UNIX_TIMESTAMP('2014-02-04'),
    ' seconds'
);

SELECT CAST('123.45' AS CHAR);

SELECT CAST('123.45' AS UNSIGNED);
-- truncates to integer 123

USE employees;

SELECT hire_date AS start_date,
DATEDIFF(NOW(), hire_date) AS days_working_for_company
FROM employees;