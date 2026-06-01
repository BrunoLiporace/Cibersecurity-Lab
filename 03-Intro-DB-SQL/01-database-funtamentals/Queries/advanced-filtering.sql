/*=============================================================================
Script Name:    advanced-filtering.sql
Description:    DML Advanced filtering, conditional logic, and pagination.
Target Engine:  MariaDB / MySQL (Debian 13 Linux CLI Environment)
=============================================================================
*/
-- Target Database Scope
USE academy_db;

/*1. Advanced Filtering with Logical Operators (AND / OR)
Extracts available articles targeted at Cybersecurity or Databases with a price limit
Aligned with security auditing requirements for specific categories
*/
SELECT
	article_id AS 'ID',
	title AS 'Resource',
	category AS 'Domain',
	price AS 'Cost'
FROM articles
WHERE is_available = 1
	AND (category = 'Cibersecurity' OR category = 'Databases')
	AND price <= 90.00;

/*2. Pattern Matching and Conditional Constraints
Retrieves students whose email belongs to the secure local domain (.local) 
and were registered during the first quarter of the year
*/
SELECT
	student_id AS 'ID',
	CONCAT(first_name, ' ', last_name) AS 'Full Name',
	email AS 'Internal Account'
FROM students
WHERE email LIKE '%.local'
	AND registration_date >= '2026-01-01 00:00:00';

/*3. Positional Sorting (ORDER BY ASC/DESC)
Lists inventory items ordered by stock capacity (descending) and secondary by price (ascending)
*/
SELECT
	title AS 'Item',
	category AS 'Type',
	stock AS 'Available Units',
	price AS 'Unit Price'
FROM articles
WHERE stock > 0
ORDER BY stock DESC, price ASC;

/*4. Data Pagination (LIMIT and OFFSET)
Simulates terminal-based data pagination. Skips the first 2 records and fetches the next 3.
Essential for optimizing large dataset rendering in CLI environments (Document 1.4)
*/
SELECT
	article_id AS 'ID',
	title AS 'Book/Lab Guide',
	price AS 'Price'
FROM articles
ORDER BY article_id ASC
LIMIT 3 OFFSET 2;
