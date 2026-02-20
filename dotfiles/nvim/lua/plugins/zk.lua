return {
  "zk-org/zk-nvim",
  keys = {
    { "<Leader>zf", "<CMD>ZkNotes<CR>", desc = "Zk: Search notes by title" },
    { "<Leader>zi", "<CMD>ZkInsertLink<CR>", desc = "Zk: Insert link" },
    { "<Leader>zi", ":'<,'>ZkInsertLinkAtSelection<CR>", mode = { "v" }, desc = "Zk: Insert link around selection" },
    { "<Leader>zn", "<CMD>ZkNew<CR>", desc = "Zk: New note" },
    { "<Leader>zR", "<CMD>ZkIndex<CR>", desc = "Zk: Index notebook" },
    { "<Leader>zt", "<CMD>ZkTags<CR>", desc = "Zk: Search tags" },
    { "<Leader>z[", "<CMD>ZkBacklinks<CR>", desc = "Zk: Search backlinks" },
    { "<Leader>z]", "<CMD>ZkLinks<CR>", desc = "Zk: Search outbound links" },
  },
  config = function()
    require("zk").setup({ picker = "fzf_lua" })
  end,
}
