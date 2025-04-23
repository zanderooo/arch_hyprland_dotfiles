#!/bin/bash

# ~/.config/hypr/scripts/wallpaper_select.sh

WALLPAPER_DIR="/home/zander/Wallpapers/"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

# Get display name automatically
DISPLAY=$(hyprctl monitors | awk '/Monitor/{print $2}' | head -n1)

# Get wallpapers
wallpapers=($(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) -exec basename {} \;))

# Use wofi for selection
selected=$(printf '%s\n' "${wallpapers[@]}" | wofi --dmenu --prompt "Select Wallpaper" --width 300 --height 400)

if [ -n "$selected" ]; then
    full_path="$WALLPAPER_DIR/$selected"
    
    # Set wallpaper
    hyprctl hyprpaper preload "$full_path"
    hyprctl hyprpaper wallpaper "$DISPLAY,$full_path"
    
    # Update config
    sed -i "/^wallpaper =/c\wallpaper = $DISPLAY,$full_path" "$HYPRPAPER_CONF"
    
    notify-send "Wallpaper Set" "$selected"
fi