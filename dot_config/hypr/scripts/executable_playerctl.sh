# Define the array directly in your terminal
power_opt=("play-pause"  "position 5+" "position 5-" "next" "previous")

#!/usr/bin/env bash
set -euo pipefail
 
# Adjust -p if you want to target a specific player (e.g. firefox, spotify)
PLAYER="${1:-firefox}"
 
title=$(playerctl -p "$PLAYER" metadata xesam:title 2>/dev/null || echo "Unknown title")
artist=$(playerctl -p "$PLAYER" metadata xesam:artist 2>/dev/null || echo "Unknown artist")
 
op=$(printf '%s\n' "${power_opt[@]}" | wmenu -f "JetBrainsMono Nerd Font 14" -N 1e2326 -n d3c6aa -M 1e2326 -m d3c6aa -S a7c080 -s 1e2326 -i -l 5 -p "$title by $artist")
eval "playerctl $op"
