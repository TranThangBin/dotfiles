local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.setup()
luasnip.filetype_extend("cs", { "unity" })

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	mapping = {
		["<C-w>"] = cmp.mapping(function()
			luasnip.jump(1)
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping(function()
			luasnip.jump(-1)
		end, { "i", "s" }),
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
})
