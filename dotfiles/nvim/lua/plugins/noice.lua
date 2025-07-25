return {
  "folke/noice.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  event = "VeryLazy",
  keys = {
    {
      "<C-d>",
      function()
        if not require("noice.lsp").scroll(4) then
          return "<C-d>"
        end
      end,
      mode = { "n", "i", "s" },
      expr = true,
      desc = "Scroll LSP documentation down",
    },
    {
      "<C-u>",
      function()
        if not require("noice.lsp").scroll(-4) then
          return "<C-u>"
        end
      end,
      mode = { "n", "i", "s" },
      expr = true,
      desc = "Scroll LSP documentation up",
    },
  },
  opts = {
    -- Disable all except LSP markdown overrides
    cmdline = { enabled = false },
    messages = { enabled = false },
    notify = { enabled = false },
    popupmenu = { enabled = false },
    lsp = {
      progress = { enabled = false },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    views = { hover = { size = {
      max_width = 80,
      max_height = 12,
    } } },
  },
}
