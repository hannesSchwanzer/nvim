vim.api.nvim_create_user_command(
    'Unity',
    function ()
        vim.fn.serverstart './untiyhostnvim'
    end,
    {}
)

vim.api.nvim_create_user_command(
    'Godot',
    function ()
        vim.fn.serverstart './godothost'
    end,
    {}
)
