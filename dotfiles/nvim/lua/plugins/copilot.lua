return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
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
