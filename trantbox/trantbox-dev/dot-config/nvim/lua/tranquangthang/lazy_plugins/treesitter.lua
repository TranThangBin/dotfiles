local M = { "nvim-treesitter/nvim-treesitter-textobjects" }

table.insert(M, {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,
	opts = {
		modules = {},
		ensure_installed = { "lua" },
		ignore_install = {},
		sync_install = false,
		auto_install = true,
		indent = { enable = false },
		highlight = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<Tab>",
				node_incremental = "<Tab>",
				node_decremental = "<S-Tab>",
				scope_incremental = "<C-Space>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>sl"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>sh"] = "@parameter.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
					["]a"] = "@parameter.outer",
				},
				goto_previous = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
					["[a"] = "@parameter.outer",
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
})

table.insert(M, {
	"windwp/nvim-ts-autotag",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = true,
})

table.insert(M, {
	"nvim-treesitter/nvim-treesitter-context",
	dependencies = "nvim-treesitter/nvim-treesitter",
	opts = { enable = false },
	lazy = false,
	keys = function()
		local ts_ctx = require("treesitter-context")
		return {
			{ "<leader>ct", ts_ctx.toggle },
			{ "[ct", ts_ctx.go_to_context },
		}
	end,
})

return M
