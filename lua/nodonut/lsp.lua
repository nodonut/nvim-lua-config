local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end


lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require("nodonut.handlers").on_attach,
        capabilities = require("nodonut.handlers").capabilities,
    }

    if server.name == "sumneko_lua" then
        local sumneko_opts = {
	        settings = {
		        Lua = {
			        diagnostics = {
				    globals = { "vim" },
			    },
			    workspace = {
				    library = {
					    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
					    [vim.fn.stdpath("config") .. "/lua"] = true,
				        },
			        },
		        },
	        },
        }
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    server:setup(opts)
end)
