local rng = vim.fn.rand() % 11

local colorscheme = "rose-pine"

if rng >= 9 then
	colorscheme = "tokyonight"
elseif rng >= 7 then
	colorscheme = "catppuccin"
end

vim.cmd.colorscheme(colorscheme)
