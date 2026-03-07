local set = vim.keymap.set

set({ "s", "i" }, "<C-c>", "<Esc>", {
    desc = "Custom: Escape",
})

set("x", "J", ":m '>+1<CR>gv=gv", {
    desc = "Custom: Move selected down",
})
set("x", "K", ":m '<-2<CR>gv=gv", {
    desc = "Custom: Move selected up",
})

set("n", "J", "mzJ`z", {
    desc = "Custom: J (mzJ`z)",
})

set("n", "<C-d>", "<C-d>zz", {
    desc = "Custom: <C-d> (<C-d>zz)",
})
set("n", "<C-u>", "<C-u>zz", {
    desc = "Custom: <C-u> (<C-u>zz)",
})

set("n", "n", "nzzzv", {
    desc = "Custom: n (nzzzv)",
})
set("n", "N", "Nzzzv", {
    desc = "Custom: N (Nzzzv)",
})

set({ "n", "x" }, "<leader>y", '"+y', {
    desc = "Custom: [y]ank to clipboard",
})
set("n", "<leader>Y", '"+Y', {
    desc = "Custom: [Y]ank line to clipboard",
})
set({ "n", "x" }, "<leader>d", '"_d', {
    desc = "Custom: [d]elete and discard",
})
set("n", "<leader>D", '"_D', {
    desc = "Custom: [D]elete rest and discard",
})
set("x", "<leader>p", '"_dP', {
    desc = "Custom: [p]aste and discard",
})

set("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {
    desc = "Custom: [r]eplace [w]ord",
})

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
end, { desc = "Custom: [e]xplore" })
