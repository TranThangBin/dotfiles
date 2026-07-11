local languages = {}
for _, ft in pairs(vim.g._treesitter_enable_filetypes) do
    table.insert(languages, vim.treesitter.language.get_lang(ft))
end

require("nvim-treesitter").install(languages):wait(2 * 60 * 1000)
