local set = vim.keymap.set

local sidekick_cli = require("sidekick.cli")

set({ "n", "t", "i", "x" }, "<C-.>", sidekick_cli.toggle)
