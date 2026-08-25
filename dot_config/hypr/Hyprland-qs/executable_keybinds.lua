---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("foot"))
hl.bind(mainMod .. " +CTRL + Return", hl.dsp.exec_cmd("foot -e tmux"))

hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures"))

-- Close window or kill it
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.window.kill())

-- Shutdown Hyprland
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- Group Binding
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + CTRL + G", hl.dsp.group.lock())
hl.bind(mainMod .. " + TAB", hl.dsp.group.next())
hl.bind(mainMod .. " + CTRL + TAB", hl.dsp.group.prev())

-- Launcher and power menu and clip board
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("wmenu-run -f \"JetBrainsMono Nerd Font 14\" -i -N 1e2326 -n d3c6aa -M 1e2326 -m d3c6aa -S a7c080 -s 1e2326 -i"))
hl.bind(mainMod .. " + CTRL + D", hl.dsp.exec_cmd("~/.config/hypr/scripts/powermenu.sh"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.config/hypr/scripts/clipboard.sh"))

-- Maximized  a window
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Switch to floating
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))

-- Swap column to left or right
hl.bind(mainMod .. " + CTRL + H", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + A", hl.dsp.layout("focus l"))
hl.bind(mainMod .. " + S", hl.dsp.layout("focus r"))
-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + CTRL + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	-- local monitorID = hl.get_active_workspace().monitor.id
	hl.bind(mainMod .. " + " .. key, function()
		local workspace_id = hl.get_active_workspace().monitor.id * 10 + i
		hl.dispatch(hl.dsp.focus({ workspace = workspace_id }))
	end)

	hl.bind(mainMod .. " + CTRL +" .. key, function()
		local workspace_id = hl.get_active_workspace().monitor.id * 10 + i
		hl.dispatch(hl.dsp.window.move({ workspace = workspace_id }))
	end)
end

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

-- Scroll through existing workspaces with mainMod + scroll
-- hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Make column larger in scrolling layout
-- hl.bind(mainMod .. " + H", hl.dsp.layout("colresize -0.05"))
-- hl.bind(mainMod .. " + L", hl.dsp.layout("colresize +0.05"))
--
-- Swap column to left or right
-- hl.bind(mainMod .. " + CTRL + H", hl.dsp.layout("swapcol l"))
-- hl.bind(mainMod .. " + CTRL + L", hl.dsp.layout("swapcol r"))
-- hl.bind(mainMod .. " + A", hl.dsp.layout("focus l"))
-- hl.bind(mainMod .. " + S", hl.dsp.layout("focus r"))

-- Toggle window to fullscreen
-- hl.bind("SUPER + F", function()
-- 	hl.dispatch(hl.dsp.layout("colresize +conf"))
-- 	hl.dispatch(hl.dsp.layout("focus r"))
-- 	hl.dispatch(hl.dsp.layout("focus l"))
-- end, { description = "Toggle active window to maximized (scrolling)" })
