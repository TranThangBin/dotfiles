local set = vim.keymap.set

local harpoon = require("harpoon")
local ui = harpoon.ui
local list = harpoon:list()

set("n", "<leader>a", function()
    list:add()
end, {
    desc = "Custom(harpoon): [a]dd to list",
})
set("n", "<leader>m", function()
    ui:toggle_quick_menu(list)
end, {
    desc = "Custom(harpoon): [m]enu",
})
set("n", "<C-l>", function()
    list:next()
end, {
    desc = "Custom(harpoon): <C-l> (list next entry)",
})
set("n", "<C-h>", function()
    list:prev()
end, {
    desc = "Custom(harpoon): <C-h> (list prev entry)",
})

for i = 1, 9 do
    set("n", "<leader>" .. i, function()
        list:select(i)
    end, {
        desc = string.format("Custom(harpoon): list [%d] entry", i),
    })
end
