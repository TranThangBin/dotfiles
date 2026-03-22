local set = vim.keymap.set

local ts_ctx = require("treesitter-context")

set("n", "<leader>ct", ts_ctx.toggle, {
    desc = "Custom(treesitter-context): toggle [c]on[t]ext",
})
set("n", "[ct", ts_ctx.go_to_context, {
    desc = "Custom(treesitter-context): go to [c]on[t]ext",
})
