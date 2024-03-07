return {
  {
    'theprimeagen/harpoon',

    config = function(LazyPlugin, opts)
      require("harpoon").setup(opts)

      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "[A]dd to marked files" })
      vim.keymap.set("n", "<leader>mm", ui.toggle_quick_menu, { desc = "Open Marked Files" })

      vim.keymap.set("n", "<leader>m1", function() ui.nav_file(1) end, { desc = "Jump to marked file 1" })
      vim.keymap.set("n", "<leader>m2", function() ui.nav_file(2) end, { desc = "Jump to marked file 2" })
      vim.keymap.set("n", "<leader>m3", function() ui.nav_file(3) end, { desc = "Jump to marked file 3" })
      vim.keymap.set("n", "<leader>m4", function() ui.nav_file(4) end, { desc = "Jump to marked file 4" })
      vim.keymap.set("n", "<leader>m5", function() ui.nav_file(5) end, { desc = "Jump to marked file 5" })
      vim.keymap.set("n", "<leader>m6", function() ui.nav_file(6) end, { desc = "Jump to marked file 6" })
      vim.keymap.set("n", "<leader>m7", function() ui.nav_file(7) end, { desc = "Jump to marked file 7" })
      vim.keymap.set("n", "<leader>m8", function() ui.nav_file(8) end, { desc = "Jump to marked file 8" })
      vim.keymap.set("n", "<leader>m9", function() ui.nav_file(9) end, { desc = "Jump to marked file 9" })
    end
  }
}
