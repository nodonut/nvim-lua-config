local status_ok, gsigns = pcall(require, "gitsigns")
if not status_ok then
    return
end

gsigns.setup({})
