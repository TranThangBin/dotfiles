local set = vim.keymap.set

local builtin = require("telescope.builtin")

set("n", "<leader>tf", builtin.find_files, {
    desc = "Custom(telescope): [t]elescope [f]iles",
})
set("n", "<leader>tg", builtin.git_files, {
    desc = "Custom(telescope): [t]elescope [g]it",
})
set("n", "<leader>tk", builtin.keymaps, {
    desc = "Custom(telescope): [t]elescope [k]eys",
})
set("n", "<leader>bf", builtin.buffers, {
    desc = "Custom(telescope): [b]u[f]fers",
})
set("n", "<leader>lg", builtin.live_grep, {
    desc = "Custom(telescope): [l]ive [g]rep",
})
set("n", "<leader>of", builtin.oldfiles, {
    desc = "Custom(telescope): [o]ld [f]iles",
})
set("n", "<leader>rs", builtin.resume, {
    desc = "Custom(telescope): [r]e[s]ume",
})
