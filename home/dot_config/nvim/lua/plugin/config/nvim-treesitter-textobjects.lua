require("nvim-treesitter-textobjects").setup({
    select = {
        lookahead = true,
        include_surrounding_whitespace = false,
    },
    move = { set_jumps = true },
})
