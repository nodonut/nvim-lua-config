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

lsp_installer.setup {}

local sumneko_lua_opts = require("nodonut.lsp.settings.sumneko_lua")
lspconfig.sumneko_lua.setup(sumneko_lua_opts)
lspconfig.tsserver.setup(config())
