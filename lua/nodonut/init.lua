require("nodonut.set")
require("nodonut.packer")
require("nodonut.colorscheme")
require("nodonut.lsp")
require("nodonut.cmp")
require("nodonut.treesitter")
require("nodonut.keymaps")
require("nodonut.telescope")
require("nodonut.autopairs")
require("nodonut.nvim-tree")
require("nodonut.gitsigns")
require("nodonut.lualine")

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

-- vim.cmd([[
--     augroup fmt
--     autocmd!
--     autocmd BufWritePre * undojoin | Neoformat
--     augroup END
-- ]])
