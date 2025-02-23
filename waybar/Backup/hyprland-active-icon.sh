#!/bin/bash

# Get the active window class
ACTIVE_WINDOW=$(hyprctl activewindow -j | jq -r '.class')

# Debug log path (use user directory, not root)
DEBUG_LOG="$HOME/.config/waybar/debug.log"

# Log the result for debugging
echo "Active window class: $ACTIVE_WINDOW" >> "$DEBUG_LOG"

# Ensure it's not empty or null
if [[ -z "$ACTIVE_WINDOW" || "$ACTIVE_WINDOW" == "null" ]]; then
    ACTIVE_WINDOW="unknown"
fi

# Define icon mappings
declare -A ICONS=(
    ["firefox"]=""
    ["Google-chrome"]=""
    ["code"]="󰨞"
    ["discord"]=""
    ["spotify"]=""
    ["telegram-desktop"]=""
    ["kitty"]=""
    ["alacritty"]=""
    ["thunar"]=""
)

# Get the icon for the active window or default
ICON="${ICONS[$ACTIVE_WINDOW]:-󰄛}"

# Log output
echo "Selected icon: $ICON" >> "$DEBUG_LOG"

# Output JSON
echo "{\"text\": \"$ICON\", \"class\": \"$ACTIVE_WINDOW\"}"
