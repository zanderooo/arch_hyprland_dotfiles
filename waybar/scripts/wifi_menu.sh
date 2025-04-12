#!/bin/bash
ROFI_CMD="rofi -dmenu -i -p WiFi -theme ~/.config/rofi/wifi.rasi"
LIST=$(nmcli --fields "SSID,SECURITY,BARS" device wifi list | sed '/--/d' | awk -F'  +' '{print $1 " [" $2 "] " $3}' | sort -u)
CHOICE=$(echo -e "$LIST\n Disconnect" | $ROFI_CMD | awk '{print $1}')

if [ "$CHOICE" = " Disconnect" ]; then
    nmcli connection down "$(nmcli -t -f NAME connection show --active | head -1)"
elif [ -n "$CHOICE" ]; then
    nmcli device wifi connect "$CHOICE"
fi
