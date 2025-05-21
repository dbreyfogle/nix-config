return {
  "folke/snacks.nvim",
  dependences = {
    "ibhagwan/fzf-lua",
    "folke/persistence.nvim",
  },
  opts = {
    dashboard = {
      preset = { header = "Menu" },
      sections = {
        { section = "header", padding = 1 },
        { section = "keys", gap = 1, padding = 4 },
        { section = "startup" },
      },
      width = 55,
    },
    indent = {
      animate = { enabled = false },
    },
  },
}
