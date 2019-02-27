-- In your script, use DISTINCT to find the unique titles in the titles table. Your results should look like:
USE employees;
SELECT DISTINCT title FROM titles;

-- Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY. The results should be:
SELECT last_name FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
GROUP BY last_name;

-- Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.
SELECT DISTINCT first_name, last_name FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
GROUP BY first_name, last_name;

-- Find the unique last names with a 'q' but not 'qu'. Your results should be:
 SELECT DISTINCT last_name FROM employees 
 WHERE last_name LIKE '%q%'
 AND last_name NOT LIKE '%qu%';
 
 -- Which (across all employees) name is the most common, the least common? Find this for both first name, last name, and the combination of the two.
 SELECT COUNT(*), first_name FROM employees
 GROUP BY first_name
 ORDER BY COUNT(*) DESC;
 -- most common: Shahab 295 
 -- least common: Lech 185
 
SELECT COUNT(*), last_name FROM employees
 GROUP BY last_name
 ORDER BY COUNT(*) DESC;
 -- most common: Baba 226
 -- least common: Sadowsky 145
 
 SELECT COUNT(*), CONCAT(first_name, last_name) FROM employees
 GROUP BY CONCAT(first_name, last_name)
 ORDER BY COUNT(*) DESC;
 -- most common: Rosalyn Baalen 5
 
 -- Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. Your results should be:
SELECT COUNT(*), gender FROM employees
WHERE first_name IN('Irena','Vidya', 'Maya')
GROUP BY gender;

-- Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?
SELECT COUNT(*),
CONCAT(LOWER(SUBSTR(first_name,1,1)), LOWER(SUBSTR(last_name,1,4)), '_', SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,2)) AS username
FROM employees
GROUP BY username
ORDER BY COUNT(*) DESC;
-- Yes, there are duplicate usernames

-- Bonus: how many duplicate usernames are there?
