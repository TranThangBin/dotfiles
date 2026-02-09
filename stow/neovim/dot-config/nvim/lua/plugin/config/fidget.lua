require("fidget").setup({
	notification = {
		align = "top",
		override_vim_notify = true,
		window = {
			align = "top",
			border = vim.o.winborder,
			relative = "editor",
			winblend = 0,
		},
	},
})
