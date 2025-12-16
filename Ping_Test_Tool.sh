#!/bin/bash

echo "Starting Ping Test Tool..."
servers=()

for i in {1..5}; do
    while true; do
        # Prompt user for server input
        read -p "Enter server $i hostname, IP, or URL: " srv

        # remove https OR http if present
        if [[ $srv =~ ^https?:// ]]; then
            srv=${srv#http://}
            srv=${srv#https://}
            srv=${srv%%/*}
        fi

        # regex patterns for ipv4 and hostname validation
        ipv4='^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$'
        hostname='^([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)*[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?$'

        # validate if input is empty
       if [[ -z "$srv" ]]; then
            echo "Invalid input"
            continue
        fi

        # validate if input is ipv4 or hostname
        if [[ $srv =~ ^[0-9.]+$ ]]; then
            # validate ipv4
            if [[ ! $srv =~ $ipv4 ]]; then
                echo "Invalid IPv4 address"
                continue
            fi
        else
            # validate hostname
            if [[ ! $srv =~ $hostname ]]; then
                echo "Invalid hostname"
                continue
            fi
        fi
        servers+=("$srv")
        break
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