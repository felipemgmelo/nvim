return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opts = {
       debugger = { -- integrate with nvim dap + install dart code debugger
          enabled = true,
        },
  }
}
