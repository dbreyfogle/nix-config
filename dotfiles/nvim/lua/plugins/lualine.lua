return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = false,
      section_separators = { left = " ", right = " " },
      component_separators = { left = " ", right = " " },
    },

    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "diagnostics", "diff", "branch", { "filename", path = 1 } },
      lualine_x = {
        function()
          return vim.fn.ObsessionStatus("session", "")
        end,
        "filetype",
        "location",
        "progress",
      },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
