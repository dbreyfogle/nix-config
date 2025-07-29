return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<Leader>gdd", "<CMD>DiffviewOpen<CR>", desc = "Git: Open diffview" },
    { "<Leader>gdo", "<CMD>DiffviewOpen origin/HEAD...HEAD<CR>", desc = "Git: Open diffview against origin" },
    { "<Leader>gdu", "<CMD>DiffviewOpen upstream/HEAD...HEAD<CR>", desc = "Git: Open diffview against upstream" },
    { "<Leader>gll", "<CMD>DiffviewFileHistory<CR>", desc = "Git: Open commit history" },
    { "<Leader>glL", "<CMD>DiffviewFileHistory %<CR>", desc = "Git: Open commit history for current file" },
  },
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      default_args = { DiffviewOpen = { "--imply-local" } },
      keymaps = {
        file_panel = {
          { "n", "<C-d>", actions.scroll_view(0.5) },
          { "n", "<C-u>", actions.scroll_view(-0.5) },
        },
        file_history_panel = {
          { "n", "<C-d>", actions.scroll_view(0.5) },
          { "n", "<C-u>", actions.scroll_view(-0.5) },
        },
      },
      show_help_hints = false,
    })
  end,
}
