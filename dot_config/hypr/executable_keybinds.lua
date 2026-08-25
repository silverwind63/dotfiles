---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local prev_workspace_id = 0
local temp_workspace_id = 0

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("foot"))
hl.bind(mainMod .. " + CTRL + Return", hl.dsp.exec_cmd("foot -e tmux"))

hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures"))

-- Close window or kill it
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.window.kill())

-- Shutdown Hyprland
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- Launcher and power menu and clip board
hl.bind(
	mainMod .. " + D",
	hl.dsp.exec_cmd(
		'wmenu-run -f "JetBrainsMono Nerd Font 14" -i -N 1e2326 -n d3c6aa -M 1e2326 -m d3c6aa -S a7c080 -s 1e2326 -i'
	)
)
hl.bind(mainMod .. " + CTRL + D", hl.dsp.exec_cmd("~/.config/hypr/scripts/powermenu.sh"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.config/hypr/scripts/clipboard.sh"))

-- Maximized  a window
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Switch to floating
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))

-- Swap column to left or right
hl.bind(mainMod .. " + H", hl.dsp.window.resize({ x = -500, y = 100 }))
hl.bind(mainMod .. " + L", hl.dsp.window.resize({ x = 500, y = 100 }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + CTRL + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	-- local monitorID = hl.get_active_workspace().monitor.id
	hl.bind(mainMod .. " + " .. key, function()
		temp_workspace_id = prev_workspace_id
		prev_workspace_id = hl.get_active_workspace().id
		local workspace_id = hl.get_active_workspace().monitor.id * 10 + i
		hl.dispatch(hl.dsp.focus({ workspace = workspace_id }))
		if prev_workspace_id == hl.get_active_workspace().id then
			prev_workspace_id = temp_workspace_id
		end
	end)

	hl.bind(mainMod .. " + CTRL +" .. key, function()
		local workspace_id = hl.get_active_workspace().monitor.id * 10 + i
		hl.dispatch(hl.dsp.window.move({ workspace = workspace_id }))
	end)
end

hl.bind(mainMod .. " + P", function()
	temp_workspace_id = prev_workspace_id
	prev_workspace_id = hl.get_active_workspace().id
	hl.dispatch(hl.dsp.focus({ workspace = temp_workspace_id }))
end)

-- Switch monitors with mainMod + Tab
-- Move active window to a workspace with mainMod + CTRL + Tab
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + CTRL + Tab", function()
	hl.dispatch(hl.dsp.focus({ monitor = "+1" }))
	local workspaceID = hl.get_active_workspace().id
	hl.dispatch(hl.dsp.focus({ monitor = "+1" }))
	hl.dispatch(hl.dsp.window.move({ workspace = workspaceID }))
end)

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Cycle through existing workspaces
hl.bind(mainMod .. " + CTRL + A", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.focus({ workspace = "m+1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
