SELECT * FROM mysql.help_topic;

USE employees;
SHOW CREATE TABLE salaries;

USE sakila;
SHOW TABLES;

SHOW CREATE TABLE actor;

SELECT last_name FROM actor;

SELECT title, description, rating, length FROM film WHERE length >= 180;
     
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= '2005-05-27';

SELECT amount, payment_date FROM payment WHERE payment_date BETWEEN '2005-05-27' AND '2005-05-28';