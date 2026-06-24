return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,

    config = function()
      local ts = require("nvim-treesitter")

      ts.install({
        "lua",
        "vim",
        "vimdoc",
        "query",
        "bash",
        "python",
        "nix",
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)

          vim.bo[args.buf].indentexpr =
            "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)

          if not lang then
            return
          end

          if not vim.tbl_contains(ts.get_available(), lang) then
            return
          end

          if not vim.tbl_contains(ts.get_installed(), lang) then
            ts.install(lang)
          end

          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
  },
}
-- return {
--
--   { -- Highlight, edit, and navigate code
--     'nvim-treesitter/nvim-treesitter',
--     -- branch = 'master',
--     tag = 'v0.10.0',
--     build = ':TSUpdate',
--     config = function()
--       -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
--
--       ---@diagnostic disable-next-line: missing-fields
--       require('nvim-treesitter.configs').setup {
--         -- Autoinstall languages that are not installed
--         auto_install = true,
--         highlight = { enable = true },
--         indent = { enable = true },
--       }
--
--       -- There are additional nvim-treesitter modules that you can use to interact
--       -- with nvim-treesitter. You should go explore a few and see what interests you:
--       --
--       --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--       --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--       --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--     end,
--   },
-- }
