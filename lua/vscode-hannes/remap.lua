local vscode = require("vscode")

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable highlights after search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- -- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Move Lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Move Up or Down the page and center screen
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Next and privious item in search and places cursor in the middle of the screen
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Deletes without coping
vim.keymap.set({ 'n', 'v' }, 'd', [["dd]])
vim.keymap.set({ 'n', 'v' }, 'D', [["dD]])
vim.keymap.set('n', '<leader>d', '<cmd>let @+=@d<CR>')

vim.keymap.set({ 'n', 'v' }, 'x', [["xx]])
vim.keymap.set({ 'n', 'v' }, 'X', [["xX]])

vim.keymap.set({ 'n', 'v' }, 'c', [["cc]])
vim.keymap.set({ 'n', 'v' }, 'C', [["cC]])

-- Formats the file if a lsp is running
-- vim.keymap.set('n', '<leader>f', vscode.action("editor.action.formatDocument"))

vim.keymap.set('n', ' ', '<Nop>')

vim.keymap.set("x", "<leader>p", [["_dP]])
