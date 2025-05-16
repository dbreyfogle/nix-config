return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    auto_install = true,
    ensure_installed = { "markdown", "markdown_inline" },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
