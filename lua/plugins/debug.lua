local langs = require("lsp-serverlist")

vim.api.nvim_create_augroup("DapGroup", { clear = true })

local function navigate(args)
    local buffer = args.buf
    local wid = nil
    for _, win_id in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win_id) == buffer then
            wid = win_id
        end
    end
    if not wid then return end
    vim.schedule(function()
        if vim.api.nvim_win_is_valid(wid) then
            vim.api.nvim_set_current_win(wid)
        end
    end)
end

local function create_nav_options(name)
    return {
        group = "DapGroup",
        pattern = string.format("*%s*", name),
        callback = navigate
    }
end

local function jump_to_frame()
  local dap = require("dap")
  local session = dap.session()
  if not session then
    vim.notify("No debug session running", vim.log.levels.WARN)
    return
  end

  local frames = dap.session().frames
  if frames and frames[1] then
    local frame = frames[1]
    if frame.source and frame.source.path and frame.line then
      vim.cmd("edit " .. frame.source.path)
      vim.api.nvim_win_set_cursor(0, { frame.line, 0 })
      vim.cmd("normal! zz")
    end
  else
    local stack = dap.stack_trace()
    if stack and stack[1] and stack[1].source and stack[1].source.path and stack[1].line then
      vim.cmd("edit " .. stack[1].source.path)
      vim.api.nvim_win_set_cursor(0, { stack[1].line, 0 })
      vim.cmd("normal! zz")
    else
      vim.notify("Could not find current frame/source location.", vim.log.levels.WARN)
    end
  end
end


return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    config = function()
      local dap = require("dap")
      dap.set_log_level("DEBUG")

      -- Debug keymaps
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[d]ebug: [c]ontinue/start' })

      vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[d]ebug: step [i]nto' })

      vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[d]ebug: step [o]ver' })

      vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = '[d]ebug: step [O]ut' })

      vim.keymap.set('n', '<F4>', dap.terminate, { desc = 'Debug: Stop' })
      vim.keymap.set('n', '<leader>ds', dap.terminate, { desc = '[d]ebug: [s]top' })

      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })

      vim.keymap.set('n', '<leader>dl', jump_to_frame, { desc = '[d]ebug: jump to [l]ocation of stopped frame' })
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Use default layout
      dapui.setup({
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸', play = '▶', step_into = '⏎', step_over = '⏭',
            step_out = '⏮', step_back = 'b', run_last = '▶▶',
            terminate = '⏹', disconnect = '⏏',
          },
        },
      })

      -- Open all panels on debug start
      local ui_names = { "scopes", "watches", "stacks", "breakpoints", "repl", "console" }
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()  -- Opens all default panels
      end
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      vim.keymap.set("n", "<leader>dt", function() dapui.toggle({}) end, { desc = "[d]ebug: [t]oggle all panels" })
      vim.keymap.set("n", "<leader>de", function() dapui.eval() end, { desc = "[d]ebug: [e]valuate variable under cursor" })

      -- Buf navigation
      vim.api.nvim_create_autocmd("BufEnter", {
        group = "DapGroup",
        pattern = "*dap-repl*",
        callback = function() vim.wo.wrap = true end,
      })
      vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("dap-repl"))
      vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("DAP Watches"))

      dap.listeners.after.event_output['dapui_config'] = function(_, body)
        if body.category == "console" then
          dapui.eval(body.output)
        end
      end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
      "neovim/nvim-lspconfig",
      {
        'mfussenegger/nvim-dap-python',
        cond = function () return langs['python'] end
      }
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {},
        automatic_installation = true,
        handlers = { function(config)
          require("mason-nvim-dap").default_setup(config)
        end },
      })
      if langs['python'] then
        require("dap-python").setup("python")
      end
    end,
  },
}
