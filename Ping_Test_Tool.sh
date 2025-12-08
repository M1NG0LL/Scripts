#!/bin/bash

echo "Starting Ping Test Tool..."
servers=()

for i in {1..5}; do
    read -p "Enter server $i hostname or IP: " srv
    if [[ -z "$srv" || 
        ! "$srv" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ && 
        ! "$srv" =~ ^[a-zA-Z0-9.-]+$ ]]; then
        echo "Invalid hostname or IP. Try again."
        ((i--))
        continue
    fi
    servers+=("$srv")
done

echo "Pinging your 5 servers..."
echo "--------------------------------"

for s in "${servers[@]}"; do
    echo "Pinging $s..."
    ping -c 4 "$s" >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "✓ $s is reachable."
    else
        echo "✗ $s is NOT reachable."
    fi

    echo "--------------------------------"
done

echo "Ping Test Tool finished."