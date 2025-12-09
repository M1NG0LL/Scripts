#!/bin/bash

# Script to monitor RAM usage every 5 seconds
echo "Starting RAM usage monitoring"
while true; do
    total=$(free -m | awk '/^Mem:/ {print $2}')
    used=$(free -m | awk '/^Mem:/ {print $3}')
    free_mem=$(free -m | awk '/^Mem:/ {print $4}')
    percent=$(( used * 100 / total ))

    total_gb=$(awk "BEGIN {printf \"%.2f\", $total/1024}")
    used_gb=$(awk "BEGIN {printf \"%.2f\", $used/1024}")
    free_gb=$(awk "BEGIN {printf \"%.2f\", $free_mem/1024}")

    line="$(date '+%Y-%m-%d %H:%M:%S') - Total: ${total}MB/${total_gb}GB, Used: ${used}MB/${used_gb}GB, Free: ${free_mem}MB/${free_gb}GB, Usage: ${percent}%"
    
    echo "$line"
    echo "-------------------------------------------------------------"
    sleep 5
done