return {
  "olimorris/onedarkpro.nvim",
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("onedark")
  end,
  opts = {
    options = {
      lualine_transparency = true,
    },
  },
}
