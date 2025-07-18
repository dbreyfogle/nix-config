return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("kanagawa")
  end,
  opts = {
    colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
  },
}
