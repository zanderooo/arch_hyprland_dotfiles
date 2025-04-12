#!/bin/bash
CAPACITY=$(cat /sys/class/power_supply/BAT*/capacity | head -1)
STATUS=$(cat /sys/class/power_supply/BAT*/status | head -1)

case "$STATUS" in
    "Charging") ICON="󰂄" ;;
    "Discharging") [ "$CAPACITY" -lt 20 ] && ICON="󰁻" || ICON="󰁿" ;;
    *) ICON="󰂑" ;;
esac

echo "$ICON $CAPACITY%"
