local M = {}

table.insert(M, {
	"neovim/nvim-lspconfig",
	config = function()
		vim.diagnostic.config({
			virtual_text = true,
			severity_sort = true,
			float = {
				style = "minimal",
				border = "rounded",
				source = true,
				header = "",
				prefix = "",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "✘",
					[vim.diagnostic.severity.WARN] = "▲",
					[vim.diagnostic.severity.HINT] = "⚑",
					[vim.diagnostic.severity.INFO] = "»",
				},
			},
		})

		vim.lsp.enable({
			"clangd",
			"html",
			"cssls",
			"emmet_language_server",
			"tailwindcss",
			"ts_ls",
			"gdscript",
			"gopls",
			"dockerls",
			"docker_compose_language_service",
			"bashls",
			"fish_lsp",
			"templ",
			"rust_analyzer",
			"taplo",
			"zls",
			"lua_ls",
			"nil_ls",
			"ruff",
			"pyright",
			"jsonls",
			"yamlls",
			"hyprls",
		})
	end,
})

table.insert(M, {
	"seblyng/roslyn.nvim",
	ft = "cs",
	opts = {},
	config = function(_, opts)
		require("roslyn").setup(opts)
		vim.lsp.enable("roslyn")
	end,
})

table.insert(M, {
	"mfussenegger/nvim-lint",
	config = function()
		local nvim_lint = require("lint")
		nvim_lint.linters_by_ft = {
			lua = { "luacheck" },
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },
		}
		local lint_group =
			vim.api.nvim_create_augroup("tranquangthang/lint", { clear = true })

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
				local state = false

				vim.api.nvim_buf_create_user_command(
					e.buf,
					"LintEnable",
					function()
						if not state then
							state = true
							enable_lint(e.buf)
						end
					end,
					{}
				)

				vim.api.nvim_buf_create_user_command(
					e.buf,
					"LintDisable",
					function()
						if state then
							state = false
							disable_lint(e.buf, e.match)
						end
					end,
					{}
				)

				vim.api.nvim_buf_create_user_command(
					e.buf,
					"LintInfo",
					function()
						vim.print({
							enabled = state,
							linters = nvim_lint.linters_by_ft[e.match],
							bufnr = e.buf,
							ft = e.match,
						})
					end,
					{}
				)
			end,
		})
	end,
})

table.insert(M, {
	"stevearc/conform.nvim",
	keys = function()
		local conform = require("conform")
		local opts = {
			async = true,
			lsp_format = "fallback",
			stop_after_first = true,
		}

		return {
			{
				"<leader>f",
				function()
					if not pcall(conform.format, opts) then
						vim.lsp.buf.format(opts)
					end
				end,
			},
		}
	end,
	opts = {
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
			bash = { "shfmt" },
			nix = { "nixfmt" },
			templ = { "templ" },
			cs = { "csharpier" },
		},
	},
})

table.insert(M, {
	"mason-org/mason.nvim",
	dependencies = { "j-hui/fidget.nvim" },
	opts = {
		registries = {
			"github:mason-org/mason-registry",
			"github:Crashdummyy/mason-registry",
		},
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
	config = function(_, opts)
		local fidget = require("fidget")

		require("mason").setup(opts)

		local registry = require("mason-registry")

		local lsp_servers = { "lua-language-server" }
		local formatters = { "stylua" }
		local linters = { "luacheck" }

		local pkgs = {}
		vim.list_extend(pkgs, lsp_servers)
		vim.list_extend(pkgs, formatters)
		vim.list_extend(pkgs, linters)

		for _, pkg_name in pairs(pkgs) do
			local ok, pkg = pcall(registry.get_package, pkg_name)
			if ok and not pkg:is_installed() then
				local handle = fidget.progress.handle.create({
					title = "MasonInstall",
					message = string.format(
						pkg_name .. " is being installed..."
					),
					lsp_client = { name = "Mason" },
					done = false,
				})

				pkg:install({}, function(success, _)
					local msg = pkg_name .. " has been successfully installed!"

					if not success then
						msg = pkg_name .. " installation was unsuccessful!"
					end

					handle:report({
						message = msg,
						done = true,
					})
				end)
			end
		end
	end,
})

table.insert(M, {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		debug = false,
		runtime = vim.env.VIMRUNTIME,
		library = { path = "${3rd}/luv/library", words = { "vim%.uv" } },
		integrations = { lspconfig = true, cmp = true, coq = false },
		enabled = function(root_dir)
			return (vim.g.lazydev_enabled == nil or vim.g.lazydev_enabled)
				and not vim.uv.fs_stat(root_dir .. "/.luarc.json")
		end,
	},
})

table.insert(M, {
	"b0o/SchemaStore.nvim",
	config = function()
		vim.lsp.config("jsonls", {
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
		vim.lsp.config("yamlls", {
			yaml = {
				schemas = require("schemastore").yaml.schemas(),
				schemaStore = {
					enable = false,
					url = "",
				},
			},
		})
	end,
})

return M
