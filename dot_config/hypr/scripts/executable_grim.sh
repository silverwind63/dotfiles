#!/bin/sh
name="$(date +"%Y-%m-%d-%H%M%S").png"
directory="$HOME/Pictures/"
timeout 10 slurp > /tmp/selection.txt 2>/dev/null
if [ $? -eq 0 ] && [ -s /tmp/selection.txt ]; then
    output="$directory/$name"
    grim -g "$(cat /tmp/selection.txt)" "$output"  
    wl-copy < $output
else
    grim "$output" | wl-copy
    wl-copy < $output
fi
rm -f /tmp/selection.txt
