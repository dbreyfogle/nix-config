return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  opts = {
    options = {
      disabled_filetypes = {
        statusline = {
          "dbout",
          "dbui",
          "DiffviewFiles",
          "DiffviewFileHistory",
          "fugitive",
          "gitsigns-blame",
          "help",
          "kulala_ui",
          "snacks_dashboard",
          "undotree",
        },
      },
      icons_enabled = false,
      section_separators = " ",
      component_separators = "",
    },

    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            return "  " .. string.sub(str, 1, 1) .. "  "
          end,
        },
      },
      lualine_b = { "diagnostics", "diff" },
      lualine_c = { "branch", "%=", { "filename", path = 1 } },
      lualine_x = {
        "filetype",
        { "lsp_status", symbols = { done = "" }, ignore_lsp = { "GitHub Copilot" } },
        "progress",
      },
      lualine_y = {},
      lualine_z = {},
    },

    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "%=", { "filename", path = 1 } },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
}
