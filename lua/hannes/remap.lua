vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.api.nvim_set_keymap('n', '<C-q>', '<C-v>', { noremap = true })
vim.keymap.set('t', '<C-w>h', "<C-\\><C-n><C-w>h",{silent = true})
