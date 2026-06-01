/*=============================================================================
Script Name:    data-seed.sql
Description:    DML Data Seeding for schema population.
Target Engine:  MariaDB / MySQL (Debian 13 Linux CLI Environment)
=============================================================================
*/

-- Target Database Scope
USE academy_db;

-- 1. Populate Students Table
-- Inserting 5 initial records to enable advanced filtering and pagination tests
INSERT INTO students (first_name, last_name, email, registration_date) VALUES
('Carlos', 'Alvarez', 'carlos.alvarez@gmail.com', '2026-05-10 09:00:00'),
('Ana', 'Benitez', 'ana.benitez@gmail.com', '2026-05-15 10:30:00'),
('Bruno', 'Gomez', 'bruno.gomez@database.local', '2026-02-01 14:15:00'),
('Daniela', 'Aragon', 'daniela.aragon@network.local', '2026-02-10 11:00:00'),
('Esteban', 'Martinez', 'esteban.martinez@security.local', '2026-03-01 16:45:00');

-- 2. Populate Articles Table
-- Inserting items mapped to specific categories and assigned to students
-- Demonstrates fields matching ENUM constraints and state booleans (is_available)
INSERT INTO articles (title, category, price, stock, is_available, assigned_student_id) VALUES
('Introduction to Linux CLI', 'Development', 29.99, 50, 1, 1),
('Network Packet Analysis with Wireshark', 'Networking', 49.99, 20, 1, 4),
('Sql Injection Mitigation Techniques', 'Cybersecurity', 89.99, 15, 1, 1),
('Advanced MariaDB Optimization', 'Databases', 59.99, 0, 0, 3),
('Bash Scripting for Automation', 'Development', 19.99, 100, 1, NULL),
('CompTIA Security+ Lab Guide', 'Cybersecurity', 75.00, 30, 1, 5),
('Database Sharding and Replication', 'Databases', 65.50, 12, 1, NULL);
