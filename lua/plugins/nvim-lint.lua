return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		local golangci = lint.linters.golangcilint

		golangci.args = { "--out-format", "json" }

		lint.linters_by_ft = {
			go = { "golangcilint" },
			javascript = { "eslint", "eslint_d" },
			javascriptreact = { "eslint", "eslint_d" },
			typescript = { "eslint", "eslint_d" },
			typescriptreact = { "eslint", "eslint_d" },
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
