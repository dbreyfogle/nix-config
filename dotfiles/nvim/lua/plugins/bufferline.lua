return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs",
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
  end,
}
