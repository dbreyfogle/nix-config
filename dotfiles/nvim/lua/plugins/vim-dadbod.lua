return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
  },
  cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
  keys = { { "<Leader>D", "<CMD>DBUIToggle<CR>" } },
  init = function()
    local data_path = vim.fn.stdpath("data")
    vim.g.db_ui_save_location = data_path .. "/db_ui"
    vim.g.db_ui_tmp_query_location = data_path .. "/db_ui/tmp"
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_help = 0
    vim.g.db_ui_force_echo_notifications = 1
    vim.g.db_ui_execute_on_save = 0
  end,
}
