#!/bin/bash

LOG_FILE="/var/log/update.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
API_DIR="/var/www/your_api"  # path to your API project
WEB_SERVICE="nginx"          # change if you're using Apache

echo "$TIMESTAMP - Starting server update..." >> $LOG_FILE

# Update system
apt update && apt upgrade -y >> $LOG_FILE

# Pull latest API changes
cd $API_DIR
git pull origin main >> $LOG_FILE 2>&1
PULL_STATUS=$?

if [ $PULL_STATUS -ne 0 ]; then
    echo "ERROR: Git pull failed, aborting update." >> $LOG_FILE
    exit 1
fi

# Restart web server
systemctl restart $WEB_SERVICE
echo "Web server restarted." >> $LOG_FILE

echo "Update completed successfully." >> $LOG_FILE
echo "------------------------------------------" >> $LOG_FILE
