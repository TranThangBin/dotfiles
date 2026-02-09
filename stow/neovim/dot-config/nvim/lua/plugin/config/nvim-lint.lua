local nvim_lint = require("lint")
nvim_lint.linters_by_ft = {
	lua = { "luacheck" },
	sh = { "shellcheck" },
	bash = { "shellcheck" },
	zsh = { "shellcheck" },
}
