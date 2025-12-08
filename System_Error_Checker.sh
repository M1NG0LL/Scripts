#!/bin/bash

# Check Error Checker Script

echo "Starting System Error Checker..."

powershell.exe "
# Grab recent system errors & warnings (last 24 hours)
\$events = Get-WinEvent -FilterHashtable @{
    LogName = 'System';
    Level = @(1,2,3); # Critical, Error, Warning
    StartTime = (Get-Date).AddHours(-24)
} | Select-Object TimeCreated, LevelDisplayName, ProviderName, Message

if (\$events) {
    \$i = 1
    foreach (\$e in \$events) {
        Write-Output \"\$i. [\$(\$e.LevelDisplayName)] from \$(\$e.ProviderName)\"
        Write-Output \"   Time: \$(\$e.TimeCreated)\"
        Write-Output \"   Msg:  \$(\$e.Message)\"
        Write-Output \"----------------------------------------------------\"
        \$i++
    }
} else {
    Write-Output 'No system errors found in the last 24 hours!'
}
"