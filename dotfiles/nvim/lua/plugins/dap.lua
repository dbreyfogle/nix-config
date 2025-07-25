return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    require("dapui").setup()
    require("dap-go").setup()
    require("dap-python").setup()

    local dap = require("dap")
    local dapui = require("dapui")

    vim.keymap.set("n", "<Leader>ds", dap.continue, { desc = "Debug: Start session" })
    vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Debug: Continue" })
    vim.keymap.set("n", "<Leader>dt", function()
      dap.terminate()
      dapui.close()
    end, { desc = "Debug: Terminate session" })
    vim.keymap.set("n", "<Leader>dr", dap.restart, { desc = "Debug: Restart session" })
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })
    vim.keymap.set("n", "<Leader>dC", function()
      dap.set_breakpoint(vim.fn.input("Condition: "))
    end, { desc = "Debug: Set conditional breakpoint" })
    vim.keymap.set("n", "<Leader>dH", function()
      dap.set_breakpoint(nil, vim.fn.input("Hit condition: "))
    end, { desc = "Debug: Set hit condition breakpoint" })
    vim.keymap.set("n", "<Leader>dL", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
    end, { desc = "Debug: Set log point breakpoint" })
    vim.keymap.set("n", "<Leader>dX", dap.clear_breakpoints, { desc = "Debug: Clear all breakpoints" })
    vim.keymap.set("n", "<Leader>dg", dap.run_to_cursor, { desc = "Debug: Run to cursor" })
    vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Debug: Step over" })
    vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Debug: Step into" })
    vim.keymap.set("n", "<Leader>dO", dap.step_out, { desc = "Debug: Step out" })
    vim.keymap.set("n", "<Leader>dk", dapui.eval, { desc = "Debug: Evaluate expression" })
    vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })

    -- Open dapui automatically
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
  end,
}
