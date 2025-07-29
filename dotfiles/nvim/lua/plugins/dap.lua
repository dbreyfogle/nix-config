return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
  },
  keys = {
    { "<Leader>ds", "<CMD>DapContinue<CR>", desc = "Debug: Start session" },
    { "<Leader>dc", "<CMD>DapContinue<CR>", desc = "Debug: Continue" },
    {
      "<Leader>dt",
      function()
        require("dap").terminate()
        require("dapui").close()
      end,
      desc = "Debug: Terminate session",
    },
    {
      "<Leader>dr",
      function()
        require("dap").restart()
      end,
      desc = "Debug: Restart session",
    },
    { "<Leader>db", "<CMD>DapToggleBreakpoint<CR>", desc = "Debug: Toggle breakpoint" },
    {
      "<Leader>dC",
      function()
        require("dap").set_breakpoint(vim.fn.input("Condition: "))
      end,
      desc = "Debug: Set conditional breakpoint",
    },
    {
      "<Leader>dH",
      function()
        require("dap").set_breakpoint(nil, vim.fn.input("Hit condition: "))
      end,
      desc = "Debug: Set hit condition breakpoint",
    },
    {
      "<Leader>dL",
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log message: "))
      end,
      desc = "Debug: Set log point breakpoint",
    },
    { "<Leader>dX", "<CMD>DapClearBreakpoints<CR>", desc = "Debug: Clear all breakpoints" },
    {
      "<Leader>dg",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Debug: Run to cursor",
    },
    { "<Leader>do", "<CMD>DapStepOver<CR>", desc = "Debug: Step over" },
    { "<Leader>di", "<CMD>DapStepInto<CR>", desc = "Debug: Step into" },
    { "<Leader>dO", "<CMD>DapStepOut<CR>", desc = "Debug: Step out" },
    {
      "<Leader>dk",
      function()
        require("dapui").eval()
      end,
      desc = "Debug: Evaluate expression",
    },
    {
      "<Leader>du",
      function()
        require("dapui").toggle()
      end,
      desc = "Debug: Toggle UI",
    },
  },
  config = function()
    require("dapui").setup()
    require("dap-go").setup()
    require("dap-python").setup()

    -- Open dapui automatically
    require("dap").listeners.before.attach.dapui_config = require("dapui").open
    require("dap").listeners.before.launch.dapui_config = require("dapui").open
  end,
}
