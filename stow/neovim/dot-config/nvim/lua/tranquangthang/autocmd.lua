local function set_light_bg(bg_color)
	bg_color = bg_color or "#dddddd"

	local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })

	if not normal_hl.bg then
		vim.api.nvim_set_hl(0, "Normal", { bg = bg_color, fg = normal_hl.fg })
	end
end

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local pos = vim.fn.getpos(".")
		vim.cmd("%s/\\s\\+$//e")
		vim.fn.setpos(".", pos)
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "ColorScheme", "OptionSet" }, {
	pattern = { "background", "bg", "rose-pine", "tokyonight", "catppuccin" },
	callback = function()
		if vim.o.background == "light" then
			set_light_bg()
		end
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = { "rose-pine-dawn", "tokyonight-day", "catppuccin-latte" },
	callback = function()
		if vim.o.background == "light" then
			set_light_bg()
		else
			vim.o.background = "light"
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*",
	callback = function(e)
		local ok, telescope_builtin = pcall(require, "telescope.builtin")

		local map = function(mode, lhs, rhs, opts)
			opts = opts or {}
			opts.buffer = e.buf
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		if ok then
			map("n", "gd", function()
				telescope_builtin.lsp_definitions()
			end)
			map("n", "gr", function()
				telescope_builtin.lsp_references()
			end)
			map("n", "<leader>ws", function()
				telescope_builtin.lsp_workspace_symbols()
			end)
			map("n", "<leader>ds", function()
				telescope_builtin.lsp_document_symbols()
			end)
		else
			map("n", "gd", function()
				vim.lsp.buf.definition()
			end)
			map("n", "gr", function()
				vim.lsp.buf.references()
			end)
			map("n", "<leader>ws", function()
				vim.lsp.buf.workspace_symbol()
			end)
			map("n", "<leader>ds", function()
				vim.lsp.buf.document_symbol()
			end)
		end

		map({ "n", "x" }, "<leader>ca", function()
			vim.lsp.buf.code_action()
		end)
		map("n", "<leader>rn", function()
			vim.lsp.buf.rename()
		end)
		map("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end)
		map("n", "<leader>vd", function()
			vim.diagnostic.open_float({ border = "rounded" })
		end)
		map("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end)
		map("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end)
		map({ "n", "i" }, "<C-s>", function()
			vim.lsp.buf.signature_help({ border = "rounded" })
		end)
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function(e)
		local filename = vim.fs.basename(e.file)
		local file_pattern = "^" .. vim.fn.escape(filename, [[\/.*~]])

		local filetype = vim.fn.getftype(e.file)
		local fileperm = vim.fn.getfperm(e.file)

		if filetype == "link" then
			file_pattern = file_pattern .. "@"
		elseif
			fileperm:sub(3, 3) == "x"
			or fileperm:sub(6, 6) == "x"
			or fileperm:sub(9, 9) == "x"
		then
			file_pattern = file_pattern .. "\\*"
		else
			file_pattern = file_pattern .. "$"
		end

		vim.keymap.set("n", "<leader>e", function()
			vim.cmd.Explore()
			vim.fn.search(file_pattern)
		end, { buffer = e.buf })
	end,
})
