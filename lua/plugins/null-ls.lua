return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        local lsp = require("lsp-zero")
        local null_ls = require("null-ls")
        local null_opts = lsp.build_options('null-ls', {})
        local diagnostics = null_ls.builtins.diagnostics
        local formatting = null_ls.builtins.formatting

        null_ls.setup({
            sources = {
                diagnostics.ruff,
                diagnostics.mypy,

                formatting.black
            },
            on_attach = function(client, bufnr)
                null_opts.on_attach(client, bufnr)

                local format_cmd = function(input)
                    vim.lsp.buf.format({
                        id = client.id,
                        timeout_ms = 5000,
                        async = input.bang
                    })
                end

                local bufcmd = vim.api.nvim_buf_create_user_command
                bufcmd(bufnr, 'NullFormat', format_cmd, { bang = true, range = true, desc = 'Format using null-ls' })
            end,
        })
    end,
}
