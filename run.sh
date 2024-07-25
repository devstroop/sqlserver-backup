#!/bin/bash
set -e

# Start SQL Server
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to start
echo "Waiting for SQL Server to start..."
until /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "SELECT 1" > /dev/null 2>&1; do
  sleep 1
done

echo "SQL Server is up - executing backup..."

# Perform the backup
/opt/mssql-tools/bin/sqlcmd -b -V16 -S localhost -U SA -P "$SA_PASSWORD" -Q "BACKUP DATABASE [$DB_NAME] TO DISK = N'/backup/$(date +%Y-%m-%d_%H:%M:%S.$DB_NAME.bak)' WITH NOFORMAT, NOINIT, NAME = '$DB_NAME-full', SKIP, NOREWIND, NOUNLOAD, STATS = 10"

# Keep the container running
wait
