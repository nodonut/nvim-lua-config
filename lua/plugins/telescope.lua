return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim" },
	config = function()
		local status_ok, telescope = pcall(require, "telescope")
		if not status_ok then
			return
		end

		telescope.setup({
			defaults = {
				path_display = function(_, path)
					local tail = require("telescope.utils").path_tail(path)
					return string.format("%s (%s)", tail, path)
				end,
				file_ignore_patterns = { "node_modules" },
			},
			extensions = {
				fzy_native = {
					override_generic_sorter = false,
					override_file_sorter = true,
				},
			},
		})

		telescope.load_extension("fzy_native")
	end,
}
