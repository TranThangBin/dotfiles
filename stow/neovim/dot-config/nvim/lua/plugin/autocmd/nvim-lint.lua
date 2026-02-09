local nvim_lint = require("lint")

local lint_group =
	vim.api.nvim_create_augroup("tranquangthang/lint", { clear = true })
local states = {}

local function enable_lint(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	for _, client in ipairs(clients) do
		local ns = vim.lsp.diagnostic.get_namespace(client.id)
		vim.diagnostic.reset(ns, bufnr)
		vim.diagnostic.enable(false, { bufnr = bufnr, ns_id = ns })
	end
	vim.api.nvim_create_autocmd("BufWritePost", {
		buffer = bufnr,
		group = lint_group,
		callback = function()
			nvim_lint.try_lint()
		end,
	})
	nvim_lint.try_lint()
end

local function disable_lint(bufnr, ft)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	for _, client in ipairs(clients) do
		local ns = vim.lsp.diagnostic.get_namespace(client.id)
		vim.diagnostic.enable(true, { bufnr = bufnr, ns_id = ns })
	end
	local linters = nvim_lint._resolve_linter_by_ft(ft)
	for _, linter in ipairs(linters) do
		local ns = nvim_lint.get_namespace(linter)
		vim.diagnostic.reset(ns, bufnr)
	end
	vim.api.nvim_clear_autocmds({
		group = lint_group,
		buffer = bufnr,
		event = "BufWritePost",
	})
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = vim.tbl_keys(nvim_lint.linters_by_ft),
	callback = function(e)
		vim.api.nvim_buf_create_user_command(e.buf, "LintEnable", function()
			if not states[e.buf] then
				states[e.buf] = true
				enable_lint(e.buf)
			end
		end, {})

		vim.api.nvim_buf_create_user_command(e.buf, "LintDisable", function()
			if states[e.buf] then
				states[e.buf] = false
				disable_lint(e.buf, e.match)
			end
		end, {})

		vim.api.nvim_buf_create_user_command(e.buf, "LintInfo", function()
			vim.print({
				enabled = states[e.buf] and true or false,
				linters = nvim_lint.linters_by_ft[e.match],
				bufnr = e.buf,
				ft = e.match,
			})
		end, {})
	end,
})
