return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dap_python = require("dap-python")

    require("dapui").setup({})
    require("nvim-dap-virtual-text").setup({
      commented = true, -- Show virtual text alongside comment
    })

    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }

    -- Configuration for C++ LLDB DAP
    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
      {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
          local name = vim.fn.input('Executable name (filter): ')
          return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}'
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}'
      },
    }  
    dap.adapters.python = {
      type = 'executable',
      command = 'python',
      args = {'-m', 'debugpy.adapter'}
    }
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function() return '/usr/bin/python' end,
      },
    }

    vim.fn.sign_define("DapBreakpoint", {
      text = "",
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapBreakpointRejected", {
      text = "", -- or "❌"
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapStopped", {
      text = "", -- or "→"
      texthl = "DiagnosticSignWarn",
      linehl = "Visual",
      numhl = "DiagnosticSignWarn",
    })

    -- Automatically open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    local opts = { noremap = true, silent = true }

    -- Toggle breakpoint
    vim.keymap.set("n", "<leader>db", function()
      dap.toggle_breakpoint()
    end, opts)

    -- Continue / Start
    vim.keymap.set("n", "<leader>dc", function()
      dap.continue()
    end, opts)

    -- Step Over
    vim.keymap.set("n", "<leader>do", function()
      dap.step_over()
    end, opts)

    -- Step Into
    vim.keymap.set("n", "<leader>di", function()
      dap.step_into()
    end, opts)

    -- Step Out
    vim.keymap.set("n", "<leader>dO", function()
      dap.step_out()
    end, opts)

    -- Keymap to terminate debugging
    vim.keymap.set("n", "<leader>dq", function()
      require("dap").terminate()
    end, opts)

    -- Toggle DAP UI
    vim.keymap.set("n", "<leader>du", function()
      dapui.toggle()
    end, opts)
  end,
}
