local prettier = require("prettier")

prettier.setup {
    bin = 'prettierd',
    filetypes = {
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "scss",
        "less",
        "markdown",
    },
    -- cli_options = {
    --     -- https://prettier.io/docs/en/cli.html#--config-precedence
    --     config_precedence = "prefer-file", -- or "cli-override" or "file-override"
    -- },
}
