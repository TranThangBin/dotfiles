local group = vim.api.nvim_create_augroup("custom/color", { clear = true })

function set_light_bg(bg_color)
    bg_color = bg_color or "#dddddd"
    local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal_hl.bg then
        vim.api.nvim_set_hl(0, "Normal", { bg = bg_color, fg = normal_hl.fg })
    end
end

vim.api.nvim_create_autocmd({ "ColorScheme", "OptionSet" }, {
    group = group,
    pattern = { "background", "bg", "rose-pine", "tokyonight", "catppuccin" },
    desc = "Custom: Solid background on light theme",
    callback = function()
        if vim.o.background == "light" then
            set_light_bg()
        end
    end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    pattern = { "rose-pine-dawn", "tokyonight-day", "catppuccin-latte" },
    desc = "Custom: Solid background on light theme",
    callback = function()
        if vim.o.background == "light" then
            set_light_bg()
        else
            vim.o.background = "light"
        end
    end,
})
