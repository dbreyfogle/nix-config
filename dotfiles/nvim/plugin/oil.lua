vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, bufnr)
      return vim.tbl_contains({
        ".DS_Store",
      }, name)
    end,
  },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Oil: Open file browser" })
