#!/bin/bash

operation=$1
if [[ $operation == "ssid" ]]; then
  iw dev wlan0 link | grep SSID | awk '{print $2}' 
fi
if [[ $operation == "strength" ]]; then
  iw dev wlan0 link | grep signal | awk '{print $2}'
fi
