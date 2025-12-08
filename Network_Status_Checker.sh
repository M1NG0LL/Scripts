#!/bin/bash

# Network Status Checker Script
echo "Starting Network Status Checker..."
Host=8.8.8.8
LOGFILE="network_status.log"
Count=4

echo "Pinging $Host with $Count packets..." | tee -a $LOGFILE

if ping -c $Count $Host > /dev/null 2>&1; then
    echo "✅ Network is UP"
    
    # Measure latency
    LATENCY=$(ping -c 1 $Host | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')
    echo "Average Latency: $LATENCY ms"
    
    STATUS="UP"
else
    echo "❌ Network is DOWN"
    STATUS="DOWN"
    LATENCY="N/A"
fi

# Log results
echo "$(date '+%Y-%m-%d %H:%M:%S') | Host: $Host | Status: $STATUS | Latency: $LATENCY" >> "$LOGFILE"

echo "Results logged to $LOGFILE"
echo "Network Status Checker completed."