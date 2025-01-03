return {
	"nvim-treesitter/nvim-treesitter",
	cmd = "TSUpdate",
	-- version = "*",
	commit = "fb2d41ec599b68af041f3071ada883718928e279",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"tsx",
				"lua",
				"rust",
				"go",
				"css",
				"json",
				"typescript",
				"javascript",
				"scss",
				"vim",
				"vimdoc",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
		local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		treesitter_parser_config.templ = {
			install_info = {
				url = "https://github.com/vrischmann/tree-sitter-templ.git",
				files = { "src/parser.c", "src/scanner.c" },
				branch = "master",
			},
		}

		vim.treesitter.language.register("templ", "templ")
	end,
}
