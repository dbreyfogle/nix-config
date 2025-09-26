return {
  "github/copilot.vim",
  event = "VeryLazy",
  keys = {
    { "<Tab>", mode = "i", desc = "Copilot: Accept suggestion" },
    { "<C-j>", "<Plug>(copilot-accept-word)", mode = "i", desc = "Copilot: Accept word" },
    { "<C-]>", mode = "i", desc = "Copilot: Clear suggestion" },
  },
  init = function()
    vim.g.copilot_filetypes = {
      ["dbout"] = false,
      ["gitcommit"] = false,
      ["gitrebase"] = false,
      ["markdown"] = false,
      ["oil"] = false,
      ["txt"] = false,
    }
  end,
}
