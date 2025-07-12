return
{
  'goropikari/nvim-dap-cpp',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  -- build = 'make setup', -- not necessary if you use mason.
  opts = {
    -- default value
    codelldb = {
      path = vim.fn.stdpath('data') .. '/nvim-dap-cpp.nvim/extension/adapter/codelldb',
      -- for mason
      -- path = require('mason-registry').get_package('codelldb'):get_install_path()
    },
    configurations = {},
  },
  ft = { 'c', 'cpp' },
}
