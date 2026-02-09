require("conform").setup({
	formatters = {
		templ = {
			args = {
				"fmt",
				"-prettier-required",
				"-prettier-command",
				"prettierd --stdin-filepath $TEMPL_PRETTIER_FILE_NAME",
			},
		},
	},
	default_format_opts = {
		async = true,
		lsp_format = "fallback",
		stop_after_first = true,
	},
	formatters_by_ft = {
		lua = { "stylua" },
		gdscript = { "gdformat" },
		html = { "prettierd" },
		css = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		markdown = { "prettierd" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		nix = { "nixfmt" },
		templ = { "templ" },
	},
})
