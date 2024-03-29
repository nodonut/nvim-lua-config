require("nodonut.set")
require("nodonut.keymaps")
require("nodonut.autorun")


-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- local client = vim.lsp.start_client {
--     name = "educationalsp",
--     cmd = { "/home/apoorv/projects/educationalsp/main" },
-- }
--
-- if not client then
--     vim.notify "hey, you didnt do the client thing good"
--     return
-- end
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "markdown",
--     callback = function()
--         vim.lsp.buf_attach_client(0, client)
--     end
-- })
