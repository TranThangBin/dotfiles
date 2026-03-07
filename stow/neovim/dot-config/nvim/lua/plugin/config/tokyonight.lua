require("tokyonight").setup({
    style = "storm",
    transparent = true,
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        sidebars = "transparent",
        floats = "transparent",
    },
    on_colors = function(_) end,
    on_highlights = function(_, _) end,
})
