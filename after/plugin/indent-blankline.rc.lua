local status_ok, indb = pcall(require, "indent_blankline")
if (not status_ok) then return end

indb.setup {
    enabled = false
}
