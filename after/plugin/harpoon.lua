local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<S-m>m", ui.toggle_quick_menu)

vim.keymap.set("n", "<S-m>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<S-m>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<S-m>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<S-m>4", function() ui.nav_file(4) end)
vim.keymap.set("n", "<S-m>5", function() ui.nav_file(5) end)
vim.keymap.set("n", "<S-m>6", function() ui.nav_file(6) end)
vim.keymap.set("n", "<S-m>7", function() ui.nav_file(7) end)
vim.keymap.set("n", "<S-m>8", function() ui.nav_file(8) end)
vim.keymap.set("n", "<S-m>9", function() ui.nav_file(9) end)

