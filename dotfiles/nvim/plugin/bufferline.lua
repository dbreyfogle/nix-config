vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
})

require("bufferline").setup({
  options = {
    mode = "tabs",
    themable = false,
    style_preset = {
      require("bufferline").style_preset.minimal,
      require("bufferline").style_preset.no_italic,
    },
    indicator = { style = "none" },
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = false,
  },
})
