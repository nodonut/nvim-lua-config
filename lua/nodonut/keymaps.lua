local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quickfix List keymaps
keymap("n", "<leader>cn", "<cmd>cnext<cr>", opts)
keymap("n", "<leader>cp", "<cmd>cprev<cr>", opts)
keymap("n", "<leader>co", "<cmd>copen<cr>", opts)

-- Telescope keymaps
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", opts)
keymap("n", "<leader>ga", "<cmd>Telescope git_branches<cr>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)

-- NvimTree keymaps
keymap("n", "<leader>nf", "<cmd>NvimTreeFindFile<cr>", opts)
keymap("n", "<leader>nt", "<cmd>NvimTreeToggle<cr>", opts)

-- Vim Test keymaps
keymap("n", "<leader>T", "<cmd>TestFile<cr>", opts)

-- Git Fugitive keymaps
keymap("n", "<leader>gb", "<cmd>Git blame<cr>", opts)
