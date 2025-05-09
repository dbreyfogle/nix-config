return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "debugloop/telescope-undo.nvim" },
    { "folke/todo-comments.nvim" },
  },
  event = { "VimEnter" },
  config = function()
    require("telescope").setup({
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
      },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("undo")

    local builtin = require("telescope.builtin")
    local map = function(keys, func, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func)
    end

    map("gra", vim.lsp.buf.code_action)
    map("grd", builtin.lsp_definitions)
    map("grD", vim.lsp.buf.declaration)
    map("gri", builtin.lsp_implementations)
    map("grn", vim.lsp.buf.rename)
    map("grr", builtin.lsp_references)
    map("grt", builtin.lsp_type_definitions)

    map("<Leader>sb", builtin.buffers)
    map("<Leader>sc", builtin.git_files)
    map("<Leader>sd", builtin.diagnostics)
    map("<Leader>sD", function()
      builtin.diagnostics({ bufnr = 0 })
    end)
    map("<Leader>sf", builtin.find_files)
    map("<Leader>sg", builtin.live_grep)
    map("<Leader>sG", builtin.current_buffer_fuzzy_find)
    map("<Leader>sh", builtin.help_tags)
    map("<Leader>sj", builtin.jumplist)
    map("<Leader>sk", builtin.keymaps)
    map("<Leader>so", builtin.lsp_dynamic_workspace_symbols)
    map("<Leader>sO", builtin.lsp_document_symbols)
    map("<Leader>sr", builtin.resume)
    map("<Leader>ss", builtin.builtin)
    map("<Leader>st", "<CMD>TodoTelescope<CR>")
    map("<Leader>su", require("telescope").extensions.undo.undo)
    map("<Leader>sw", builtin.grep_string)
    map("<Leader>s`", builtin.marks)
    map("<Leader>s:", builtin.commands)
    map('<Leader>s"', builtin.registers)
    map("<Leader>s.", builtin.oldfiles)

    map("<Leader>gb", builtin.git_branches)
    map("<Leader>gg", builtin.git_status)
    map("<Leader>gz", builtin.git_stash)
  end,
}
