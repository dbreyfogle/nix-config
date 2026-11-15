vim.pack.add({
  "https://github.com/tpope/vim-fugitive",
})

vim.keymap.set("n", "<Leader>gd", "<CMD>Gdiffsplit!<CR>", { desc = "Git: Diff for the current buffer" })
vim.keymap.set("n", "<Leader>gl", "<CMD>tab Git log --oneline --decorate -10000<CR>", { desc = "Git: Log" })
vim.keymap.set(
  "n",
  "<Leader>gL",
  "<CMD>tab Git log --oneline --decorate -10000 %<CR>",
  { desc = "Git: Log for the current file" }
)
vim.keymap.set("n", "<Leader>gs", "<CMD>tab Git<CR>", { desc = "Git: Status" })
