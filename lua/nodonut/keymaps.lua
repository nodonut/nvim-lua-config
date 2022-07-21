local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Telescope keymaps
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>ga", "<cmd>lua require'nodonut.telescope'.git_branches()<cr>", opts)

-- NvimTree keymaps
keymap("n", "<leader>nf", "<cmd>NvimTreeFindFile<cr>", opts)
keymap("n", "<leader>nt", "<cmd>NvimTreeToggle<cr>", opts)

-- Vim Test keymaps
keymap("n", "<leader>T", "<cmd>TestFile<cr>", opts)


-- Git Fugitive keymaps
keymap("n", "<leader>gb", "<cmd>Git blame<cr>", opts)
