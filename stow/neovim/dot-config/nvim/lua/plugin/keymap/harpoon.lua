local set = vim.keymap.set

local harpoon = require("harpoon")
local ui = harpoon.ui
local list = harpoon:list()

set("n", "<leader>a", function()
	list:add()
end)
set("n", "<leader>m", function()
	ui:toggle_quick_menu(list)
end)
set("n", "<C-l>", function()
	list:next()
end)
set("n", "<C-h>", function()
	list:prev()
end)

for i = 1, 9 do
	set("n", "<leader>" .. i, function()
		list:select(i)
	end)
end
