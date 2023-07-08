return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        local lsp = require("lsp-zero")
        local null_ls = require("null-ls")
        local utils = require("null-ls.utils").make_conditional_utils()
        local null_opts = lsp.build_options('null-ls', {})

        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        local code_actions = null_ls.builtins.code_actions

        local function has_eslint_configured()
            return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.json") or
                utils.root_has_file(".eslintrc")
        end

        -- UNCOMMENT WHEN WORKING WITH RUBY
        -- local function has_rubocop_configured()
        --     return utils.root_has_file(".rubocop.yml")
        -- end

        local diagnostics_config = {
            diagnostics_format = "[#{c}] #{m} [#{s}]",
            prefer_local = "node_modules/.bin",
        }

        null_ls.setup({
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
            sources = {
                -- Diagnostics
                diagnostics.eslint_d.with({ condition = has_eslint_configured, diagnostics_format = "[#{c}] #{m} [#{s}]" }),
                diagnostics.stylelint.with(diagnostics_config),
                diagnostics.yamllint,
                diagnostics.golangci_lint,

                -- Code Actions
                code_actions.eslint_d,
            },
        })
    end,
}
