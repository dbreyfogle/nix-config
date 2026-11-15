vim.g.undotree_WindowLayout = 2
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_SplitWidth = 40
vim.g.undotree_DiffpanelHeight = 12

vim.pack.add({
  "https://github.com/mbbill/undotree",
})

vim.keymap.set("n", "<Leader>u", "<CMD>UndotreeToggle<CR>", { desc = "Toggle undotree" })
