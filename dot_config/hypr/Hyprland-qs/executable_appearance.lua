-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 6,

		border_size = 3,

		col = {
			active_border = "rgb(dbbc7f)",
			inactive_border = "rgb(7a8478)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "scrolling",
	},

	decoration = {
		rounding = 0,
		-- rounding = 13,
		-- rounding_power = 10,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
			range = 10,
			-- render_power = 3,
			-- color = 0xee1a1a1a,
		},

		blur = {
			enabled = false,
			size = 9,
			passes = 3,
			noise = 0.0234,
		},
	},

	animations = {
		enabled = false,
	},
	group = {
			col = {
			border_active = "rgb(d3c6aa)",
			border_inactive = "rgb(272e33)",
			border_locked_active = "rgb(b9c0ab)",
			border_locked_inactive = "rgb(b9c0ab)",
		},
		groupbar = {
			font_family = "JetBrainsMono Nerd Font",
			font_size = 15,
			height = 15,
			text_color_inactive = "rgb(9da9a0)",
			text_color = "rgb(d3c6aa)",
			indicator_height = 20,
			indicator_gap = -16,
			col = {
				active = "rgb(1e2326)",
				inactive = "rgb(374145)",
				locked_active = "rgb(232a2e)",
				locked_inactive = "rgb(3d484d)",
			},
		},
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
	},
})
