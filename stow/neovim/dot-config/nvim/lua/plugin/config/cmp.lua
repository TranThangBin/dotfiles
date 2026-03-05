local cmp = require("cmp")

local capabilities =
	vim.tbl_extend("force", vim.lsp.protocol.make_client_capabilities(), require("cmp_nvim_lsp").default_capabilities())

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-5),
		["<C-d>"] = cmp.mapping.scroll_docs(5),
	}),

	completion = {
		completeopt = vim.o.completeopt,
	},

	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "lazydev" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.filetype("sql", {
	sources = {
		{ name = "vim-dadbob-completion" },
		{ name = "buffer" },
	},
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}),
})

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
cmp.event:on("menu_opened", function()
	vim.b.copilot_suggestion_hidden = true
end)
cmp.event:on("menu_closed", function()
	vim.b.copilot_suggestion_hidden = false
end)

for server, _ in pairs(vim.lsp._enabled_configs) do
	vim.lsp.config(server, { capabilities = capabilities })
end
