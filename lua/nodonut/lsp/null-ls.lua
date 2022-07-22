local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local function prettier_condition(utils)
	-- See https://prettier.io/docs/en/configuration.html
	local files = {
		".prettierrc",
		".prettierrc.json",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.json5",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettier.config.js",
		".prettier.config.cjs",
		".prettierrc.toml",
	}

	return utils.has_file(files) or utils.root_has_file(files)
end

local function eslint_condition(utils)
	local files = {
		".eslintrc.js",
		".eslintrc.json",
	}

	return utils.has_file(files) or utils.root_has_file(files)
end

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({ condition = prettier_condition }),
		formatting.stylua,
		formatting.rubocop,
		diagnostics.eslint.with({ condition = eslint_condition }),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})
