vim.pack.add({
  { src = "https://github.com/rebelot/kanagawa.nvim" },
})

require("kanagawa").setup({
  colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
})

vim.cmd.colorscheme("kanagawa")

-- Highlight current line number
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none", ctermfg = "white" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#7e9cd8", bold = true })
