return require("packer").startup(function()
    use("wbthomason/packer.nvim")
    use("lukas-reineke/indent-blankline.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")

    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
    use("onsails/lspkind-nvim")
    use("nvim-lua/lsp_extensions.nvim")
    use("glepnir/lspsaga.nvim")
    use("simrat39/symbols-outline.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets")

    use("gruvbox-community/gruvbox")

    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate",
    })

    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")
    use("ryanoasis/vim-devicons")
    use({ "williamboman/mason.nvim" })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })
    use("windwp/nvim-ts-autotag")
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
        tag = "nightly", -- optional, updated every week. (see issue #1193)
    })
    use("vim-test/vim-test")
    use("tpope/vim-fugitive")
    use("tpope/vim-rails")
    use({
        "lewis6991/gitsigns.nvim",
        tag = "release", -- To use the latest release
    })
    use("numToStr/Comment.nvim")
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    -- Themes
    use("folke/tokyonight.nvim")
    use({ "catppuccin/nvim", as = "catppuccin" })
end)
