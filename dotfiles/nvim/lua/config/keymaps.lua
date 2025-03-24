-- Remap to <Esc>
vim.keymap.set({ "i", "s" }, "<C-c>", "<Esc>")

-- Set leader
vim.g.mapleader = " "

-- Delete without affecting other registers
vim.keymap.set({ "n", "v" }, "<Leader>d", '"_d')
vim.keymap.set({ "n", "v" }, "<Leader>D", '"_D')

-- Paste the most recent yank
vim.keymap.set({ "n", "v" }, "<Leader>p", '"0p')
vim.keymap.set({ "n", "v" }, "<Leader>P", '"0P')
