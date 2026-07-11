local set = vim.keymap.set

set("n", "<leader>gs", "<cmd>Git<CR>")
set("n", "gh", "<cmd>diffget //2<CR>")
set("n", "gl", "<cmd>diffget //3<CR>")
set("n", "gH", "<cmd>%diffget //2<CR>")
set("n", "gL", "<cmd>%diffget //3<CR>")
