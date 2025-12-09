#!/bin/bash

# This script reports the size of each folder in the current directory.
echo "Starting folder size report..."

Target_Dir="${1:-.}"

read -p "Do you want to include hidden folders? (y/n): " include_hidden
max_depth=1

while [[ true ]]; do 
    read -p "Enter maximum depth of subfolders to display (1 for only top-level): " max_depth

    if [[ "$max_depth" =~ ^[1-9][0-9]*$ ]]; then
        break
    else
        echo "Error: Maximum depth must be a positive integer."
    fi
done

echo "Folder size report for: $Target_Dir (max depth: $max_depth)"
echo "-----------------------------------------------------------"

report_sizes() {
    local dir="$1"
    local depth="$2"
    local prefix="$3"

    if (( depth > max_depth )); then
        return
    fi

    shopt -s nullglob
    for folder in "$dir"/*/; do
        # Skip hidden folders if user said no
        if [[ "$include_hidden" != "y" && "$(basename "$folder")" == .* ]]; then
            continue
        fi
        folder_size=$(du -sh "$folder" 2>/dev/null | awk '{print $1}')
        echo "${prefix}${folder_size} - $(basename "$folder")"
        report_sizes "$folder" $((depth + 1)) "$prefix    "
    done
}

report_sizes "$Target_Dir" 1 ""