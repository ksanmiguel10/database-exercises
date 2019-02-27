USE sakila;

-- Display the first and last names in all lowercase of all the actors.
SELECT LOWER(first_name), LOWER(last_name) FROM actor;

-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?
SELECT actor_id, first_name, last_name 
FROM actor
WHERE first_name LIKE 'Joe';

-- Find all actors whose last name contain the letters "gen":
SELECT * FROM actor
WHERE last_name LIKE '%gen%';

-- Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
SELECT * FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;

-- Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
USE world;
SELECT code FROM country
WHERE name IN ('Afghanistan', 'Bangladesh', 'China');


