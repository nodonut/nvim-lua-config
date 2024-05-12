local opts = { noremap = true, silent = true }

local keymap = function(mode, keys, func)
	vim.keymap.set(mode, keys, func, opts)
end

keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Movements
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "n", "nzz")

-- Quickfix List keymaps
keymap("n", "<leader>cn", "<cmd>cnext<cr>")
keymap("n", "<leader>cp", "<cmd>cprev<cr>")
keymap("n", "<leader>co", "<cmd>copen<cr>")

-- Telescope keymaps
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
keymap("n", "<leader>ht", "<cmd>Telescope help_tags<cr>")
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap("n", "<leader>fm", "<cmd>Telescope man_pages<cr>")
keymap("n", "<leader>ga", "<cmd>Telescope git_branches<cr>")
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>")
keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
keymap("n", "<leader>?", "<cmd>Telescope oldfiles<cr>")
keymap("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find()
end)
keymap("n", "<leader>sc", function()
	require("telescope.builtin").grep_string()
end)

-- Vim Test keymaps
keymap("n", "<leader>T", "<cmd>TestFile<cr>")
keymap("n", "<leader>t", "<cmd>TestNearest<cr>")

-- Git Fugitive keymaps
keymap("n", "<leader>gb", "<cmd>Git blame<cr>")

-- UndoTree keymaps
keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr>")

-- Copy Relative Path
keymap("n", "<leader>rl", '<cmd>let @+ = expand("%")<cr>')

-- NvimTree keymaps
keymap("n", "<leader>nf", "<cmd>NvimTreeFindFileToggle<cr>")

-- Prettier keymaps
keymap("n", "<leader>fo", "<cmd>Prettier<cr>")

-- Harpoon keymaps
keymap("n", "<leader>ha", '<cmd>lua require("harpoon.mark").add_file()<cr>')
keymap("n", "<leader>ho", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')
keymap("n", "<leader>hn", '<cmd>lua require("harpoon.ui").nav_next()<cr>')
keymap("n", "<leader>hN", '<cmd>lua require("harpoon.ui").nav_prev()<cr>')
keymap("n", "<leader>hx", '<cmd>lua require("harpoon.mark").clear_all()<cr>')

-- Git Diff
keymap("n", "<leader>gj", "<cmd>diffget //3<cr>")
keymap("n", "<leader>gf", "<cmd>diffget //2<cr>")

-- Trouble
keymap("n", "<leader>xx", function()
	require("trouble").toggle()
end)
keymap("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end)
keymap("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end)
keymap("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end)
keymap("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end)
keymap("n", "gR", function()
	require("trouble").toggle("lsp_references")
end)
