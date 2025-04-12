#!/bin/bash
choice=$(wofi --show dmenu --prompt="Power Menu" << EOF
󰐥 Shutdown
󰜉 Reboot
󰍃 Logout
󰤄 Lock
EOF
)

case "$choice" in
    "󰐥 Shutdown") systemctl poweroff ;;
    "󰜉 Reboot") systemctl reboot ;;
    "󰍃 Logout") loginctl terminate-user $USER ;;
    "󰤄 Lock") hyprlock ;;
esac
