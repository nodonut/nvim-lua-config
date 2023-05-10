return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")

    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate",
    })
    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    use("ryanoasis/vim-devicons")

    use({ "jose-elias-alvarez/null-ls.nvim" })

    use("windwp/nvim-ts-autotag")

    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
    })

    -- use("vim-test/vim-test")
    use("tpope/vim-fugitive")

    use({
        "lewis6991/gitsigns.nvim",
        tag = "release", -- To use the latest release
    })

    use("numToStr/Comment.nvim")

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    use("mbbill/undotree")

    use('j-hui/fidget.nvim') -- Standalone UI for nvim-lsp progress. Eye candy for the impatient

    use("MunifTanjim/prettier.nvim")


    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    use {
        'Equilibris/nx.nvim',
        requires = {
            'nvim-telescope/telescope.nvim',
        },
    }

    -- Copilot
    use {
        "zbirenbaum/copilot.lua",
    }

    -- Themes
    use("folke/tokyonight.nvim") -- TOOOOOKKKKIIIIOOOOOO
    use({ "catppuccin/nvim", as = "catppuccin" })
end)
