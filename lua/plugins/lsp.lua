local langs = require("lsp-serverlist")

return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      { 'williamboman/mason.nvim', commit = "fc98833" },
      { 'williamboman/mason-lspconfig.nvim', commit = "1a31f82" },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim', commit = "1255518" },

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      {
        'Hoffs/omnisharp-extended-lsp.nvim',
        cond = function ()
          return langs["csharp"]
        end
      },
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          if client ~= nil and client.name == "omnisharp" then
            -- Use omnisharp-extended functions for C#
            map('gd', function() require('omnisharp_extended').lsp_definition() end, '[G]oto [D]efinition')
            map('<leader>D', function() require('omnisharp_extended').lsp_type_definition() end, 'Type [D]efinition')
            map('gr', function() require('omnisharp_extended').lsp_references() end, '[G]oto [R]eferences')
            map('gi', function() require('omnisharp_extended').lsp_implementation() end, '[G]oto [I]mplementation')
          else
              map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
              map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
              map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
              map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          end

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          --local client = vim.lsp.get_client_by_id(event.data.client_id)
          --if client and client.server_capabilities.documentHighlightProvider then
          --  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          --    buffer = event.buf,
          --    callback = vim.lsp.buf.document_highlight,
          --  })

          --  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          --    buffer = event.buf,
          --    callback = vim.lsp.buf.clear_references,
          --  })
          --end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())


      -- Enable the following language servers
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
      }


      if langs['godot'] then
      require('lspconfig').gdscript.setup(capabilities)
      end

      if langs['csharp'] then
        servers.omnisharp = {}
      end

      if langs['latex'] then
        servers.texlab = {}
      end

      if langs['c'] then
        servers.clangd = {}
      end

      if langs['python'] then
        servers.pyright = {
          settings = {
            pyright = {
              disableOrganizeImports = true,  -- Optional: if you want to disable organize imports
              -- Add other pyright-specific settings here
            },
            python = {
              analysis = {
                -- Disable the specific warning you're seeing
                diagnosticSeverityOverrides = {
                  reportOptionalIterable = "warining",  -- or "warning" if you just want to downgrade it
                  reportIndexIssue = "warning",
                  reportOptionalSubscript = "warning",
                  reportAssignmentType = "warning",
                  reportOptionalMemberAccess = "warning",
                  reportArgumentType = "warning",
                },
                -- Alternatively, you can disable all optional/member diagnostics
                -- typeCheckingMode = "off",  -- This is more drastic
              },
            },
          },
        }
      end

      if langs['rust'] then
        servers.rust_analyzer = {}
      end

      if langs['typescript'] then
        servers.tsserver = {}
      end

      if langs['json'] then
        servers.jsonls = {}
      end

      if langs['lua'] then
        servers.lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        }
      end

      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
        'black',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
