return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  keys = {
    { "<Leader>sb", "<CMD>FzfLua buffers<CR>" },
    { "<Leader>sc", "<CMD>FzfLua git_files<CR>" },
    { "<Leader>sd", "<CMD>FzfLua diagnostics_workspace<CR>" },
    { "<Leader>sD", "<CMD>FzfLua diagnostics_document<CR>" },
    { "<Leader>sf", "<CMD>FzfLua files<CR>" },
    { "<Leader>sg", "<CMD>FzfLua live_grep<CR>" },
    { "<Leader>sG", "<CMD>FzfLua lgrep_curbuf<CR>" },
    { "<Leader>sh", "<CMD>FzfLua helptags<CR>" },
    { "<Leader>sj", "<CMD>FzfLua jumps<CR>" },
    { "<Leader>sk", "<CMD>FzfLua keymaps<CR>" },
    { "<Leader>so", "<CMD>FzfLua lsp_live_workspace_symbols<CR>" },
    { "<Leader>sO", "<CMD>FzfLua lsp_document_symbols<CR>" },
    { "<Leader>sr", "<CMD>FzfLua resume<CR>" },
    { "<Leader>ss", "<CMD>FzfLua builtin<CR>" },
    { "<Leader>st", "<CMD>TodoFzfLua<CR>" },
    { "<Leader>sv", "<CMD>FzfLua grep_visual<CR>", mode = "v" },
    { "<Leader>sw", "<CMD>FzfLua grep_cword<CR>" },
    { "<Leader>sW", "<CMD>FzfLua grep_cWORD<CR>" },
    { "<Leader>sz", "<CMD>FzfLua zoxide<CR>" },
    { "<Leader>s:", "<CMD>FzfLua commands<CR>" },
    { "<Leader>s'", "<CMD>FzfLua marks<CR>" },
    { '<Leader>s"', "<CMD>FzfLua registers<CR>" },
    { "<Leader>s.", "<CMD>FzfLua oldfiles<CR>" },
    { "<Leader>s/", "<CMD>FzfLua search_history<CR>" },

    { "<Leader>gb", "<CMD>FzfLua git_branches<CR>" },
    { "<Leader>gg", "<CMD>FzfLua git_status<CR>" },
    { "<Leader>gz", "<CMD>FzfLua git_stash<CR>" },
    { "<Leader>g'", "<CMD>FzfLua git_tags<CR>" },

    { "ga", "<CMD>FzfLua lsp_code_actions<CR>" },
    { "gd", "<CMD>FzfLua lsp_definitions<CR>" },
    { "gD", "<CMD>FzfLua lsp_declarations<CR>" },
    { "gi", "<CMD>FzfLua lsp_implementations<CR>" },
    { "grr", "<CMD>FzfLua lsp_references<CR>" },
    { "gt", "<CMD>FzfLua lsp_typedefs<CR>" },
  },
  init = function()
    require("fzf-lua").register_ui_select()
  end,
  opts = {
    keymap = {
      builtin = {
        true,
        ["<C-c>"] = "hide",
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
      },
      fzf = {
        true,
        ["ctrl-d"] = "preview-page-down",
        ["ctrl-u"] = "preview-page-up",
      },
    },
    winopts = { preview = { horizontal = "right:50%" } },
  },
}
