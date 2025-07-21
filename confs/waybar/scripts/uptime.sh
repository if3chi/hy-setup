#!/bin/bash

# Get uptime in seconds
uptime_secs=$(cut -d. -f1 /proc/uptime)

# Convert to weeks, days, hours, minutes
weeks=$(( uptime_secs / 604800 ))
days=$(( (uptime_secs % 604800) / 86400 ))
hours=$(( (uptime_secs % 86400) / 3600 ))
mins=$(( (uptime_secs % 3600) / 60 ))

output=""

[ "$weeks" -gt 0 ] && output+="${weeks}w "
[ "$days" -gt 0 ] && output+="${days}d "
[ "$hours" -gt 0 ] && output+="${hours}h "
output+="${mins}m"

echo "$output"
