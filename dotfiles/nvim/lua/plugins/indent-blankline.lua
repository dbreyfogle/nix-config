return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
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
  },
}
