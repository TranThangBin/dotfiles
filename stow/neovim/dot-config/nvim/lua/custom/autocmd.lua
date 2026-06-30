vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup(
        "custom/remove_trailing_spaces",
        { clear = true }
    ),
    desc = "Custom: Remove trailing spaces",
    callback = function()
        local pos = vim.fn.getpos(".")
        vim.cmd("%s/\\s\\+$//e")
        vim.fn.setpos(".", pos)
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup(
        "custom/highlight_on_yank",
        { clear = true }
    ),
    desc = "Custom: Highlight on yank",
    callback = function()
        vim.hl.hl_op()
    end,
})
