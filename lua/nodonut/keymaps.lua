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
keymap('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find()
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
keymap("n", "<leader>nf", '<cmd>NvimTreeFindFileToggle<cr>')

-- Prettier keymaps
keymap("n", "<leader>fo", '<cmd>Prettier<cr>')

-- Copilot keymaps
keymap("n", "<leader>ce", '<cmd>Copilot enable<cr>')
keymap("n", "<leader>cd", '<cmd>Copilot disable<cr>')
