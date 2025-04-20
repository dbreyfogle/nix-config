return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      icons_enabled = false,
      section_separators = { left = " ", right = " " },
      component_separators = { left = " ", right = " " },
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "diagnostics", "diff", { "filename", path = 1 } },
      lualine_x = {
        function()
          return vim.fn.ObsessionStatus("Obsession", "")
        end,
        "location",
        "progress",
      },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
