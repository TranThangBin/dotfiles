local M = {}

local rng = vim.fn.rand() % 6

table.insert(M, {
	"rose-pine/neovim",
	name = "rose-pine",
	opts = {
		styles = { transparency = true },
		variant = "auto",
		dark_variant = "moon",
		dim_inactive_windows = false,
		extend_background_behind_borders = true,
	},
	config = function(_, opts)
		local rose_pine = require("rose-pine")
		rose_pine.setup(opts)

		if rng ~= 5 then
			rose_pine.colorscheme("moon")
		end
	end,
})

table.insert(M, {
	"folke/tokyonight.nvim",
	opts = {
		styles = {
			comments = { italic = false },
			keywords = { italic = false },
		},
	},
})

table.insert(M, {
	"catppuccin/nvim",
	name = "catppuccin",
	opts = { transparent_background = true },
	config = function(_, opts)
		local catppuccin = require("catppuccin")
		catppuccin.setup(opts)

		if rng == 5 then
			catppuccin.load("mocha")
		end
	end,
})

return M
