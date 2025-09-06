return {
  { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio"} },
  {
    "mfussenegger/nvim-dap",
    config = function()

    local config = {
      controls = {
        element = "repl",
        enabled = true,
      },
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.4,
            },
            {
              id = "repl",
              size = 0.3,
            },
            {
              id = "breakpoints",
              size = 0.3,
            },
          },
          position = "left",
          size = 40,
        },
      },
    }
    require("dapui").setup(config)
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

      vim.keymap.set('n', '<Leader>dt', function()
        dapui.toggle()
      end)

      vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
      vim.keymap.set('n', '<F8>', function() require('dap').step_over() end)
      vim.keymap.set('n', '<F7>', function() require('dap').step_into() end)
      vim.keymap.set('n', '<F6>', function() require('dap').step_out() end)
      vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
      vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)

      vim.keymap.set({'n', 'v'}, '<Leader>de', function()
        require("dapui").eval()
      end)
      vim.keymap.set({'n', 'v'}, '<Leader>dc', function()
        require('dapui').float_element("console", { enter = true })
      end)
      vim.keymap.set('n', '<Leader>df', function()
        require('dapui').float_element("stacks", { enter = true })
      end)
      vim.keymap.set('n', '<Leader>ds', function()
        require('dapui').float_element("scopes", { enter = true })
      end)
    end,
  }
}

