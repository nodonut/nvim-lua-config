return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "L3MON4D3/LuaSnip" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "rafamadriz/friendly-snippets" },
	},
	config = function()
		local lsp = require("lsp-zero")
		local kind_icons = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = "",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "󰕳",
			Property = "",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "󰈇",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "󰙅",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "",
		}
		local jsonls_opts = require("settings.jsonls")

		lsp.preset("recommended")
		lsp.ensure_installed({
			"lua_ls",
			"cssls",
			"jsonls",
			"gopls",
			"yamlls",
			"html",
			"rust_analyzer",
			"bashls",
			"eslint",
			"jedi_language_server",
		})

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local cmp_mappings = lsp.defaults.cmp_mappings({
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete(),
		})

		-- disable completion with tab
		-- this helps with copilot setup
		cmp_mappings["<Tab>"] = nil
		cmp_mappings["<S-Tab>"] = nil

		lsp.setup_nvim_cmp({
			mapping = cmp_mappings,
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					-- Kind icons
					vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "luasnip" },
			},
		})

		lsp.set_preferences({
			suggest_lsp_servers = false,
			sign_icons = {
				error = "E",
				warn = "W",
				hint = "H",
				info = "I",
			},
		})

		lsp.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }
			local nmap = function(keys, func)
				vim.keymap.set("n", keys, func, opts)
			end

			nmap("K", vim.lsp.buf.hover)
			nmap("<leader>vws", vim.lsp.buf.workspace_symbol)
			nmap("<leader>e", vim.diagnostic.open_float)

			nmap("gd", require("telescope.builtin").lsp_definitions)
			nmap("gr", require("telescope.builtin").lsp_references)
			nmap("gI", require("telescope.builtin").lsp_implementations)
			nmap("<leader>D", require("telescope.builtin").lsp_type_definitions)
			nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols)
			nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)

			nmap("[d", vim.diagnostic.goto_prev)
			nmap("]d", vim.diagnostic.goto_next)
			nmap("<leader>ca", vim.lsp.buf.code_action)
			nmap("<leader>rn", vim.lsp.buf.rename)
			nmap("<C-h>", vim.lsp.buf.signature_help)
			nmap("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
		end)

		-- LSP CONFIGURATIONS
		lsp.configure("jsonls", jsonls_opts)
		lsp.configure("rust_analyzer", {
			cmd = { "rustup", "run", "stable", "rust-analyzer" },
		})
		-- (Optional) Configure lua language server for neovim
		require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
		require("lspconfig").htmx.setup({})
		require("luasnip.loaders.from_vscode").lazy_load()
		require("lspconfig").gopls.setup({
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					gofumpt = true,
				},
			},
		})
		lsp.setup()
		vim.diagnostic.config({
			virtual_text = true,
		})
	end,
}
