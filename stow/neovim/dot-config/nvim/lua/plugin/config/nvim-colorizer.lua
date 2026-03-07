require("colorizer").setup({
    filetypes = {
        "html",
        "css",
        "javascript",
        "typescript",
        "templ",
        cmp_menu = { always_update = true },
        cmp_docs = { always_update = true },
    },
    options = {
        parsers = {
            css = true,
            css_fn = true,
            hsl_fn = true,
            names = false,
            rgb_fn = true,
            tailwind = {
                enable = true,
                update_names = true,
            },
        },
    },
})
