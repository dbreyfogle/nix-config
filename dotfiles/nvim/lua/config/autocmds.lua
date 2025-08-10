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

-- Hide diagnostics in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

-- Show diagnostics when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.diagnostic.enable(true)
  end,
})
