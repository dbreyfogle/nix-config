-- Clear messages after a few seconds
vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    vim.defer_fn(function()
      vim.cmd("echon ''")
    end, 3000)
  end,
})

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Highlight current line number
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.opt.cursorline = true
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#7E9CD8", bold = true })
  end,
})
