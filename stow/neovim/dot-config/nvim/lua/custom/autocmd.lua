local utils = {}

local groups = {
	color = vim.api.nvim_create_augroup("custom/color", { clear = true }),
	highlight_on_yank = vim.api.nvim_create_augroup(
		"custom/highlight_on_yank",
		{ clear = true }
	),
	remove_trailing_spaces = vim.api.nvim_create_augroup(
		"custom/remove_trailing_spaces",
		{ clear = true }
	),
	treesitter = vim.api.nvim_create_augroup(
		"custom/treesitter",
		{ clear = true }
	),
}

vim.api.nvim_create_autocmd("BufWritePre", {
	group = groups.remove_trailing_spaces,
	callback = function()
		local pos = vim.fn.getpos(".")
		vim.cmd("%s/\\s\\+$//e")
		vim.fn.setpos(".", pos)
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = groups.highlight_on_yank,
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "ColorScheme", "OptionSet" }, {
	group = groups.color,
	pattern = { "background", "bg", "rose-pine", "tokyonight", "catppuccin" },
	callback = function()
		if vim.o.background == "light" then
			utils.set_light_bg()
		end
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	group = groups.color,
	pattern = { "rose-pine-dawn", "tokyonight-day", "catppuccin-latte" },
	callback = function()
		if vim.o.background == "light" then
			utils.set_light_bg()
		else
			vim.o.background = "light"
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = groups.treesitter,
	pattern = vim.g._treesitter_enable_filetypes,
	callback = function()
		vim.treesitter.start()
	end,
})

function utils.set_light_bg(bg_color)
	bg_color = bg_color or "#dddddd"

	local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })

	if not normal_hl.bg then
		vim.api.nvim_set_hl(0, "Normal", { bg = bg_color, fg = normal_hl.fg })
	end
end
