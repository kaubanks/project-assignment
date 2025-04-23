# project-assignment
use http: instead of https:
 Brief description for  this project:  ---  Student &amp; Subject API   A Django-based API providing two endpoints:   - /students: Lists  students and their programs.   - /subjects: Lists Software Engineering program subjects by year (1-4).    Tech Stack: Django, PostgreSQL, AWS.  
## Bash Automation Scripts

This folder contains automation scripts for server health monitoring, backup, and update tasks.

### Scripts
- `health_check.sh`: Monitors CPU, memory, disk space, API status, and web server uptime.
- `backup_api.sh`: Backs up the API project files and MySQL database. Deletes backups older than 7 days.
- `update_server.sh`: Updates server packages, pulls latest code from GitHub, and restarts the web server.

### Setup
```bash
chmod +x health_check.sh
chmod +x backup_api.sh
chmod +x update_server.sh
