local status_ok, ts = pcall(require, "nvim-treesitter.configs")
if (not status_ok) then return end

ts.setup {
    ensure_installed = { "tsx", "lua", "rust", "go", "css", "json", "typescript", "javascript", "scss" },
    highlight = { enable = true },
    indent = { enable = true },
}
