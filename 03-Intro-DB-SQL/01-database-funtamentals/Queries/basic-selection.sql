/*===============================================================
Script Name:	basic-selection.sql
Description: DML Core SELECT queries and column projections.
Target Engine: MariaDB / MySQL (Debian 13 Linux CLI Environment)
===============================================================
*/
-- Target Database Scope
USE academy_db;

-- 1. Structural Selection (Show all records and columns)
-- Used for initial table state audit
SELECT * FROM students;

-- 2. Column Projection & Alias Utilization
-- Aligned with standard report generation, reducing terminal output overhead
SELECT
	student_id AS 'ID',
	first_name AS 'Given Name',
	last_name AS 'Surname'
FROM students;

-- 3. Distinct Data Selection
-- Extracts unique categories from the articles catalog to analyze inventory diversity
SELECT DISTINCT category FROM articles;

-- 4.Calculated Runtime Fields
-- Projects pricing and inventory values without modifying the underlying schema
SELECT
	title AS 'Article',
	price AS 'Unite Price',
	stock AS 'Current Stock',
	(price * stock) AS 'Total Asset Value'
FROM articles;
