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

    vim.keymap.set("n", "<Leader>ds", dap.continue)
    vim.keymap.set("n", "<Leader>dc", dap.continue)
    vim.keymap.set("n", "<Leader>dt", function()
      dap.terminate()
      dapui.close()
    end)
    vim.keymap.set("n", "<Leader>dr", dap.restart)
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<Leader>dC", function()
      dap.set_breakpoint(vim.fn.input("Condition: "))
    end)
    vim.keymap.set("n", "<Leader>dH", function()
      dap.set_breakpoint(nil, vim.fn.input("Hit condition: "))
    end)
    vim.keymap.set("n", "<Leader>dL", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
    end)
    vim.keymap.set("n", "<Leader>dX", dap.clear_breakpoints)
    vim.keymap.set("n", "<Leader>dg", dap.run_to_cursor)
    vim.keymap.set("n", "<Leader>do", dap.step_over)
    vim.keymap.set("n", "<Leader>di", dap.step_into)
    vim.keymap.set("n", "<Leader>dO", dap.step_out)
    vim.keymap.set("n", "<Leader>dk", dapui.eval)
    vim.keymap.set("n", "<Leader>du", dapui.toggle)

    -- Open dapui automatically
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
  end,
}
