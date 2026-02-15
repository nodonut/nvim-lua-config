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

-- Vim Test keymaps
keymap("n", "<leader>T", "<cmd>TestFile<cr>")
keymap("n", "<leader>t", "<cmd>TestNearest<cr>")

-- Git Fugitive keymaps
keymap("n", "<leader>gb", "<cmd>Git blame<cr>")

-- UndoTree keymaps
keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr>")

-- Copy Relative Path
keymap("n", "<leader>rl", '<cmd>let @+ = expand("%")<cr>')

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
