
return {

    {
        'nvim-telescope/telescope.nvim', version = '0.1.5',
        -- or                            , branch = '0.1.x',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },

    'ellisonleao/gruvbox.nvim',

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    'nvim-treesitter/playground',
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    },

}
