local set = vim.keymap.set

local sidekick_cli = require("sidekick.cli")

set({ "n", "t", "i", "x" }, "<C-.>", function()
    sidekick_cli.toggle({ name = "opencode" })
end, {
    desc = "Custom(sidekick): <C-.> (toggle opencode)",
})
