return {
    "nvim-treesitter/nvim-treesitter",
    cmd = "TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "tsx", "lua", "rust", "go", "css", "json", "typescript", "javascript", "scss" },
            highlight = { enable = true },
            indent = { enable = true },
        }
    end,
}
