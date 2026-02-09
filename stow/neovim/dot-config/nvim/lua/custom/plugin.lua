local function gh(x)
	return "https://github.com/" .. x
end

vim.pack.add({
	gh("L3MON4D3/LuaSnip"),
	gh("ThePrimeagen/vim-be-good"),
	gh("b0o/SchemaStore.nvim"),
	gh("catgoose/nvim-colorizer.lua"),
	gh("catppuccin/nvim"),
	gh("eduardo-antunes/plainline"),
	gh("folke/lazydev.nvim"),
	gh("folke/sidekick.nvim"),
	gh("folke/todo-comments.nvim"),
	gh("folke/tokyonight.nvim"),
	gh("folke/trouble.nvim"),
	gh("folke/zen-mode.nvim"),
	gh("habamax/vim-godot"),
	gh("hrsh7th/cmp-buffer"),
	gh("hrsh7th/cmp-cmdline"),
	gh("hrsh7th/cmp-nvim-lsp"),
	gh("hrsh7th/cmp-path"),
	gh("hrsh7th/nvim-cmp"),
	gh("j-hui/fidget.nvim"),
	gh("kylechui/nvim-surround"),
	gh("laytan/cloak.nvim"),
	gh("lewis6991/gitsigns.nvim"),
	gh("m4xshen/hardtime.nvim"),
	gh("mason-org/mason.nvim"),
	gh("mbbill/undotree"),
	gh("mfussenegger/nvim-lint"),
	gh("neovim/nvim-lspconfig"),
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope-fzf-native.nvim"),
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-treesitter/nvim-treesitter-context"),
	gh("nvim-treesitter/nvim-treesitter-textobjects"),
	gh("onsails/lspkind.nvim"),
	gh("prichrd/netrw.nvim"),
	gh("pteroctopus/faster.nvim"),
	gh("rafamadriz/friendly-snippets"),
	gh("rose-pine/neovim"),
	gh("saadparwaiz1/cmp_luasnip"),
	gh("seblyng/roslyn.nvim"),
	gh("stevearc/conform.nvim"),
	gh("stevearc/oil.nvim"),
	gh("tpope/vim-fugitive"),
	gh("tpope/vim-obsession"),
	gh("windwp/nvim-autopairs"),
	{ src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		local path = ev.data.path

		if kind == "install" or kind == "update" then
			if name == "LuaSnip" then
				vim.system({ "make", "install_jsregexp" }, { cwd = path })
			elseif name == "nvim-treesitter" then
				vim.cmd("TSUpdate")
			elseif name == "telescope-fzf-native.nvim" then
				vim.system({ "make" }, { cwd = path })
			end
		end
	end,
})
