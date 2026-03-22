local set = vim.keymap.set

local gitsigns_actions = require("gitsigns.actions")

set("n", "<leader>hs", gitsigns_actions.stage_hunk, {
    desc = "Custom(gitsigns): [h]unk [s]tage",
})
set("x", "<leader>hs", function()
    gitsigns_actions.stage_hunk({
        vim.fn.line("."),
        vim.fn.line("v"),
    })
end, {
    desc = "Custom(gitsigns): [h]unk [s]tage",
})
set("n", "<leader>hS", gitsigns_actions.stage_buffer, {
    desc = "Custom(gitsigns): [h]unk [S]tage buffer",
})
set("n", "<leader>hr", gitsigns_actions.reset_hunk, {
    desc = "Custom(gitsigns): [h]unk [r]eset",
})
set("x", "<leader>hr", function()
    gitsigns_actions.reset_hunk({
        vim.fn.line("."),
        vim.fn.line("v"),
    })
end, {
    desc = "Custom(gitsigns): [h]unk [r]eset",
})
set("n", "<leader>hR", gitsigns_actions.reset_buffer, {
    desc = "Custom(gitsigns): [h]unk [R]eset buffer",
})
set("n", "<leader>hp", gitsigns_actions.preview_hunk, {
    desc = "Custom(gitsigns): [h]unk [p]review",
})
set("n", "<leader>hP", gitsigns_actions.preview_hunk_inline, {
    desc = "Custom(gitsigns): [h]unk [p]review inline",
})
set("n", "<leader>tb", gitsigns_actions.toggle_current_line_blame, {
    desc = "Custom(gitsigns): [t]oggle [b]lame",
})
set("n", "<leader>hd", gitsigns_actions.diffthis, {
    desc = "Custom(gitsigns): [h]unk [d]iffthis",
})
set("n", "<leader>hD", function()
    gitsigns_actions.diffthis("~")
end, {
    desc = "Custom(gitsigns): [h]unk [d]iffthis HEAD~1",
})
set("n", "<leader>hb", function()
    gitsigns_actions.blame_line({ full = true })
end, {
    desc = "Custom(gitsigns): [h]unk [b]lame line",
})
set("n", "]g", function()
    if vim.wo.diff then
        vim.cmd.normal({ "]g", bang = true })
    else
        gitsigns_actions.nav_hunk("next")
    end
end, {
    desc = "Custom(gitsigns): ]g (nav hunk next)",
})
set("n", "[g", function()
    if vim.wo.diff then
        vim.cmd.normal({ "[g", bang = true })
    else
        gitsigns_actions.nav_hunk("prev")
    end
end, {
    desc = "Custom(gitsigns): [g (nav hunk prev)",
})
set({ "o", "x" }, "ih", gitsigns_actions.select_hunk, {
    desc = "Custom(gitsigns): select [i]nside [h]unk",
})
