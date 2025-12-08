#!/bin/bash

# Website Status Checker Script
echo "Starting Website Status Checker..."
read -p "Enter the website URL (e.g., https://www.example.com): " Website

if ping -c 1 -W 2 "$Website" > /dev/null 2>&1; then
    echo "$Website is REACHABLE ✅ (ping succeeded)"
  else
    echo "$Website is UNREACHABLE ❌ (ping failed)"
fi