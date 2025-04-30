return {
  "sindrets/diffview.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  keys = {
    {
      "<Leader>gdd",
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewOpen")
        else
          vim.cmd("DiffviewClose")
        end
      end,
    },
    { "<Leader>gdm", "<CMD>DiffviewOpen origin/HEAD...HEAD<CR>" },
    { "<Leader>gdo", ":DiffviewOpen " },
    { "<Leader>gdu", "<CMD>DiffviewOpen upstream/HEAD...HEAD<CR>" },
    { "<Leader>glf", "<CMD>DiffviewFileHistory %<CR>" },
    {
      "<Leader>gll",
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewFileHistory")
        else
          vim.cmd("DiffviewClose")
        end
      end,
    },
    { "<Leader>glo", ":DiffviewFileHistory " },
  },
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      default_args = {
        DiffviewOpen = { "--imply-local" },
      },
      hooks = {
        view_leave = function()
          vim.cmd("DiffviewClose")
        end,
      },
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
