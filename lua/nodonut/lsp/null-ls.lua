local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end
local utils = require("null-ls.utils").make_conditional_utils()

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local function has_eslint_configured()
    return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.json") or
        utils.root_has_file(".eslintrc")

end

local function has_rubocop_configured()
    return utils.root_has_file(".rubocop.yml")
end

local diagnostics_config = {
    diagnostics_format = "[#{c}] #{m} [#{s}]",
    prefer_local = "node_modules/.bin",
}

null_ls.setup({
    sources = {
        -- Formatters
        -- formatting.prettier.with({ prefer_local = "node_modules/.bin" }),
        formatting.rubocop.with({ condition = has_rubocop_configured }),
        formatting.shellharden,
        formatting.phpcsfixer,

        -- Diagnostics
        diagnostics.eslint_d.with({ condition = has_eslint_configured, diagnostics_format = "[#{c}] #{m} [#{s}]" }),
        diagnostics.stylelint.with(diagnostics_config),
        diagnostics.shellcheck.with(diagnostics_config),
        -- diagnostics.rubocop.with({ condition = has_rubocop_configured, diagnostics_format = "[#{c}] #{m} [#{s}]" }),
        diagnostics.yamllint,
        diagnostics.phpcs,

        -- Code Actions
        code_actions.eslint_d,
    },
})
