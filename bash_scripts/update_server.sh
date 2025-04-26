#!/bin/bash

LOG_FILE="/var/log/update.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
API_DIR="/project-assignment/myproject/api_project"  # Update with your actual API project directory
WEB_SERVICE="nginx"  # Change to apache2 if you're using Apache

echo "$TIMESTAMP - Starting server update..." >> $LOG_FILE

# Update system packages
apt update && apt upgrade -y >> $LOG_FILE

# Pull latest changes from Git repository
cd $API_DIR
git pull origin main >> $LOG_FILE 2>&1
PULL_STATUS=$?

if [ $PULL_STATUS -ne 0 ]; then
    echo "ERROR: Git pull failed, aborting update." >> $LOG_FILE
    echo "------------------------------------------" >> $LOG_FILE
    exit 1
fi

# Restart the web server
systemctl restart $WEB_SERVICE
echo "Web server restarted." >> $LOG_FILE

echo "Update completed successfully." >> $LOG_FILE
echo "------------------------------------------" >> $LOG_FILE