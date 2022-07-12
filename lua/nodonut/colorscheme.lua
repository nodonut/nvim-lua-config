vim.g.gruvbox_termcolors = 16
vim.g.gruvbox_contrast_dark = "medium"
vim.g.gruvbox_improved_strings = 0

local colorscheme = "gruvbox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " failed")
    return
end
