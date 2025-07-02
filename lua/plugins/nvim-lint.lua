return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		local rubocop = lint.linters.rubocop
		rubocop.cmd = "bundle exec rubocop"

		local hasEslint = function()
			local package_json = vim.fn.findfile("package.json", ".;")

			if package_json ~= "" then
				local content = vim.fn.readfile(package_json)
				local decoded = vim.fn.json_decode(content)
				local deps = decoded.dependencies or {}
				local dev_deps = decoded.devDependencies or {}

				return deps.eslint ~= nil or dev_deps.eslint ~= nil
			end
		end

		local eslinters = { "eslint", "eslint_d" }

		if hasEslint() then
			eslinters = { "eslint" }
		end

		lint.linters_by_ft = {
			go = { "golangcilint" },
			javascript = eslinters,
			javascriptreact = eslinters,
			typescript = eslinters,
			typescriptreact = eslinters,
			markdown = { "markdownlint" },
			sh = { "shellcheck" },
			yaml = { "yamllint" },
			python = { "ruff" },
			sql = { "sqlfluff" },
			ruby = { "rubocop" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			pattern = {
				"*.go",
				"*.js",
				"*.jsx",
				"*.ts",
				"*.tsx",
				"*.md",
				"*.sh",
				"*.yaml",
				"*.py",
				".rb",
			},
			callback = function()
				lint.try_lint(nil)
			end,
		})
	end,
}
