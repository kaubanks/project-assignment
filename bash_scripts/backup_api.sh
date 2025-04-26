#!/bin/bash 

BACKUP_DIR="/home/ubuntu/backups"
API_DIR="/project-assignment"  # Ensure this path is correct
DB_NAME="your_db_name"         # Replace with your actual database name
DB_USER="your_db_user"         # Replace with your actual database username
DB_PASSWORD="your_db_password" # Replace with your actual database password
LOG_FILE="/var/log/backup.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

mkdir -p $BACKUP_DIR

# Backup API files
tar -czf "$BACKUP_DIR/api_backup_$(date +%F).tar.gz" $API_DIR
API_STATUS=$?

# Backup PostgreSQL database
export PGPASSWORD=$DB_PASSWORD
pg_dump -U $DB_USER $DB_NAME > "$BACKUP_DIR/db_backup_$(date +%F).sql"
DB_STATUS=$?

# Delete old backups
find $BACKUP_DIR -type f -mtime +7 -delete

# Logging
echo "$TIMESTAMP - Backup started" >> $LOG_FILE
if [ $API_STATUS -eq 0 ]; then
    echo "API backup successful." >> $LOG_FILE
else
    echo "ERROR: API backup failed!" >> $LOG_FILE
fi

if [ $DB_STATUS -eq 0 ]; then
    echo "Database backup successful." >> $LOG_FILE
else  
    echo "ERROR: Database backup failed!" >> $LOG_FILE
fi

echo "------------------------------------------" >> $LOG_FILE

