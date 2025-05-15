return {
  "zbirenbaum/copilot.lua",
  dependencies = { "saghen/blink.cmp" },
  event = "InsertEnter",
  cmd = "Copilot",
  config = function()
    require("copilot").setup({
      suggestion = {
        trigger_on_accept = false,
        keymap = {
          accept = "<Tab>",
          dismiss = "<C-e>",
        },
      },
    })

    -- Hide completion menu and trigger suggestions
    vim.keymap.set({ "i" }, "<C-j>", function()
      require("blink.cmp").hide()
      require("copilot.suggestion").next()
    end)

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
}
