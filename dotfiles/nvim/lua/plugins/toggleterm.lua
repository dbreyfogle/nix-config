return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<C-\\>", desc = "Toggle terminal" },
  },
  opts = {
    open_mapping = "<C-\\>",
    autochdir = true,
    direction = "float",
    shade_terminals = false,
  },
}
