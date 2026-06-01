#!/bin/bash

# Halt execution on any unexpected command failure
set -e

# Path Definitions (Relative to 'automation/' directory)
SCRIPTS_DIR="Scripts"
LOGS_DIR="Logs"
LOG_FILE="${LOGS_DIR}/database_setup.log"

# Target Credentials (Aligndes with scripts/db-initialization.sql)
DB_USER="brunito"
DB_PASS="44816577"
DB_NAME="academy_db"

echo "=== Database Deployment Audit Trail - $(date '+%Y-%m-%d %H:%M:%S') ===" > "${LOG_FILE}"

echo "[*] Starting automated database environment deployment..."

# ==========================================================
# Phase 1: Database Initialization (Requires root privileges for user provisioning)
echo "[1/3] Launching database initialization and privilege segregation..." | tee -a "${LOG_FILE}"

if sudo mysql < "${SCRIPTS_DIR}/db-initialization.sql" >> "${LOG_FILE}" 2>&1; then
	echo "	-> Success: Database and restricted user provisioned." | tee -a "${LOG_FILE}"
else
	echo "	[!] Critical Error: Initialization failed. Chek ${LOG_FILE}" >&2
	exit 1
fi

# ==========================================================
# Phase 2: Schema Definition (DDL Structural Operations)
echo "[2/3] Executing DDL structural schema definition..." | tee -a "${LOG_FILE}"

if mysql -u "${DB_USER}" -p"${DB_PASS}" "${DB_NAME}" < "${SCRIPTS_DIR}/schema-definition.sql" >> "${LOG_FILE}" 2>&1; then
	echo "	-> Success: Relational tables and constraints created." | tee -a "${LOG_FILE}"
else
	echo "	[!] Critical Error: Schema definition failed. Check ${LOG_FILE}" >&2
	exit 1
fi

# ===========================================================
# Phase 3: Data Seeding (DML Transactional Inerstions)
echo "[3/3] Populating database with transactional sample data..." | tee -a "${LOG_FILE}"

if mysql -u "${DB_USER}" -p"${DB_PASS}" "${DB_NAME}" < "${SCRIPTS_DIR}/data-seed.sql" >> "${LOG_FILE}" 2>&1; then
	echo "	-> Success: Data seeding completed cleanly." | tee -a "${LOG_FILE}"
else
	echo "	[!] Critical Error: Data seeding failed. Check ${LOG_FILE}" >&2
	exit 1
fi

# ===========================================================
# Deployment Summary
echo "=================================================="
echo "Deployment finalized successfully at $(date '+%Y-%m-%d %H:%M:%S')" >> "${LOG_FILE}"
echo "[+] Environment deployment complete. Audit logs saved to: ${LOG_FILE}"

exit 0
