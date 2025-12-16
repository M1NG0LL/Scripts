#!/bin/bash

echo "Starting Ping Test Tool..."
servers=()

for i in {1..5}; do
    while true; do
        read -p "Enter server $i hostname, IP, or URL: " srv
        if [[ $srv =~ ^https?:// ]]; then
            srv=$(echo "$srv" | sed 's|^https\?://||' | cut -d'/' -f1)
        fi
        if [[ -z "$srv" || 
              ! "$srv" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ && 
              ! "$srv" =~ ^[a-zA-Z0-9.-]+$ ]]; then
            echo "Invalid hostname or IP. Try again."
        else
            servers+=("$srv")
            break
        fi
    done
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