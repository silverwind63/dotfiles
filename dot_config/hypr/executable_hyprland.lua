require("keybinds")
require("env")
require("autostart")
require("animation")
require("configs")
require("appearance")
------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@144.01Hz", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "0x0", scale = 1 })
hl.monitor({ output = "eDP-1", mode = "preferred", position = "1920x0", scale = 1 })
