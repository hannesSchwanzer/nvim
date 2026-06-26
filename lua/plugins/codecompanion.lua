return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  opts = {
    interactions = {
      chat = {
        adapter = {
          name = "copilot",
          model = "gpt-4.1",
        },
      },
      inline = {
        adapter = {
          name = "copilot",
          model = "gpt-4.1",
        },
      },
      cmd = {
        adapter = {
          name = "copilot",
          model = "gpt-4.1",
        },
      },
      background = {
        adapter = {
          name = "copilot",
          model = "gpt-4.1",
        },
      },
    },

  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim", -- Render Markdown in Neovim
      ft = { "markdown", "codecompanion" }
    },
    {
      "HakonHarnes/img-clip.nvim", -- Pasting Images from clipboard
      opts = {
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = "[Image]($FILE_PATH)",
            use_absolute_path = true,
          },
        },
      },
    },
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
  },
  config = function(_, opts)
    require("codecompanion").setup(opts)
    vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<Leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

    vim.cmd([[cab cc CodeCompanion]])

  end,
}
