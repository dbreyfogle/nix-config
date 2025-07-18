return {
  "folke/snacks.nvim",
  dependences = {
    "ibhagwan/fzf-lua",
    "folke/persistence.nvim",
  },
  opts = {
    dashboard = {
      preset = { header = "Neovim" },
      sections = {
        { section = "header", padding = 2 },
        { section = "keys", gap = 1, padding = 4 },
        { section = "startup" },
      },
    },
    indent = {
      animate = { enabled = false },
      scope = { enabled = false },
    },
  },
}
