-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	-- hl.exec_cmd("quickshell -p ~/.config/quickshell/Everforest/shell.qml")
	hl.exec_cmd("awww-daemon")
	-- hl.exec_cmd("dunst")
	hl.exec_cmd("wl-paste --type text image --watch cliphist store")
	hl.exec_cmd("mpd")
	hl.exec_cmd("fcitx5")
	-- hl.exec_cmd("hyprctl setcursor everforest-cursors 32")
end)
