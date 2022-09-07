local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end
local utils = require("null-ls.utils").make_conditional_utils()

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function has_eslint_configured()
    return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.json")
end

local function has_rubocop_configured()
    return utils.root_has_file(".rubocop.yml")
end

local diagnostics_config = {
    diagnostics_format = "[#{c}] #{m} [#{s}]"
}

null_ls.setup({
    on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
    sources = {
        -- Formatters
        formatting.prettier.with({ prefer_local = "node_modules/.bin" }),
        formatting.rubocop.with({ condition = has_rubocop_configured }),
        formatting.shellharden,

        -- Diagnostics
        diagnostics.stylelint.with(diagnostics_config),
        diagnostics.shellcheck.with(diagnostics_config),
        diagnostics.eslint.with({ condition = has_eslint_configured, diagnostics_format = "[#{c}] #{m} [#{s}]" }),
        diagnostics.rubocop.with({ condition = has_rubocop_configured, diagnostics_format = "[#{c}] #{m} [#{s}]" }),
    },
})
