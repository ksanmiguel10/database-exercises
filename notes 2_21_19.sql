USE join_example_db;

SHOW TABLES;

-- ONE TO MANY
SELECT * FROM users
JOIN roles ON users.role_id = roles.id;

SELECT * FROM roles LEFT JOIN users ON roles.id = users.role_id;

SELECT * FROM users LEFT JOIN roles ON roles.id = users.role_id;

SELECT * FROM roles RIGHT JOIN users ON roles.id = users.role_id;

SELECT * FROM users u JOIN roles r ON u.role_id = r.id;
-- don't have to use AS for an alias
-- Use AS for aliasing a field name, not a table

-- MANY TO MANY