local set = vim.keymap.set

local builtin = require("telescope.builtin")

set("n", "<leader>tf", builtin.find_files)
set("n", "<leader>tg", builtin.git_files)
set("n", "<leader>tk", builtin.keymaps)
set("n", "<leader>bf", builtin.buffers)
set("n", "<leader>lg", builtin.live_grep)
set("n", "<leader>of", builtin.oldfiles)
set("n", "<leader>rs", builtin.resume)
