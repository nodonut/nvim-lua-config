local util = require("lspconfig.util")

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("nodonut.lsp.handlers").capabilities,
		on_attach = require("nodonut.lsp.handlers").on_attach,
	}, _config or {})
end

local sumneko_opts = require("nodonut.lsp.settings.sumneko_lua")
local jsonls_opts = require("nodonut.lsp.settings.jsonls")

lsp_installer.setup({})
lspconfig.sumneko_lua.setup(config(sumneko_opts))
lspconfig.vimls.setup(config())
lspconfig.jsonls.setup(config(jsonls_opts))
lspconfig.tsserver.setup(config())
lspconfig.eslint.setup(config())
lspconfig.cssmodules_ls.setup(config())
lspconfig.html.setup(config())
lspconfig.cssls.setup(config())
lspconfig.dockerls.setup(config())
lspconfig.emmet_ls.setup(config())
lspconfig.gopls.setup(config())

lspconfig.solargraph.setup(config({
	cmd = { "~/.rbenv/shims/solargraph", "stdio" },
}))
