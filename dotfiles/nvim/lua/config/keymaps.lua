-- Swap <Esc> and <C-c>
vim.keymap.set({ "" }, "<Esc>", "<C-c>")
vim.keymap.set({ "" }, "<C-c>", "<Esc>")
vim.keymap.set({ "!" }, "<Esc>", "<C-c>")
vim.keymap.set({ "!" }, "<C-c>", "<Esc>")

-- Set leader
vim.g.mapleader = " "

-- Paste the most recent yank
vim.keymap.set({ "n", "v" }, "<Leader>p", '"0p', { desc = "Paste most recent yank after cursor" })
vim.keymap.set({ "n", "v" }, "<Leader>P", '"0P', { desc = "Paste most recent yank before cursor" })

-- Move lines
vim.keymap.set({ "n" }, "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set({ "n" }, "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set({ "v" }, "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set({ "v" }, "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
