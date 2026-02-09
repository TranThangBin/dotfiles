local set = vim.keymap.set

set({ "s", "i" }, "<C-c>", "<Esc>")

set("x", "J", ":m '>+1<CR>gv=gv")
set("x", "K", ":m '<-2<CR>gv=gv")

set("n", "J", "mzJ`z")

set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")

set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set({ "n", "x" }, "<leader>y", '"+y')
set({ "n", "x" }, "<leader>Y", '"+Y')
set("x", "<leader>d", '"_d')
set("x", "<leader>p", '"_dP')

set("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

set("n", "<leader>e", function()
	local filepath = vim.fn.expand("%")
	local filename = vim.fs.basename(filepath)
	local file_pattern = "^" .. vim.fn.escape(filename, [[\/.*~]])

	local filetype = vim.fn.getftype(filepath)
	local fileperm = vim.fn.getfperm(filepath)

	if filetype == "link" then
		file_pattern = file_pattern .. "@"
	elseif
		fileperm:sub(3, 3) == "x"
		or fileperm:sub(6, 6) == "x"
		or fileperm:sub(9, 9) == "x"
	then
		file_pattern = file_pattern .. "\\*"
	else
		file_pattern = file_pattern .. "$"
	end

	vim.cmd.Explore()
	vim.fn.search(file_pattern)
end, {
	desc = "[E]xplore",
})
