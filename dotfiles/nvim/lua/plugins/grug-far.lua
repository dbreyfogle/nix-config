return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<Leader>rr",
      function()
        require("grug-far").open()
      end,
      mode = { "n", "v" },
    },
    {
      "<Leader>rR",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      mode = { "n", "v" },
    },
    {
      "<Leader>rv",
      function()
        require("grug-far").open({ visualSelectionUsage = "operate-within-range" })
      end,
      mode = "v",
    },
  },
  opts = {},
}
