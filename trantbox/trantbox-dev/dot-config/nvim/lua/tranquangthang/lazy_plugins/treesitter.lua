local M = {}

table.insert(M, {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = function()
		require("nvim-treesitter").update()
	end,
	config = function()
		local treesitter = require("nvim-treesitter")

		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"c",
				"cpp",
				"cs",
				"html",
				"css",
				"javascript",
				"typescript",
				"gdscript",
				"go",
				"dockerfile",
				"sh",
				"bash",
				"fish",
				"templ",
				"rust",
				"toml",
				"zig",
				"lua",
				"nix",
				"python",
				"json",
				"yaml",
				"hyprlang",
				"gitcommit",
				"dosini",
				"rasi",
			},
			callback = function(e)
				local lang = vim.treesitter.language.get_lang(e.match)
				treesitter.install(lang):wait(30 * 1000)
				vim.treesitter.start(e.buf, lang)
			end,
		})
	end,
})

table.insert(M, {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	opts = {
		select = {
			lookahead = true,
			selection_modes = {
				["@parameter.outer"] = "v",
				["@function.outer"] = "V",
				["@class.outer"] = "<c-v>",
			},
			include_surrounding_whitespace = false,
		},
		move = { set_jumps = true },
	},
	keys = function()
		local textobjs_select = require("nvim-treesitter-textobjects.select")
		local textobjs_swap = require("nvim-treesitter-textobjects.swap")
		local textobjs_move = require("nvim-treesitter-textobjects.move")
		local textobjs_repeat =
			require("nvim-treesitter-textobjects.repeatable_move")

		local keys_select = {
			{
				"aa",
				function()
					textobjs_select.select_textobject("@parameter.outer")
				end,
				mode = { "x", "o" },
			},
			{
				"ia",
				function()
					textobjs_select.select_textobject("@parameter.inner")
				end,
				mode = { "x", "o" },
			},
			{
				"af",
				function()
					textobjs_select.select_textobject("@function.outer")
				end,
				mode = { "x", "o" },
			},
			{
				"if",
				function()
					textobjs_select.select_textobject("@function.inner")
				end,
				mode = { "x", "o" },
			},
			{
				"ac",
				function()
					textobjs_select.select_textobject("@class.outer")
				end,
				mode = { "x", "o" },
			},
			{
				"ic",
				function()
					textobjs_select.select_textobject("@class.inner")
				end,
				mode = { "x", "o" },
			},
		}

		local keys_swap = {
			{
				"<leader>sl",
				function()
					textobjs_swap.swap_next("@parameter.inner")
				end,
			},
			{
				"<leader>sh",
				function()
					textobjs_swap.swap_previous("@parameter.inner")
				end,
			},
		}

		local keys_move = {
			{
				"]a",
				function()
					textobjs_move.goto_next("@parameter.outer")
				end,
				mode = { "n", "x", "o" },
			},
			{
				"[a",
				function()
					textobjs_move.goto_previous("@parameter.outer")
				end,
				mode = { "n", "x", "o" },
			},
			{
				"]f",
				function()
					textobjs_move.goto_next("@function.outer")
				end,
				mode = { "n", "x", "o" },
			},
			{
				"[f",
				function()
					textobjs_move.goto_previous("@function.outer")
				end,
				mode = { "n", "x", "o" },
			},
			{
				"]c",
				function()
					textobjs_move.goto_next("@class.outer")
				end,
				mode = { "n", "x", "o" },
			},
			{
				"[c",
				function()
					textobjs_move.goto_previous("@class.outer")
				end,
				mode = { "n", "x", "o" },
			},
		}

		local keys_repeat = {
			{
				";",
				textobjs_repeat.repeat_last_move_next,
				mode = { "n", "x", "o" },
			},
			{
				",",
				textobjs_repeat.repeat_last_move_previous,
				mode = { "n", "x", "o" },
			},
			{
				"f",
				textobjs_repeat.builtin_f_expr,
				mode = { "n", "x", "o" },
				expr = true,
			},
			{
				"F",
				textobjs_repeat.builtin_F_expr,
				mode = { "n", "x", "o" },
				expr = true,
			},
			{
				"t",
				textobjs_repeat.builtin_t_expr,
				mode = { "n", "x", "o" },
				expr = true,
			},
			{
				"T",
				textobjs_repeat.builtin_T_expr,
				mode = { "n", "x", "o" },
				expr = true,
			},
		}

		local keys_all = {}
		vim.list_extend(keys_all, keys_select)
		vim.list_extend(keys_all, keys_swap)
		vim.list_extend(keys_all, keys_move)
		vim.list_extend(keys_all, keys_repeat)

		return keys_all
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
