local set = vim.keymap.set

local conform = require("conform")

set({ "n", "x" }, "<leader>f", function()
	conform.format(nil, function(err)
		if err ~= nil then
			---@diagnostic disable-next-line
			vim.lsp.buf.format(conform.default_format_opts)
		end
	end)
end, { desc = "[F]ormat" })
