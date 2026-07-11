local schemastore = require("schemastore")

vim.lsp.config("jsonls", {
    settings = {
        json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true },
        },
    },
})

vim.lsp.config("yamlls", {
    yaml = {
        schemas = schemastore.yaml.schemas(),
        schemaStore = {
            enable = false,
            url = "",
        },
    },
})
