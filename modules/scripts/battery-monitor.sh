#!/bin/bash

# Battery percentage at which to notify
WARNING_LEVEL=20
CRITICAL_LEVEL=10
BATTERY_PATH="/sys/class/power_supply/BAT0"

# Check if battery exists
if [ ! -d "$BATTERY_PATH" ]; then
    exit 0
fi

while true; do
    # Get battery percentage and charging status
    BATTERY_LEVEL=$(cat "$BATTERY_PATH/capacity")
    CHARGING_STATUS=$(cat "$BATTERY_PATH/status")

    if [ "$CHARGING_STATUS" != "Charging" ]; then
        if [ $BATTERY_LEVEL -le $CRITICAL_LEVEL ]; then
            notify-send -u critical "Battery Critical!" "Battery level is ${BATTERY_LEVEL}%\nPlease connect charger immediately" -i battery-empty
        elif [ $BATTERY_LEVEL -le $WARNING_LEVEL ]; then
            notify-send -u normal "Battery Low" "Battery level is ${BATTERY_LEVEL}%" -i battery-low
        fi
    fi

    # Check every 60 seconds
    sleep 60
done 