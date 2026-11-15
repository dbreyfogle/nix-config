vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/ibhagwan/fzf-lua",
})

require("fzf-lua").setup({
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
      ["ctrl-q"] = "select-all+accept",
    },
  },
  winopts = { preview = { horizontal = "right:50%" } },
})

require("fzf-lua").register_ui_select()

-- Search
vim.keymap.set("n", "<Leader>sb", "<CMD>FzfLua buffers<CR>", { desc = "Search buffers" })
vim.keymap.set("n", "<Leader>sc", "<CMD>FzfLua git_files<CR>", { desc = "Search git files" })
vim.keymap.set("n", "<Leader>sd", "<CMD>FzfLua diagnostics_workspace<CR>", { desc = "Search workspace diagnostics" })
vim.keymap.set("n", "<Leader>sD", "<CMD>FzfLua diagnostics_document<CR>", { desc = "Search document diagnostics" })
vim.keymap.set("n", "<Leader>sf", "<CMD>FzfLua files<CR>", { desc = "Search files" })
vim.keymap.set("n", "<Leader>sg", "<CMD>FzfLua live_grep<CR>", { desc = "Live grep search in workspace" })
vim.keymap.set("n", "<Leader>sG", "<CMD>FzfLua lgrep_curbuf<CR>", { desc = "Live grep search in buffer" })
vim.keymap.set("n", "<Leader>sh", "<CMD>FzfLua helptags<CR>", { desc = "Search help tags" })
vim.keymap.set("n", "<Leader>sj", "<CMD>FzfLua jumps<CR>", { desc = "Search jump list" })
vim.keymap.set("n", "<Leader>sk", "<CMD>FzfLua keymaps<CR>", { desc = "Search keymaps" })
vim.keymap.set("n", "<Leader>so", "<CMD>FzfLua lsp_live_workspace_symbols<CR>", { desc = "Search workspace symbols" })
vim.keymap.set("n", "<Leader>sr", "<CMD>FzfLua resume<CR>", { desc = "Resume last search" })
vim.keymap.set("n", "<Leader>ss", "<CMD>FzfLua builtin<CR>", { desc = "Search builtin commands" })
vim.keymap.set("v", "<Leader>sv", "<CMD>FzfLua grep_visual<CR>", { desc = "Grep search visual selection" })
vim.keymap.set("n", "<Leader>sw", "<CMD>FzfLua grep_cword<CR>", { desc = "Grep search word under cursor" })
vim.keymap.set("n", "<Leader>sW", "<CMD>FzfLua grep_cWORD<CR>", { desc = "Grep search WORD under cursor" })
vim.keymap.set("n", "<Leader>sz", "<CMD>FzfLua zoxide<CR>", { desc = "Search zoxide directories" })
vim.keymap.set("n", "<Leader>s:", "<CMD>FzfLua commands<CR>", { desc = "Search commands" })
vim.keymap.set("n", "<Leader>s'", "<CMD>FzfLua marks<CR>", { desc = "Search marks" })
vim.keymap.set("n", '<Leader>s"', "<CMD>FzfLua registers<CR>", { desc = "Search registers" })
vim.keymap.set("n", "<Leader>s.", "<CMD>FzfLua oldfiles<CR>", { desc = "Search recent files" })
vim.keymap.set("n", "<Leader>s/", "<CMD>FzfLua search_history<CR>", { desc = "Search search history" })

-- LSP
vim.keymap.set("n", "gd", "<CMD>FzfLua lsp_definitions<CR>", { desc = "Go to definition" })
vim.keymap.set("n", "gD", "<CMD>FzfLua lsp_declarations<CR>", { desc = "Go to declaration" })
vim.keymap.set("n", "gO", "<CMD>FzfLua lsp_document_symbols<CR>", { desc = "Search document symbols" })
vim.keymap.set({ "n", "v" }, "gra", "<CMD>FzfLua lsp_code_actions<CR>", { desc = "List code actions" })
vim.keymap.set("n", "gri", "<CMD>FzfLua lsp_implementations<CR>", { desc = "Go to implementation" })
vim.keymap.set("n", "grr", "<CMD>FzfLua lsp_references<CR>", { desc = "List references" })
vim.keymap.set("n", "grt", "<CMD>FzfLua lsp_typedefs<CR>", { desc = "Go to type definition" })
