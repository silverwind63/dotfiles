-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("SAL_USE_VCLPLUGIN", "qt6")

-- For fcitx
-- hl.env("GTK_IM_MODULE=fcitx")
-- hl.env("QT_IM_MODULE=fcitx")
-- hl.env("XMODIFIERS=@im=fcitx")
