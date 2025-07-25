return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  keys = {
    { "<Leader>ka", desc = "Kulala: Send all requests" },
    { "<Leader>kb", desc = "Kulala: Open scratchpad" },
    { "<Leader>ks", desc = "Kulala: Send request" },
  },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<Leader>k",
    ui = { disable_news_popup = true },
  },
}
