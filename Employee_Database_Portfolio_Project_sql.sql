-- CREATING DATABASE
CREATE DATABASE employee_management;

-- CREATING TABLES
CREATE TABLE departments(
	department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(100)
);


CREATE TABLE employees(
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2),
    department_id INT,
    job_title VARCHAR(50),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE performance_reviews(
	review_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    review_date DATE NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    FOREIGN KEY(employee_id) REFERENCES employees(employee_id)
);

-- INSERTING DATA
-- Departments Table
INSERT INTO departments(department_name,location) VALUES
	('Sales','New York'),
    ('HR','Los Angeles'),
    ('IT','San Francisco');
    
-- Employees Table
INSERT INTO employees(first_name,last_name,email,hire_date,salary,department_id,job_title)
VALUES
	('Maurine','Nyongesa','maurine.nyongesa@gmail.com','2021-03-15',55000,1,'Sales Executive'),
    ('Asa','Moh','asa.moh@gmail.com','2020-06-30',60000,2,'HR Manager'),
    ('Steve','Jobs','steve.jobs@gmail.com','2019-08-10',75000,3,'IT Specialist');
    
-- performace_reviews Table
INSERT INTO performance_reviews(employee_id,review_date,rating,comments) VALUES
	(1,'2023-06-15',4,'Great performance but needs improvement in client interaction.'),
    (2,'2023-05-12',5,'Excellent management skills highly recommended for promotion.'),
    (3,'2023-07-20',3,'Satisfactory performance but needs more technical training.');


-- Retrieving Data from the employees table
SELECT *
FROM employees;

-- Updating data
UPDATE employees
SET salary = 65000
WHERE employee_id = 1;

-- Adding another person
INSERT INTO employees (first_name, last_name, email, hire_date, salary, job_title, department_id)
VALUES ('Jane', 'Doe', 'jane.doe@email.com', '2023-05-15', 55000, 'Marketing Specialist', 2);

-- QUERYING
-- Joining Tables
-- Retrieve All Employees with Their Department Names
SELECT e.first_name,e.last_name,d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- Find Employees with a Salary Above 60,000
SELECT first_name,last_name
FROM employees
WHERE salary > 60000;

-- Get Performance Reviews for a Specific Employee
-- Query to get performance reviews for a specific employee
SELECT e.first_name, e.last_name, p.review_date, p.rating, p.comments
FROM employees e
JOIN performance_reviews p
ON e.employee_id = p.employee_id
WHERE e.employee_id = 1;

-- Average Salary by Department
SELECT *
FROM departments;

SELECT AVG(e.salary) AS average_salary, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name;

-- Employees with the Highest Ratings
-- Query to find employees with the highest performance ratings
SELECT e.first_name, e.last_name, p.rating
FROM employees e
JOIN performance_reviews p
ON e.employee_id = p.employee_id
WHERE p.rating = 5;

-- Ranking Employees by Salary
SELECT first_name,last_name,salary,
	RANK() OVER(ORDER BY salary) salary_rank
FROM employees;

-- Cumulative Salary for Employees
SELECT first_name, last_name, salary,
       SUM(salary) OVER (ORDER BY salary) AS cumulative_salary
FROM employees
ORDER BY salary;

--  Calculating Average Salary Over Departments
-- This query calculates the average salary for each department and shows it alongside each employee’s information.
SELECT first_name, last_name, department_id, salary,
       AVG(salary) OVER (PARTITION BY department_id) AS avg_department_salary
FROM employees;

-- Row Number Based on Hire Date
-- This assigns a row number to each employee, sorted by the date they were hired.
-- It’s useful for scenarios where you want to track the order of employee hiring.
SELECT first_name, last_name, hire_date,
       ROW_NUMBER() OVER (ORDER BY hire_date) AS row_num
FROM employees;

-- Lead and Lag Functions for Performance Reviews
-- This query shows an employee's current review rating along with the previous and next ratings (if they exist).
-- It uses the LAG() function to pull the previous review and LEAD() to pull the next review, within the same employee’s records.
SELECT employee_id, review_date, rating,
       LAG(rating) OVER (PARTITION BY employee_id ORDER BY review_date) AS prev_rating,
       LEAD(rating) OVER (PARTITION BY employee_id ORDER BY review_date) AS next_rating
FROM performance_reviews;

-- Percent Rank for Salaries
-- This query calculates the percentile rank of each employee’s salary compared to others.
-- Employees with the lowest salary will have a rank of 0, and the highest-paid will have a rank o
SELECT first_name, last_name, salary,
       PERCENT_RANK() OVER (ORDER BY salary) AS percent_rank_salary
FROM employees;
