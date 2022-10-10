-- local util = require("lspconfig.util")

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if (not lspconfig_status_ok) then return end

local status_ok, mason = pcall(require, "mason")
if (not status_ok) then return end

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("nodonut.lsp.handlers").capabilities,
        on_attach = require("nodonut.lsp.handlers").on_attach,
    }, _config or {})
end

local sumneko_opts = require("nodonut.lsp.settings.sumneko_lua")
local jsonls_opts = require("nodonut.lsp.settings.jsonls")

mason.setup({})
lspconfig.sumneko_lua.setup(config(sumneko_opts))
lspconfig.jsonls.setup(config(jsonls_opts))
lspconfig.tsserver.setup(config())
-- lspconfig.eslint.setup(config())
lspconfig.cssmodules_ls.setup(config())
lspconfig.cssls.setup(config())
lspconfig.dockerls.setup(config())
lspconfig.emmet_ls.setup(config())
lspconfig.gopls.setup(config())
lspconfig.yamlls.setup(config())
lspconfig.rust_analyzer.setup(config())
lspconfig.html.setup(config())
lspconfig.bashls.setup(config())
lspconfig.intelephense.setup(config())
lspconfig.sorbet.setup(config({
    cmd = { 'bundle', 'exec', 'srb', 'tc', '--lsp' }
}))

-- lspconfig.solargraph.setup(config({
--     cmd = { "/Users/apoorvsohal/.rbenv/shims/solargraph", "stdio" },
--     settings = {
--         solargraph = {
--             diagnostics = true,
--         },
--     },
--     filetypes = { "ruby" },
--     root_dir = util.root_pattern("Gemfile", ".git"),
-- }))
