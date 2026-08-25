
operation=$1


if [[ $operation == "switch" ]]; then
	hyprctl dispatch focusmonitor +1;
fi
if [[ $operation == "move" ]]; then
	hyprctl dispatch focusmonitor +1;
  workspace_id=$(hyprctl activeworkspace -j | jq -r ".id")
	hyprctl dispatch focusmonitor +1;
	hyprctl dispatch movetoworkspace $workspace_id;
fi
