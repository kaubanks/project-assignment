#!/bin/bash 

LOG_FILE="/var/log/server_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# CPU usage check
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Memory usage check
MEMORY=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100}')

# Disk usage check
DISK=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

# Web service (Nginx or Apache) check
WEB_SERVICE="nginx"  # change to apache2 if using Apache

# Writing timestamp and CPU, memory, disk info to log file
echo "$TIMESTAMP - Running health check..." >> $LOG_FILE
echo "CPU Usage: $CPU%" >> $LOG_FILE
echo "Memory Usage: $MEMORY%" >> $LOG_FILE
echo "Disk Usage: $DISK%" >> $LOG_FILE

# Check if the web service is active
if systemctl is-active --quiet $WEB_SERVICE; then
    echo "$WEB_SERVICE is running" >> $LOG_FILE
else
    echo "WARNING: $WEB_SERVICE is not running" >> $LOG_FILE
fi

# Check the status of API endpoints
for endpoint in "students" "subjects"; do
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://ec2-54-205-9-151.compute-1.amazonaws.com/$endpoint)
    if [ "$RESPONSE" == "200" ]; then
        echo "API /$endpoint is OK" >> $LOG_FILE
    else
        echo "WARNING: /$endpoint is DOWN. Status code: $RESPONSE" >> $LOG_FILE
    fi
done

# Check disk space and issue a warning if above 90%
if [ "$DISK" -ge 90 ]; then
    echo "WARNING: Disk usage is above 90%" >> $LOG_FILE
fi

echo "------------------------------------------" >> $LOG_FILE

