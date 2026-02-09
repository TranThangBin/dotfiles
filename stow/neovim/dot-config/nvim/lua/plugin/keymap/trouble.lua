local set = vim.keymap.set

local trouble = require("trouble")

set("n", "<leader>xx", function()
	trouble.toggle("diagnostics")
end)
set("n", "<leader>xX", function()
	trouble.toggle({
		source = "diagnostics",
		filter = {
			buf = 0,
		},
	})
end)
set("n", "<leader>cs", function()
	trouble.toggle({ source = "symbols", focus = false })
end)
set("n", "<leader>cl", function()
	trouble.toggle({
		source = "lsp",
		focus = false,
		win = {
			position = "right",
		},
	})
end)
set("n", "<leader>xL", function()
	trouble.toggle({ source = "loclist" })
end)
set("n", "<leader>xQ", function()
	trouble.toggle({ source = "qflist" })
end)
