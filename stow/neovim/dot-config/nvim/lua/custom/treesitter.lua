vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom/treesitter", { clear = true }),
    pattern = vim.g._treesitter_enable_filetypes,
    desc = "Custom: Treesitter",
    callback = function(e)
        local buf = e.buf
        local lang = vim.treesitter.language.get_lang(e.match)

        if lang == nil then
            return
        end

        vim.treesitter.start(buf)

        if not pcall(require, "nvim-treesitter") then
            return
        end

        if not vim.treesitter.query.get(lang, "indents") then
            return
        end

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
