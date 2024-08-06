return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local status_ok, conform = pcall(require, "conform")
		if not status_ok then
			return
		end

		local prettiers = { "prettierd", "prettier", stop_after_first = true }
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = function(bufnr)
					if require("conform").get_formatter_info("ruff_format", bufnr).available then
						return { "ruff_format" }
					else
						return { "isort", "black" }
					end
				end,

				javascript = prettiers,
				typescript = prettiers,
				json = prettiers,
				typescriptreact = prettiers,
				css = prettiers,
				scss = prettiers,
				less = prettiers,
				markdown = prettiers,
				yaml = prettiers,
				sql = { "sql_formatter" },
				rust = { "rustfmt" },
				go = { "gofmt" },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf, quiet = true })
			end,
		})
	end,
}
