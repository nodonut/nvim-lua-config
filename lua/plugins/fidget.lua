-- Standalone UI for nvim-lsp progress.
-- Eye candy for the impatient
return {
    'j-hui/fidget.nvim',
    tag = "legacy",
    config = function()
        require('fidget').setup()
    end,
}
