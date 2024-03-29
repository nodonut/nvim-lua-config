return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local status_ok, conform = pcall(require, "conform")
		if not status_ok then
			return
		end
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				go = { "gofmt" },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
