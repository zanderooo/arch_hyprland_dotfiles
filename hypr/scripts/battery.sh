#!/bin/bash
capacity=$(cat /sys/class/power_supply/BAT*/capacity | head -1)
status=$(cat /sys/class/power_supply/BAT*/status | head -1)

case "$status" in
    "Charging") icon="󰂄" ;;
    "Discharging") [ $capacity -lt 20 ] && icon="󰁻" || icon="󰁿" ;;
    *) icon="󰂑" ;;
esac

echo "$icon $capacity%"
