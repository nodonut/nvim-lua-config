return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		local golangci = lint.linters.golangcilint

		golangci.args = { "--out-format", "json" }

		lint.linters_by_ft = {
			go = { "golangcilint" },
			javascript = { "eslint" },
			javascriptreact = { "eslint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
			markdown = { "markdownlint" },
			sh = { "shellcheck" },
			yaml = { "yamllint" },
			python = { "ruff" },
			sql = { "sqlfluff" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			pattern = { "*.go", "*.js", "*.jsx", "*.ts", "*.tsx", "*.md", "*.sh", "*.yaml", "*.py" },
			callback = function()
				lint.try_lint(nil)
			end,
		})
	end,
}
