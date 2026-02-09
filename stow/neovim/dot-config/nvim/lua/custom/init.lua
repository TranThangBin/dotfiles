vim.o.background = "dark"
vim.o.backup = false
vim.o.colorcolumn = "80"
vim.o.expandtab = true
vim.o.guicursor = ""
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.mouse = ""
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.swapfile = true
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 50
vim.o.winborder = "rounded"
vim.o.wrap = false

vim.opt.completeopt = { "menu", "menuone", "noinsert" }

vim.g.mapleader = " "
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

vim.g._treesitter_enable_filetypes = {
	"bash",
	"c",
	"cpp",
	"cs",
	"css",
	"dockerfile",
	"dosini",
	"fish",
	"gdscript",
	"gitcommit",
	"go",
	"help",
	"html",
	"hyprlang",
	"javascript",
	"json",
	"lua",
	"markdown",
	"nix",
	"python",
	"rasi",
	"rust",
	"sh",
	"templ",
	"toml",
	"typescript",
	"yaml",
	"zig",
}

require("custom.autocmd")
require("custom.keymap")
require("custom.lsp")
require("custom.plugin")
