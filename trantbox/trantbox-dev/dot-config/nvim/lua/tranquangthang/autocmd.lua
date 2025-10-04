local my_group = vim.api.nvim_create_augroup("tranquangthang", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = my_group,
	pattern = "*",
	callback = function()
		local pos = vim.fn.getpos(".")
		vim.cmd("%s/\\s\\+$//e")
		vim.fn.setpos(".", pos)
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = my_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = my_group,
	pattern = "*",
	callback = function(e)
		local ok, conform = pcall(require, "conform")
		local opts = {
			bufnr = e.buf,
			async = true,
			lsp_format = "fallback",
			stop_after_first = true,
		}

		if ok then
			vim.keymap.set("n", "<leader>f", function()
				conform.format(opts)
			end, { buffer = e.buf })
		else
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format(opts)
			end, { buffer = e.buf })
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = my_group,
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

		map("n", "<leader>ca", function()
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
