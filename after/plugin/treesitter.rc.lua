local status_ok, ts = pcall(require, "nvim-treesitter.configs")
if (not status_ok) then return end

ts.setup {
    highlight = {
        enable = true,
        disable = {},
    },
    indent = { enable = true, disable = {} },
    ensure_installed = { "tsx", "lua", "rust", "go", "css", "json", "typescript", "javascript", "scss" },
    autotag = {
        enabled = true,
    }
}
