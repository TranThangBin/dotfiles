require("mason").setup({
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
})

local registry = require("mason-registry")

local lsp_servers = { "emmylua_ls" }
local formatters = { "stylua" }
local linters = { "luacheck" }

local pkgs = {}
vim.list_extend(pkgs, lsp_servers)
vim.list_extend(pkgs, formatters)
vim.list_extend(pkgs, linters)

registry.update(function(update_success, _)
	if not update_success then
		vim.notify(
			"Mason registry was not updated successfully",
			vim.log.levels.ERROR
		)
		return
	end

	for _, pkg_name in pairs(pkgs) do
		local ok, pkg = pcall(registry.get_package, pkg_name)

		if not ok or pkg:is_installed() then
			goto continue
		end

		vim.notify(pkg_name .. " is being installed...")

		pkg:install({}, function(success, _)
			local msg = pkg_name .. " has been successfully installed!"

			if not success then
				msg = pkg_name .. " installation was unsuccessful!"
			end

			vim.notify(msg)
		end)

		::continue::
	end
end)
