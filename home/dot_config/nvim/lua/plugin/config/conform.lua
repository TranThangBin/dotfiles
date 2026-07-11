require("conform").setup({
    formatters = {
        templ = {
            args = {
                "fmt",
                "-stdin-filepath",
                "$FILENAME",
                "-prettier-required",
                "-prettier-command",
                "prettierd --stdin-filepath $TEMPL_PRETTIER_FILE_NAME",
            },
        },
    },
    default_format_opts = {
        async = true,
        lsp_format = "fallback",
        stop_after_first = true,
    },
    formatters_by_ft = {
        bash = { "shfmt" },
        css = { "prettierd" },
        gdscript = { "gdformat" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        kdl = { "kdlfmt" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        nix = { "nixfmt" },
        sh = { "shfmt" },
        templ = { "templ" },
        typescript = { "prettierd" },
    },
})
