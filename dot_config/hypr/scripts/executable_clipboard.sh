#!/bin/bash
cliphist list | awk '{$1=""; print substr($0,2)}' | wmenu -f "JetBrainsMono Nerd Font 14" -N 1e2326 -n d3c6aa -M 1e2326 -m d3c6aa -S a7c080 -s 1e2326 -i -l 15 | wl-copy
