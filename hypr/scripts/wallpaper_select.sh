#!/bin/bash

WALLPAPER_DIR="/home/zander/Wallpapers/"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf" # Use $HOME for reliability

# Check if yad is installed
if ! command -v yad &> /dev/null; then
    notify-send "Wallpaper Selector" "Error: yad is not installed. Please install yad."
    exit 1
fi

# Check if WALLPAPER_DIR exists
if [ ! -d "$WALLPAPER_DIR" ]; then
  notify-send "Wallpaper Selector" "Wallpaper directory '$WALLPAPER_DIR' not found."
  exit 1
fi

# Prepare list for yad: Icon Path, Display Name, Full Path (hidden, used for output)
declare -a files_for_yad
while IFS= read -r -d $'\0' file_path; do
    filename=$(basename "$file_path")
    # Add Icon Path (using the image itself), Display Name, Full Path
    files_for_yad+=("$file_path" "$filename" "$file_path")
done < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) -print0)

# Check if any files were found
if [ ${#files_for_yad[@]} -eq 0 ]; then
    notify-send "Wallpaper Selector" "No image files found in '$WALLPAPER_DIR'."
    exit 1
fi

# Launch yad list dialog
# It uses the image file itself as the icon preview.
selected_path=$(yad --list \
                    --title="Select Wallpaper" \
                    --text="Choose a wallpaper:" \
                    --window-icon="preferences-desktop-wallpaper" \
                    --width=600 --height=400 \
                    --search-column=2 \
                    --button="OK:0" --button="Cancel:1" \
                    --column="Preview:IMG" \
                    --column="Filename:TEXT" \
                    --column="FullPath:TEXT" --hide-column=3 --print-column=3 \
                    "${files_for_yad[@]}")

# Exit if user pressed Cancel or closed the dialog
ret=$?
if [ $ret -ne 0 ] || [ -z "$selected_path" ]; then
    # User cancelled
    exit 0
fi

# --- Optional Check for Preload ---
# Check if the selected wallpaper is preloaded in hyprpaper.conf
if ! grep -qF "preload = $selected_path" "$HYPRPAPER_CONF"; then
    notify-send "Hyprpaper" "Preloading '$selected_path'..."
    hyprctl hyprpaper preload "$selected_path"
    # Give it a moment to preload
    sleep 0.2
fi
# --- End Optional Check ---

# Set wallpaper using hyprctl
hyprctl hyprpaper wallpaper ", cover:$selected_path"

# Optional: Send a notification
notify-send "Hyprpaper" "Set wallpaper to $(basename "$selected_path")"

exit 0
