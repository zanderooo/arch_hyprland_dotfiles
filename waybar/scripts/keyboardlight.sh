#!/bin/bash
case "$1" in
    "up") brightnessctl -d *::kbd_backlight set +10% ;;
    "down") brightnessctl -d *::kbd_backlight set 10%- ;;
    *) echo "{\"text\":\"$(brightnessctl -d *::kbd_backlight get)\"}" ;;
esac
