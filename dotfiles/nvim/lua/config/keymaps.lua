-- Swap <Esc> and <C-c>
vim.keymap.set({ "" }, "<Esc>", "<C-c>")
vim.keymap.set({ "" }, "<C-c>", "<Esc>")
vim.keymap.set({ "!" }, "<Esc>", "<C-c>")
vim.keymap.set({ "!" }, "<C-c>", "<Esc>")

-- Set leader
vim.g.mapleader = " "

-- Paste the most recent yank
vim.keymap.set({ "n", "v" }, "<Leader>p", '"0p')
vim.keymap.set({ "n", "v" }, "<Leader>P", '"0P')
