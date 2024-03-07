return {

    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            file_ignore_patterns = {
                "node_modules",
            }
        },
        keys = {
            {
                '<leader>pf',
                function()
                    require('telescope.builtin').find_files({})
                end,
            },
            {
                '<C-p>',
                function()
                    require('telescope.builtin').git_files({})
                end,
            },
            {
                '<leader>ps',
                function()
                    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
                end,
            },
            {
                '<leader>vh',
                function()
                    require('telescope.builtin').help_tags({})
                end,
            },
        }
    },
}
