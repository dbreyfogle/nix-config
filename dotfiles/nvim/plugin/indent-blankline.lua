vim.pack.add({
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
})

require("ibl").setup({
  indent = { char = "│" },
  scope = { enabled = false },
  exclude = {
    filetypes = {
      "fugitive",
      "fugitiveblame",
      "git",
      "gitrebase",
    },
  },
})
