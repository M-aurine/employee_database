# Employee Management System

This project is an SQL-based employee management system that demonstrates database creation, table design, data insertion, and retrieval, as well as the use of advanced SQL queries for analysis and reporting. It is designed to manage employee and department data, track performance reviews, and provide insights into employee metrics such as salary, performance, and department-wise analysis.

## Project Overview

The project consists of the following key elements:
- **Database Creation:** `employee_management`
- **Tables:**
  - `departments`: Stores information about departments (name, location).
  - `employees`: Stores employee data (personal details, hire date, salary, job title, department).
  - `performance_reviews`: Tracks performance reviews with ratings and comments.

The project also includes SQL queries for retrieving, updating, and analyzing the data, using techniques such as joins, window functions, and aggregate functions.

## Features

- **Table Creation and Relationships:** Three related tables (`departments`, `employees`, `performance_reviews`) with foreign key relationships.
- **Data Insertion:** Sample data inserted into each table.
- **Basic Queries:** Retrieve employee details, departments, and performance reviews.
- **Advanced SQL Queries:**
  - Joining tables to retrieve employee and department information.
  - Salary analysis (average, cumulative, and ranking).
  - Performance review analysis using `LAG()` and `LEAD()` functions.
  - Department-based salary analysis using `PARTITION BY`.
  - Row numbering based on hire date.
  - Percent ranking of employee salaries.

## Installation and Setup

To run this project locally, follow these steps:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/employee-management.git
