local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

lsp_installer.setup {}

lspconfig.sumneko_lua.setup {}
lspconfig.tsserver.setup {}
