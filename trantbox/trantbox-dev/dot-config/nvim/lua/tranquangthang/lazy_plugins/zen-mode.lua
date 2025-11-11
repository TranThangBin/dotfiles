return {
	"folke/zen-mode.nvim",
	keys = function()
		local zen_mode = require("zen-mode")
		return {
			{ "<leader>zz", zen_mode.toggle },
			{
				"<leader>zZ",
				function()
					zen_mode.toggle({
						window = {
							width = 0.7,
							options = {
								signcolumn = "no",
								number = false,
								relativenumber = false,
								cursorline = false,
								cursorcolumn = false,
								foldcolumn = "0",
								colorcolumn = "0",
								list = false,
							},
						},
					})
				end,
			},
		}
	end,
	opts = {
		window = { width = 0.8 },
		plugins = { neovide = { enabled = true } },
	},
}
