return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			columns = { "icon" },
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["Y"] = {
					callback = function()
						require("oil.actions").yank_entry.callback({ modify = ":p:." })
					end,
				},
			},
		})

		-- Open parent directory in the current window
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
