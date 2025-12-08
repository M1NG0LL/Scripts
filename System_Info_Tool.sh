#!/bin/bash

# System Info Tool Script
echo "Starting System Info Tool..."

# Function to display system information
display_system_info() {
    echo "Gathering system information..."

    echo "--------------------------------"
    echo "Hostname: $(hostname)"
    echo "Operating System: $(uname -o)"
    echo "Kernel Version: $(uname -r)"
    echo "Uptime: $(uptime -p)"
    echo "--------------------------------"
    echo ""
    echo "Memory Usage:"
    echo "--------------------------------"
    free -h
    echo "--------------------------------"
    echo ""
    echo "Disk Usage:"
    echo "--------------------------------"
    df -h
    echo "--------------------------------"
    echo ""
    echo "--------------------------------"
    echo "CPU Information:"
    lscpu | grep 'Model name\|Architecture\|CPU(s)'
    echo "GPU Information:"
    powershell.exe "(Get-CimInstance Win32_VideoController).Name | ForEach-Object -Begin { \$i = 1 } -Process { \"\$i. \$_\"; \$i++ }"
    echo "--------------------------------"
    echo ""
    echo "IP Routing Table:"
    ip route show 

}

# Call the function to display system information
display_system_info
echo "System Info Tool finished."
