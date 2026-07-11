local set = vim.keymap.set

local jump = require("todo-comments.jump")

set("n", "<leader>ttf", "<cmd>TodoTelescope<CR>")
set("n", "<leader>txx", "<cmd>TodoTrouble<CR>")
set("n", "]t", jump.next)
set("n", "[t", jump.prev)
