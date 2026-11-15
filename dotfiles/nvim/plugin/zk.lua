vim.pack.add({
  "https://github.com/zk-org/zk-nvim",
})

require("zk").setup({ picker = "fzf_lua" })

vim.keymap.set("n", "<Leader>zd", "<CMD>ZkNew { dir = 'daily' }<CR>", { desc = "Zk: Open daily note" })
vim.keymap.set("n", "<Leader>zf", "<CMD>ZkNotes<CR>", { desc = "Zk: Search notes by title" })
vim.keymap.set("v", "<Leader>zf", ":'<,'>ZkMatch<CR>", { silent = true, desc = "Zk: Search notes from selection" })
vim.keymap.set("n", "<Leader>zi", "<CMD>ZkInsertLink<CR>", { desc = "Zk: Insert link" })
vim.keymap.set("v", "<Leader>zi", ":'<,'>ZkInsertLinkAtSelection { matchSelected = 'true' }<CR>", {
  silent = true,
  desc = "Zk: Insert link at selection",
})
vim.keymap.set("n", "<Leader>zI", "<CMD>ZkIndex<CR>", { desc = "Zk: Index notebook" })
vim.keymap.set(
  "n",
  "<Leader>zn",
  "<CMD>execute 'ZkNew { title = ''' . input('title: ') . ''' }'<CR>",
  { desc = "Zk: New note" }
)
vim.keymap.set(
  "v",
  "<Leader>zn",
  ":'<,'>ZkNewFromTitleSelection<CR>",
  { silent = true, desc = "Zk: New note from selection" }
)
vim.keymap.set("n", "<Leader>zt", "<CMD>ZkTags<CR>", { desc = "Zk: Search tags" })
vim.keymap.set("n", "<Leader>z[", "<CMD>ZkBacklinks<CR>", { desc = "Zk: Search backlinks" })
vim.keymap.set("n", "<Leader>z]", "<CMD>ZkLinks<CR>", { desc = "Zk: Search outbound links" })
