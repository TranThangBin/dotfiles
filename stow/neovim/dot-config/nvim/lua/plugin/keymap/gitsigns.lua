local set = vim.keymap.set

local gitsigns_actions = require("gitsigns.actions")

set("n", "<leader>hs", gitsigns_actions.stage_hunk)
set("n", "<leader>hr", gitsigns_actions.reset_hunk)
set("n", "<leader>hS", gitsigns_actions.stage_buffer)
set("n", "<leader>hR", gitsigns_actions.reset_buffer)
set("n", "<leader>hp", gitsigns_actions.preview_hunk)
set("n", "<leader>tb", gitsigns_actions.toggle_current_line_blame)
set("n", "<leader>td", gitsigns_actions.preview_hunk_inline)
set("n", "<leader>hd", gitsigns_actions.diffthis)
set("n", "<leader>hD", function()
    gitsigns_actions.diffthis("~")
end)
set("n", "<leader>hb", function()
    gitsigns_actions.blame_line({ full = true })
end)
set("n", "]g", function()
    if vim.wo.diff then
        vim.cmd.normal({ "]g", bang = true })
    else
        gitsigns_actions.nav_hunk("next")
    end
end)
set("n", "[g", function()
    if vim.wo.diff then
        vim.cmd.normal({ "[g", bang = true })
    else
        gitsigns_actions.nav_hunk("prev")
    end
end)
set("x", "<leader>hs", function()
    gitsigns_actions.stage_hunk({
        vim.fn.line("."),
        vim.fn.line("v"),
    })
end)
set("x", "<leader>hr", function()
    gitsigns_actions.reset_hunk({
        vim.fn.line("."),
        vim.fn.line("v"),
    })
end)
set({ "o", "x" }, "ih", gitsigns_actions.select_hunk)
