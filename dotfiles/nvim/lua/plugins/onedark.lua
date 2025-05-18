return {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    -- Dynamic colorscheme based on terminal background
    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      callback = function()
        vim.cmd.colorscheme(vim.o.background == "dark" and "onedark" or "onelight")
      end,
    })
  end,
  opts = {
    options = {
      lualine_transparency = true,
    },
  },
}
