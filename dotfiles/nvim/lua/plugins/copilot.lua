return {
  "zbirenbaum/copilot.lua",
  event = { "InsertEnter" },
  cmd = "Copilot",
  keys = {
    {
      "<M-\\>",
      function()
        require("copilot.suggestion").next()
      end,
      mode = "i",
    },
  },
  config = function()
    require("copilot").setup({
      suggestion = {
        trigger_on_accept = false,
        keymap = {
          accept = "<Tab>",
          dismiss = "<Esc>",
        },
      },
    })
  end,
}
