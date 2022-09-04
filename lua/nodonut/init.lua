require("nodonut.set")
require("nodonut.packer")
require("nodonut.lsp")
require("nodonut.keymaps")

local augroup = vim.api.nvim_create_augroup
NodonutGroup = augroup("nodonut", {})
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufEnter", "BufWinEnter", "TabEnter" }, {
    group = NodonutGroup,
    pattern = "*.rs",
    callback = function()
        require("lsp_extensions").inlay_hints({})
    end,
})
