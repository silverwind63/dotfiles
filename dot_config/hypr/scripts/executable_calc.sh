ans=$(echo > /dev/null | wmenu -f "JetBrainsMono Nerd Font 14" -N 1e2326 -n d3c6aa -M 1e2326 -m d3c6aa -S a7c080 -s 1e2326 -p "Calc:" | fend)
eval "notify-send $ans"
eval "wl-copy $ans"
