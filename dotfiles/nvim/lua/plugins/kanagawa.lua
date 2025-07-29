return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("kanagawa")

    -- Highlight current line number
    vim.opt.cursorline = true
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#7e9cd8", bold = true })
  end,
  opts = {
    colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
  },
}
