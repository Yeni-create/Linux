#!/bin/bash
#
# PostgreSQL DBA - Linux & systemd Quick Checks
# Platform: Rocky / RHEL / Alma Linux
# Purpose: Common OS-level checks used by PostgreSQL DBAs
#

PG_SERVICE="postgresql-17"
PG_PORT="5432"

echo "=============================="
echo " PostgreSQL DBA Linux Checks"
echo "=============================="

echo
echo "1) PostgreSQL service status"
systemctl status $PG_SERVICE --no-pager

echo
echo "2) PostgreSQL systemd logs (last 20 lines)"
journalctl -u $PG_SERVICE -n 20 --no-pager

echo
echo "3) Checking if PostgreSQL is listening on port $PG_PORT"
ss -lntp | grep $PG_PORT || echo "PostgreSQL is NOT listening on port $PG_PORT"

echo
echo "4) Running PostgreSQL processes"
ps -ef | grep '[p]ostgres'

echo
echo "5) Disk usage"
df -h

echo
echo "6) Memory usage"
free -h

echo
echo "7) Swap usage"
swapon --show

echo
echo "8) Check for OOM killer events"
grep -i oom /var/log/messages 2>/dev/null | tail -5 || echo "No OOM events found"

echo
echo "9) System uptime and load"
uptime

echo
echo "=============================="
echo " Checks completed"
echo "=============================="
