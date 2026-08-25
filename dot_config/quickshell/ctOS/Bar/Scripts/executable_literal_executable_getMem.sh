#!/bin/bash

operation=$1
if [[ $operation == "percentage" ]]; then
  free -m | grep "Mem" | awk '{print $3/$2}'
fi
if [[ $operation == "usage" ]]; then
  free -h | awk '/Mem:/ {gsub(/[A-Za-z]/,"",$3); print $3}'
fi
