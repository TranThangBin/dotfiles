local utils = {}

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local pos = vim.fn.getpos(".")
		vim.cmd("%s/\\s\\+$//e")
		vim.fn.setpos(".", pos)
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "ColorScheme", "OptionSet" }, {
	pattern = { "background", "bg", "rose-pine", "tokyonight", "catppuccin" },
	callback = function()
		if vim.o.background == "light" then
			utils.set_light_bg()
		end
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = { "rose-pine-dawn", "tokyonight-day", "catppuccin-latte" },
	callback = function()
		if vim.o.background == "light" then
			utils.set_light_bg()
		else
			vim.o.background = "light"
		end
	end,
})

function utils.set_light_bg(bg_color)
	bg_color = bg_color or "#dddddd"

	local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })

	if not normal_hl.bg then
		vim.api.nvim_set_hl(0, "Normal", { bg = bg_color, fg = normal_hl.fg })
	end
end
