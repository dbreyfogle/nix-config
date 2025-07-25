return {
  "kawre/leetcode.nvim",
  dependencies = {
    "ibhagwan/fzf-lua",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Leet",
  keys = {
    { "<Leader>lcc", "<CMD>Leet console<CR>", desc = "Leetcode: Show console" },
    { "<Leader>lcd", "<CMD>Leet desc<CR>", desc = "Leetcode: Show description" },
    { "<Leader>lci", "<CMD>Leet info<CR>", desc = "Leetcode: Show info" },
    { "<Leader>lcl", "<CMD>Leet lang<CR>", desc = "Leetcode: Select language" },
    { "<Leader>lcm", "<CMD>Leet<CR>", desc = "Leetcode: Open menu" },
    { "<Leader>lcn", ":Leet random status=todo,notac difficulty=", desc = "Leetcode: Random problem by difficulty" },
    { "<Leader>lco", "<CMD>Leet open<CR>", desc = "Leetcode: Open in browser" },
    { "<Leader>lcp", "<CMD>Leet list<CR>", desc = "Leetcode: List problems" },
    { "<Leader>lcq", "<CMD>Leet exit<CR>", desc = "Leetcode: Quit" },
    { "<Leader>lcr", "<CMD>Leet run<CR>", desc = "Leetcode: Run solution" },
    { "<Leader>lcs", "<CMD>Leet submit<CR>", desc = "Leetcode: Submit solution" },
    { "<Leader>lct", "<CMD>Leet tabs<CR>", desc = "Leetcode: Show tabs" },
    { "<Leader>lcu", "<CMD>Leet cache update<CR>", desc = "Leetcode: Update cache" },
    { "<Leader>lcX", "<CMD>Leet reset<CR>", desc = "Leetcode: Reset editor" },
  },
  opts = {
    lang = "golang",
    injector = {
      ["golang"] = { before = "package main" },
    },
  },
}
