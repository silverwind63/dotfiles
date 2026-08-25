#!/bin/bash
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'percentage' | awk -F'[^0-9]*' '{print $2}'

## Get State and Percentage
#upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"
