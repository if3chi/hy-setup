#!/usr/bin/env bash

############ Variables ############
total_capacity=0
battery_count=0
charging=false

####### Check Batteries ########
for battery in /sys/class/power_supply/BAT*; do
  if [[ -d "$battery" ]]; then
    capacity=$(<"$battery/capacity")
    status=$(<"$battery/status")

    total_capacity=$((total_capacity + capacity))
    battery_count=$((battery_count + 1))

    if [[ "$status" == "Charging" ]]; then
      charging=true
    fi
  fi
done

########## Output ##########
if [[ $battery_count -gt 0 ]]; then
  avg_capacity=$((total_capacity / battery_count))

  # Icons from empty to full
  icons=( "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")

  # Calculate icon index based on percentage
  icon_index=$(( (avg_capacity * 10 + 5) / 100 ))  # 0 to 10
  [[ $icon_index -gt 10 ]] && icon_index=10       # clamp to max

  # Final Output
  if [[ "$charging" == true ]]; then
    echo " $avg_capacity%"
  else
    echo "${icons[$icon_index]} $avg_capacity%"
  fi
fi
