return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	config = function()
		local status_ok, lline = pcall(require, "lualine")
		if not status_ok then
			return
		end

		local lint_progress = function()
			local linters = require("lint").get_running()
			if #linters == 0 then
				return "󰦕"
			end
			return "󱉶 " .. table.concat(linters, ", ")
		end

		lline.setup({
			sections = {
				lualine_b = { "branch" },
				lualine_c = { {
					"filename",
					path = 1,
				} },
				lualine_x = { "filetype" },
				lualine_y = { lint_progress },
			},
		})
	end,
}
