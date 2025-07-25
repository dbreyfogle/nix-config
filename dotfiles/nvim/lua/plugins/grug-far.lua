return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<Leader>rr",
      function()
        require("grug-far").open()
      end,
      mode = { "n", "v" },
      desc = "Find and replace in workspace",
    },
    {
      "<Leader>rR",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      mode = { "n", "v" },
      desc = "Find and replace in buffer",
    },
    {
      "<Leader>rv",
      function()
        require("grug-far").open({ visualSelectionUsage = "operate-within-range" })
      end,
      mode = "v",
      desc = "Find and replace in selection",
    },
  },
  opts = {},
}
