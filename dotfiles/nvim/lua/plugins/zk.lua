return {
  "zk-org/zk-nvim",
  keys = {
    { "<Leader>zd", "<CMD>ZkNew { dir = 'daily' }<CR>", desc = "Zk: Open daily note" },
    { "<Leader>zf", "<CMD>ZkNotes<CR>", desc = "Zk: Search notes by title" },
    { "<Leader>zf", ":'<,'>ZkMatch<CR>", mode = { "v" }, silent = true, desc = "Zk: Search notes from selection" },
    { "<Leader>zi", "<CMD>ZkInsertLink<CR>", desc = "Zk: Insert link" },
    {
      "<Leader>zi",
      ":'<,'>ZkInsertLinkAtSelection { matchSelected = 'true' }<CR>",
      mode = { "v" },
      silent = true,
      desc = "Zk: Insert link at selection",
    },
    { "<Leader>zI", "<CMD>ZkIndex<CR>", desc = "Zk: Index notebook" },
    { "<Leader>zn", "<CMD>execute 'ZkNew { title = ''' . input('title: ') . ''' }'<CR>", desc = "Zk: New note" },
    {
      "<Leader>zn",
      ":'<,'>ZkNewFromTitleSelection<CR>",
      mode = { "v" },
      silent = true,
      desc = "Zk: New note from selection",
    },
    { "<Leader>zt", "<CMD>ZkTags<CR>", desc = "Zk: Search tags" },
    { "<Leader>z[", "<CMD>ZkBacklinks<CR>", desc = "Zk: Search backlinks" },
    { "<Leader>z]", "<CMD>ZkLinks<CR>", desc = "Zk: Search outbound links" },
  },
  config = function()
    require("zk").setup({ picker = "fzf_lua" })
  end,
}
