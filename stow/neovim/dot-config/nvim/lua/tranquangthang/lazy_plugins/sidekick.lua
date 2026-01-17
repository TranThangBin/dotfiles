local M = {}

table.insert(M, {
	"folke/sidekick.nvim",
	opts = {},
	keys = {
		{
			"<C-.>",
			function()
				require("sidekick.cli").toggle()
			end,
			mode = { "n", "t", "i", "x" },
		},
	},
})

return M
