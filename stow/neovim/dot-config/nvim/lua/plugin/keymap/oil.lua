local oil = require("oil")

vim.keymap.set("n", "<leader>-", function()
	local filepath = vim.fn.expand("%")
	local filename = vim.fs.basename(filepath)
	local file_pattern = "^" .. vim.fn.escape(filename, [[\/.*~]])

	oil.open_float(nil, nil, function()
		vim.fn.search(file_pattern)
	end)
end)
