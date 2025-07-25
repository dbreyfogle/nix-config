return {
  "zbirenbaum/copilot.lua",
  dependencies = { "saghen/blink.cmp" },
  event = "InsertEnter",
  cmd = "Copilot",
  keys = {
    {
      "<C-j>",
      function()
        require("blink.cmp").hide()
        require("copilot.suggestion").next()
      end,
      mode = "i",
      desc = "Copilot: Generate suggestion",
    },
    {
      "<Leader>cp",
      function()
        require("copilot.suggestion").toggle_auto_trigger()
      end,
      desc = "Copilot: Toggle auto trigger",
    },
  },
  init = function()
    -- Hide suggestions when completion menu is open
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuClose",
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
  opts = {
    suggestion = {
      trigger_on_accept = false,
      keymap = {
        accept = "<Tab>",
        dismiss = "<C-e>",
      },
    },
  },
}
