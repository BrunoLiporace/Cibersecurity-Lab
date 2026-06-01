/*=============================================================================
-- Script Name:    db-initialization.sql
-- Description:    Database provisioning and access control list (ACL) management.
-- Target Engine:  MariaDB / MySQL (Debian 13 Linux CLI Environment)
-- Security Standard: Principle of Least Privilege (PoLP)
-- =============================================================================
*/

-- 1. Purge previous lab structures to guarantee deployment idempotency
DROP DATABASE IF EXISTS academy_db;

-- 2. Initialize the database instance enforcing global character standards
CREATE DATABASE academy_db
	CHARACTER SET utf8mb4
	COLLATE utf8mb4_unicode_ci;

-- 3. Remove existing user assignments if present to prevent authorization overhead
DROP USER IF EXISTS 'brunito'@'localhost';

-- 4. Create a dedicated local account isolated from administrative system roles
CREATE USER 'brunito'@'localhost'
	IDENTIFIED BY '44816577';

-- 5. Delegate granular privileges limited to the target database context
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER
	ON academy_db.* TO 'brunito'@'localhost';

-- 6. Re-index internal security descriptors to apply configuration changes
FLUSH PRIVILEGES;
