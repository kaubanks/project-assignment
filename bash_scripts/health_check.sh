#!/bin/bash

LOG_FILE="/var/log/server_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEMORY=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100}')
DISK=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
WEB_SERVICE="nginx"  # change to apache2 if using Apache

echo "$TIMESTAMP - Running health check..." >> $LOG_FILE
echo "CPU Usage: $CPU%" >> $LOG_FILE
echo "Memory Usage: $MEMORY%" >> $LOG_FILE
echo "Disk Usage: $DISK%" >> $LOG_FILE

# Web server check
if systemctl is-active --quiet $WEB_SERVICE; then
    echo "$WEB_SERVICE is running" >> $LOG_FILE
else
    echo "WARNING: $WEB_SERVICE is not running" >> $LOG_FILE
fi

# API endpoint checks
for endpoint in "students" "subjects"; do
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/$endpoint)
    if [ "$RESPONSE" == "200" ]; then
        echo "API /$endpoint is OK" >> $LOG_FILE
    else
        echo "WARNING: /$endpoint is DOWN. Status code: $RESPONSE" >> $LOG_FILE
    fi
done

# Disk space check
if [ "$DISK" -ge 90 ]; then
    echo "WARNING: Disk usage is above 90%" >> $LOG_FILE
fi

echo "------------------------------------------" >> $LOG_FILE
