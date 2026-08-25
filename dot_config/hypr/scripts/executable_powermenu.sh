# Define the array directly in your terminal
power_opt=("reboot"  "poweroff" "suspend")
op=$(printf '%s\n' "${power_opt[@]}" | wmenu -f "JetBrainsMono Nerd Font 14" -N 1e2326 -n d3c6aa -M 1e2326 -m d3c6aa -S a7c080 -s 1e2326 -i -l 3)
eval "$op"
