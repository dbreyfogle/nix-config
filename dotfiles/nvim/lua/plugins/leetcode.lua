return {
  "kawre/leetcode.nvim",
  dependencies = {
    "ibhagwan/fzf-lua",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Leet",
  keys = {
    { "<Leader>lcc", "<CMD>Leet console<CR>" },
    { "<Leader>lcd", "<CMD>Leet desc<CR>" },
    { "<Leader>lci", "<CMD>Leet info<CR>" },
    { "<Leader>lcl", "<CMD>Leet lang<CR>" },
    { "<Leader>lcm", "<CMD>Leet<CR>" },
    { "<Leader>lcn", ":Leet random status=todo,notac difficulty=" },
    { "<Leader>lco", "<CMD>Leet open<CR>" },
    { "<Leader>lcp", "<CMD>Leet list<CR>" },
    { "<Leader>lcq", "<CMD>Leet exit<CR>" },
    { "<Leader>lcr", "<CMD>Leet run<CR>" },
    { "<Leader>lcs", "<CMD>Leet submit<CR>" },
    { "<Leader>lct", "<CMD>Leet tabs<CR>" },
    { "<Leader>lcu", "<CMD>Leet cache update<CR>" },
    { "<Leader>lcX", "<CMD>Leet reset<CR>" },
  },
  opts = {
    lang = "golang",
    injector = {
      ["golang"] = { before = "package main" },
    },
  },
}
