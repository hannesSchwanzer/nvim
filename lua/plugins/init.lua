
return {


    'ellisonleao/gruvbox.nvim',

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    'nvim-treesitter/playground',
    'theprimeagen/harpoon',
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
    
-- status line
  { "nvim-lualine/lualine.nvim", event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        conponent_separators = '|',
        section_separators = '',
      }
    },
  },
{ "nvim-tree/nvim-web-devicons", lazy = true },
  -- terminal
  { "akinsho/toggleterm.nvim", event = "VeryLazy", version = "*",
    opts = {
      size = 10,
      open_mapping = "<c-s>",
    }
  },
{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }
}
