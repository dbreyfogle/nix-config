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
    { "<Leader>gR", "<CMD>DiffviewRefresh<CR>", desc = "Git: Refresh diffview" },
  },
  init = function()
    -- Prevent certain LSPs from attaching to diffview buffers
    local override_filetypes = { "terraform" }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = override_filetypes,
      callback = function(args)
        local bufname = vim.api.nvim_buf_get_name(args.buf)
        if bufname:match("^diffview://") then
          vim.bo[args.buf].filetype = "diffview_" .. vim.bo[args.buf].filetype
        end
      end,
    })
    for _, ft in ipairs(override_filetypes) do
      vim.treesitter.language.register(ft, "diffview_" .. ft)
    end
  end,
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
