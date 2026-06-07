#!/bin/bash

log_file="../logs/system_report.log"

while true; do

    cpu=$(top -bn1 | awk '/Cpu/ {print 100 - $8}')
    ram=$(free | awk '/Mem/ {printf "%.1f", $3/$2 * 100.0}')
    disk=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

    if (( $(echo "$cpu > 80" | bc -l) )); then
        echo "$(date) HIGH CPU: $cpu%" >> $log_file
        echo "HIGH CPU: $cpu%"
    fi

    if (( $(echo "$ram > 90" | bc -l) )); then
        echo "$(date) HIGH RAM: $ram%" >> $log_file
        echo "HIGH RAM: $ram%"
    fi

    if (( $disk > 90 )); then
        echo "$(date) HIGH DISK: $disk%" >> $log_file
        echo "HIGH DISK: $disk%"
    fi

    sleep 2
done