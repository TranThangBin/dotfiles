vim.api.nvim_create_autocmd("FileType", {
	pattern = vim.g._treesitter_enable_filetypes,
	callback = function()
		vim.treesitter.start()
	end,
})
