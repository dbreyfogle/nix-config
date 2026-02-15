return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  keys = {
    { "<Leader>gd", "<CMD>Gdiffsplit!<CR>", desc = "Git: Diff for the current buffer" },
    { "<Leader>gl", "<CMD>tab Git log --oneline --decorate -10000<CR>", desc = "Git: Log" },
    { "<Leader>gL", "<CMD>tab Git log --oneline --decorate -10000 %<CR>", desc = "Git: Log for the current file" },
    { "<Leader>gs", "<CMD>tab Git<CR>", desc = "Git: Status" },
  },
}
