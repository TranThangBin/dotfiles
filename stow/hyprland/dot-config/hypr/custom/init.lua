hl.config({
    general = {
        layout = "scrolling",
        allow_tearing = false,
        border_size = 2,
        gaps_in = 5,
        gaps_out = 5,
        resize_on_border = false,
    },
    scrolling = {
        column_width = 0.9,
        explicit_column_widths = "0.4, 0.6, 0.9, 1.0",
        fullscreen_on_one_column = true,
    },
    binds = {
        drag_threshold = 10,
    },
    decoration = {
        blur = {
            enabled = true,
            passes = 1,
            size = 3,
            vibrancy = 0.2,
        },
        active_opacity = 1,
        inactive_opacity = 0.9,
        rounding = 5,
    },
    input = {
        touchpad = {
            natural_scroll = false,
        },
        follow_mouse = 1,
        kb_layout = "us",
        sensitivity = 2,
    },
    ecosystem = {
        enforce_permissions = true,
    },
})

hl.animation({
    bezier = "default",
    enabled = true,
    leaf = "workspaces",
    speed = 8,
    style = "fade",
})

require("custom.autostart")
require("custom.keybinds")
require("custom.permission")
require("custom.rules")
