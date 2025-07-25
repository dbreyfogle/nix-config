return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  keys = {
    { "<Leader>sb", "<CMD>FzfLua buffers<CR>", desc = "Search buffers" },
    { "<Leader>sc", "<CMD>FzfLua git_files<CR>", desc = "Search git files" },
    { "<Leader>sd", "<CMD>FzfLua diagnostics_workspace<CR>", desc = "Search workspace diagnostics" },
    { "<Leader>sD", "<CMD>FzfLua diagnostics_document<CR>", desc = "Search document diagnostics" },
    { "<Leader>sf", "<CMD>FzfLua files<CR>", desc = "Search files" },
    { "<Leader>sg", "<CMD>FzfLua live_grep<CR>", desc = "Live grep search in workspace" },
    { "<Leader>sG", "<CMD>FzfLua lgrep_curbuf<CR>", desc = "Live grep search in buffer" },
    { "<Leader>sh", "<CMD>FzfLua helptags<CR>", desc = "Search help tags" },
    { "<Leader>sj", "<CMD>FzfLua jumps<CR>", desc = "Search jump list" },
    { "<Leader>sk", "<CMD>FzfLua keymaps<CR>", desc = "Search keymaps" },
    { "<Leader>so", "<CMD>FzfLua lsp_live_workspace_symbols<CR>", desc = "Search workspace symbols" },
    { "<Leader>sO", "<CMD>FzfLua lsp_document_symbols<CR>", desc = "Search document symbols" },
    { "<Leader>sr", "<CMD>FzfLua resume<CR>", desc = "Resume last search" },
    { "<Leader>ss", "<CMD>FzfLua builtin<CR>", desc = "Search builtin commands" },
    { "<Leader>st", "<CMD>TodoFzfLua<CR>", desc = "Search todo comments" },
    { "<Leader>sv", "<CMD>FzfLua grep_visual<CR>", mode = "v", desc = "Grep search visual selection" },
    { "<Leader>sw", "<CMD>FzfLua grep_cword<CR>", desc = "Grep search word under cursor" },
    { "<Leader>sW", "<CMD>FzfLua grep_cWORD<CR>", desc = "Grep search WORD under cursor" },
    { "<Leader>sz", "<CMD>FzfLua zoxide<CR>", desc = "Search zoxide directories" },
    { "<Leader>s:", "<CMD>FzfLua commands<CR>", desc = "Search commands" },
    { "<Leader>s'", "<CMD>FzfLua marks<CR>", desc = "Search marks" },
    { '<Leader>s"', "<CMD>FzfLua registers<CR>", desc = "Search registers" },
    { "<Leader>s.", "<CMD>FzfLua oldfiles<CR>", desc = "Search recent files" },
    { "<Leader>s/", "<CMD>FzfLua search_history<CR>", desc = "Search search history" },

    { "<Leader>gbr", "<CMD>FzfLua git_branches<CR>", desc = "Git: Branches" },
    { "<Leader>gg", "<CMD>FzfLua git_status<CR>", desc = "Git: Status" },
    { "<Leader>gz", "<CMD>FzfLua git_stash<CR>", desc = "Git: Stash" },
    { "<Leader>g'", "<CMD>FzfLua git_tags<CR>", desc = "Git: Tags" },

    { "ga", "<CMD>FzfLua lsp_code_actions<CR>", desc = "List code actions" },
    { "gd", "<CMD>FzfLua lsp_definitions<CR>", desc = "Go to definition" },
    { "gD", "<CMD>FzfLua lsp_declarations<CR>", desc = "Go to declaration" },
    { "gi", "<CMD>FzfLua lsp_implementations<CR>", desc = "Go to implementation" },
    { "grr", "<CMD>FzfLua lsp_references<CR>", desc = "List references" },
    { "grt", "<CMD>FzfLua lsp_typedefs<CR>", desc = "Go to type definition" },
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
