/*=============================================================================
Script Name:    schema-definition.sql
Description:    DDL Structural Schema Definition with strict typing.
Target Engine:  MariaDB / MySQL (Debian 13 Linux CLI Environment)
=============================================================================
*/

-- Target Database Scope
USE academy_db;

-- Ensure clean execution environment by dropping tables in reverse order of dependencies
DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS students;

-- 1. Create Students Table
CREATE TABLE students (
	student_id INT UNSIGNED AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_student_email PRIMARY KEY (student_id),
	CONSTRAINT uq_student_email UNIQUE (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Create Articles Table
CREATE TABLE articles (
	article_id INT UNSIGNED AUTO_INCREMENT,
	title VARCHAR(100) NOT NULL,
	category ENUM('Development', 'Cybersecurity', 'Databases', 'Networking') NOT NULL DEFAULT 'Development',
	price DECIMAL(10, 2) UNSIGNED NOT NULL,
	stock INT UNSIGNED NOT NULL DEFAULT 0,
	is_available TINYINT(1) NOT NULL DEFAULT 1,
	assigned_student_id INT UNSIGNED NULL,
	CONSTRAINT pk_articles PRIMARY KEY (article_id),
	CONSTRAINT fk_articles_students
		FOREIGN KEY (assigned_student_id)
	REFERENCES students (student_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
