local set = vim.keymap.set

local zen_mode = require("zen-mode")

set("n", "<leader>zz", zen_mode.toggle)
set("n", "<leader>zZ", function()
    zen_mode.toggle({
        window = {
            width = 0.7,
            options = {
                signcolumn = "no",
                number = false,
                relativenumber = false,
                cursorline = false,
                cursorcolumn = false,
                foldcolumn = "0",
                colorcolumn = "0",
                list = false,
            },
        },
    })
end)
