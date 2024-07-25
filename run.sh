#!/usr/bin/env bash

# Check if DATABASE_NAME is set
if [ -z "$DB_NAME" ]; then
  echo "DB_NAME environment variable is not set."
  exit 1
fi

# Set bash to exit if any further command fails
set -e
set -o pipefail

# Create a file name for the backup based on the current date and time
FILE_NAME=$(date +%Y-%m-%d_%H:%M:%S.$DB_NAME.bak)

# Make sure the backups folder exists on the host file system
mkdir -p "/var/opt/mssql/backups"

echo "Backing up database '$DB_NAME'"

# Create a database backup with sqlcmd
/opt/mssql-tools/bin/sqlcmd -b -V16 -S "$DB_SERVER" -U "$DB_USER" -P "$DB_PASSWORD" -Q "BACKUP DATABASE [$DB_NAME] TO DISK = N'/var/opt/mssql/backups/$FILE_NAME' with NOFORMAT, NOINIT, NAME = '$DB_NAME-full', SKIP, NOREWIND, NOUNLOAD, STATS = 10"

echo ""
echo "Backup completed successfully: /var/opt/mssql/backups/$FILE_NAME"
