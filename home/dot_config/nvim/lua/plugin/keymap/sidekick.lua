local set = vim.keymap.set

local sidekick_cli = require("sidekick.cli")

set({ "n", "t", "i", "x" }, "<C-.>", function()
    sidekick_cli.toggle({ name = "opencode" })
end, {
    desc = "Custom(sidekick): <C-.> (toggle opencode)",
})

set({ "n", "x" }, "<leader>at", function()
    sidekick_cli.send({ name = "opencode", msg = "{this}" })
end, {
    desc = "Custom(sidekick): <leader>at (send this)",
})

set("n", "<leader>af", function()
    sidekick_cli.send({ name = "opencode", msg = "{file}" })
end, {
    desc = "Custom(sidekick): <leader>af (send file)",
})

set("x", "<leader>av", function()
    sidekick_cli.send({ name = "opencode", msg = "{selection}" })
end, {
    desc = "Custom(sidekick): <leader>av (send visual selection)",
})

set({ "n", "x" }, "<leader>ap", function()
    sidekick_cli.prompt()
end, {
    desc = "Custom(sidekick): <leader>ap (select prompt)",
})
