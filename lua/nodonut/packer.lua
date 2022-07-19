return require("packer").startup(function()
    use("wbthomason/packer.nvim")
    use("sbdchd/neoformat")
    use("jose-elias-alvarez/null-ls.nvim")
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
        run = ":TSUpdate"
    })

    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")
    use("ryanoasis/vim-devicons")

    use("vim-airline/vim-airline")
    -- use("preservim/nerdtree")
    use("williamboman/nvim-lsp-installer")
    use("tpope/vim-surround")
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
end)
