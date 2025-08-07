return {
  "supermaven-inc/supermaven-nvim",
  event = "VeryLazy",
  keys = {
    { "<Tab>", mode = "i", desc = "Supermaven: Accept suggestion" },
    { "<C-j>", mode = "i", desc = "Supermaven: Accept word" },
    { "<C-]>", mode = "i", desc = "Supermaven: Clear suggestion" },
  },
  opts = {
    keymaps = {
      accept_suggestion = "<Tab>",
      accept_word = "<C-j>",
      clear_suggestion = "<C-]>",
    },
    ignore_filetypes = {
      "dbout",
      "gitcommit",
      "gitrebase",
      "markdown",
      "oil",
      "txt",
    },
  },
}
