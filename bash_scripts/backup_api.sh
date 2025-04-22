#!/bin/bash

BACKUP_DIR="/home/ubuntu/backups"
API_DIR="/var/www/your_api"  # change this path
DB_NAME="your_db_name"       # replace with actual DB name
LOG_FILE="/var/log/backup.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

mkdir -p $BACKUP_DIR

# Backup API files
tar -czf "$BACKUP_DIR/api_backup_$(date +%F).tar.gz" $API_DIR
API_STATUS=$?

# Backup database
mysqldump -u root -pYourPassword $DB_NAME > "$BACKUP_DIR/db_backup_$(date +%F).sql"
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
