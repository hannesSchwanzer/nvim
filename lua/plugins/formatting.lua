return {
  {
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,

      -- Define formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
      },
    },

    config = function(_, opts)
      require("conform").setup(opts)

      -- Add keymap for formatting with fallback to LSP
      vim.keymap.set({ "n", "v" }, "<leader>f", function()
        require("conform").format({
          async = true,
          lsp_fallback = true, -- fallback to LSP if no conform formatter available
        })
      end, { desc = "Format file" })
    end,
  },
}
