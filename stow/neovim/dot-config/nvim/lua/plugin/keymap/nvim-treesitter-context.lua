local set = vim.keymap.set

local ts_ctx = require("treesitter-context")

set("n", "<leader>ct", ts_ctx.toggle)
set("n", "[ct", ts_ctx.go_to_context)
