vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
vim.g.db_ui_tmp_query_location = vim.fn.stdpath("data") .. "/db_ui/tmp"
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_help = 0
vim.g.db_ui_force_echo_notifications = 1
vim.g.db_ui_execute_on_save = 0

vim.pack.add({
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
})

vim.keymap.set("n", "<Leader>D", "<CMD>DBUIToggle<CR>", { desc = "DB: Toggle UI" })
