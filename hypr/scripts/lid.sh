#!/usr/bin/env bash

# Check the lid state and enable/disable the internal display accordingly
if grep -q open /proc/acpi/button/lid/LID0/state; then
    # Lid is open; enable the internal display
    hyprctl keyword monitor "eDP-1, preferred, auto, auto"
else
    # Lid is closed; disable the internal display
    hyprctl keyword monitor "eDP-1, disable"
fi

