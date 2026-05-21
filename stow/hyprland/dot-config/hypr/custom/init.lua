local catppuccin_mocha = require("custom.colors.catpuccin-mocha")

local surface0 = catppuccin_mocha.surface0.hex
local surface0Alpha = surface0 .. "e6"
local pink = catppuccin_mocha.pink.hex
local flamingoAlpha = catppuccin_mocha.flamingo.hex .. "e6"

hl.config({
    general = {
        layout = "scrolling",
        allow_tearing = false,
        border_size = 2,
        ["col.active_border"] = pink,
        ["col.inactive_border"] = surface0Alpha,
        ["col.nogroup_border"] = surface0,
        ["col.nogroup_border_active"] = flamingoAlpha,
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
        shadow = {
            color = surface0,
            color_inactive = surface0Alpha,
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
