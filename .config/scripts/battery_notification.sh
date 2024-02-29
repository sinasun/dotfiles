#!/bin/bash
# Get battery percentage using UPower
battery_percentage=$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | awk '{print $2}' | tr -d '%')
# Check if the charger is connected
charger_connected=$(upower -i $(upower -e | grep 'BAT') | grep -E "state" | awk '{print $2}')

# Set the thresholds for notifications
low_battery_threshold=15
critical_battery_threshold=5
full_charge_threshold=100

# Check battery percentage and take appropriate actions
if [ "$charger_connected" == "discharging" ]; then
    if [ "$battery_percentage" -lt "$critical_battery_threshold" ]; then
        # Battery is critically low, put the laptop to sleep
        notify-send "Low Battery" "Battery is critically low: $battery_percentage%. Putting the laptop to sleep."
        systemctl suspend
    elif [ "$battery_percentage" -lt "$low_battery_threshold" ]; then
        # Battery is low, send a notification
        notify-send "Low Battery" "Battery is low: $battery_percentage%. Consider charging the laptop."
    fi
else
    if [ "$battery_percentage" -eq "$full_charge_threshold" ]; then
        # Battery is fully charged, send a notification
        notify-send "Full Charge" "Battery is fully charged: $battery_percentage%. You may unplug the charger."
	fi
fi

