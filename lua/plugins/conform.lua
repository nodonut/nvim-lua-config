return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local status_ok, conform = pcall(require, "conform")
		if not status_ok then
			return
		end

		local hasPrettier = function()
			local package_json = vim.fn.findfile("package.json", ".;")
			local prettierrc = vim.fn.findfile(".prettierrc", ".;")

			if prettierrc ~= "" then
				return true
			end

			if package_json ~= "" then
				local content = vim.fn.readfile(package_json)
				local decoded = vim.fn.json_decode(content)
				local deps = decoded.dependencies or {}
				local dev_deps = decoded.devDependencies or {}

				return deps.prettier ~= nil or dev_deps.prettier ~= nil
			end
		end

		local function apply_soy_formatting()
			if hasPrettier() then
				return { "prettierd", "prettier" }
			else
				return { "eslint_d" }
			end
		end

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

				javascript = apply_soy_formatting,
				typescript = apply_soy_formatting,
				json = apply_soy_formatting,
				typescriptreact = apply_soy_formatting,
				css = apply_soy_formatting,
				scss = apply_soy_formatting,
				less = apply_soy_formatting,
				markdown = apply_soy_formatting,
				yaml = apply_soy_formatting,
				sql = { "sqruff" },
				go = { "gofmt" },
				ruby = { "rubocop" },
				sh = { "shfmt" },
			},
			formatters = {
				rubocop = {
					command = "bundle",
					args = {
						"exec",
						"rubocop",
						"--server",
						"-a",
						"-f",
						"quiet",
						"--stderr",
						"--stdin",
						"$FILENAME",
					},
				},
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
