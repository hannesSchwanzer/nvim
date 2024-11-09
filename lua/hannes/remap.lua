vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Go to [P]roject [V]iew' })

-- Disable highlights after search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["dd]])

vim.keymap.set({ 'n', 'v' }, 'x', [["dx]])
vim.keymap.set({ 'n', 'v' }, 'X', [["dX]])

vim.keymap.set({ 'n', 'v' }, 'c', [["dc]])
vim.keymap.set({ 'n', 'v' }, 'C', [["dC]])

-- Formats the file if a lsp is running
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

vim.keymap.set('n', ' ', '<Nop>')

-- -- Define the function to run the Python script interactively in a terminal
-- function RunPythonInteractive()
--   local file = vim.fn.expand('%')  -- Get the current file path
--   local cmd = 'python3 ' .. vim.fn.shellescape(file)
--
--   -- Open a split and run the command in an interactive terminal
--   -- vim.cmd('botright split')  -- Open a split at the bottom
--   -- vim.cmd('resize 15')       -- Resize the terminal split height
--   vim.fn.termopen(cmd, {
--     on_exit = function(_, exit_code)
--       if exit_code ~= 0 then
--         -- Capture the last error message output if the script exited with an error
--         local output = vim.fn.systemlist(cmd)
--
--         -- Parse errors and add them to the quickfix list
--         local qflist = {}
--         for _, line in ipairs(output) do
--           local filename, linenum = line:match('File "([^"]+)", line (%d+),')
--           if filename and linenum then
--             table.insert(qflist, {
--               filename = filename,
--               lnum = tonumber(linenum),
--               text = line
--             })
--           else
--             -- For non-traceback lines, just add the raw text (such as the final error message)
--             table.insert(qflist, { text = line })
--           end
--         end
--
--         -- Set the quickfix list with the captured error
--         vim.fn.setqflist(qflist, 'r')
--         vim.cmd('copen')  -- Open the quickfix window to show errors
--       else
--         print("Script completed successfully with no errors.")
--       end
--     end,
--   })
-- end
--
-- -- Set up an autocmd to map Ctrl+F5 only in Python files
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "python",
--   callback = function()
--     -- Map Ctrl+F5 to run the Python script interactively
--     vim.api.nvim_buf_set_keymap(0, 'n', '<F6>', ':lua RunPythonInteractive()<CR>', { noremap = true, silent = true })
--   end
-- })
--
-- function Run_python_file()
--     local current_file = vim.fn.expand("%")
--     local cmd = "python3 " .. current_file
--
--     -- Öffne das Terminal und führe das Python-Skript aus
--     local job_id = vim.fn.jobstart(cmd, {
--         on_stdout = function(_, data)
--             if data and #data > 0 then
--                 for _, line in ipairs(data) do
--                     print(line)
--                 end
--             end
--         end,
--         on_stderr = function(_, data)
--             if data and #data > 0 then
--                 vim.fn.setqflist({}, ' ', { title = "Python Errors", lines = data })
--                 vim.api.nvim_command("copen")
--                 for _, line in ipairs(data) do
--                     print(line)
--                 end
--             end
--         end,
--         on_exit = function(_, exit_code)
--             if exit_code ~= 0 then
--                 print("Das Skript ist mit einem Fehler ausgeführt worden.")
--             end
--         end,
--         stdout_buffered = true,
--         stderr_buffered = true,
--     })
--
--     if job_id == 0 then
--         print("Fehler beim Starten des Jobs.")
--     end
-- end
--
-- -- Füge einen Tastatur-Shortcut für F6 hinzu
-- vim.api.nvim_set_keymap('n', '<F6>', ':lua run_python_file()<CR>', { noremap = true, silent = true })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "python",
--   callback = function()
--     vim.api.nvim_buf_set_keymap(0, 'n', '<F6>', ':lua Run_python_file()<CR>', { noremap = true, silent = true })
--   end
-- })
