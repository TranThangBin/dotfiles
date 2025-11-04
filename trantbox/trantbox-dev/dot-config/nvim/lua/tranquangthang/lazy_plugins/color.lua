local M = {}

local rng = vim.fn.rand() % 11
local tokyo, cat = 0, 1

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

		if not vim.list_contains({ tokyo, cat }, rng) then
			rose_pine.colorscheme()
		end
	end,
})

table.insert(M, {
	"folke/tokyonight.nvim",
	opts = {
		style = "storm",
		transparent = true,
		styles = {
			comments = { italic = false },
			keywords = { italic = false },
			sidebars = "transparent",
			floats = "transparent",
		},
	},
	config = function(_, opts)
		local tokyonight = require("tokyonight")
		tokyonight.setup(opts)

		if rng == tokyo then
			tokyonight.load()
		end
	end,
})

table.insert(M, {
	"catppuccin/nvim",
	name = "catppuccin",
	opts = {
		flavour = "mocha",
		transparent_background = true,
		float = { transparent = true },
	},
	config = function(_, opts)
		local catppuccin = require("catppuccin")
		catppuccin.setup(opts)

		if rng == cat then
			catppuccin.load()
		end
	end,
})

return M
