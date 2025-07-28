-- Swap <Esc> and <C-c>
vim.keymap.set({ "" }, "<Esc>", "<C-c>")
vim.keymap.set({ "" }, "<C-c>", "<Esc>")
vim.keymap.set({ "!" }, "<Esc>", "<C-c>")
vim.keymap.set({ "!" }, "<C-c>", "<Esc>")

-- Set leader
vim.g.mapleader = " "

-- Tab management
vim.keymap.set({ "n" }, "<Leader>tc", "<CMD>tabclose<CR>", { desc = "Close the current tab" })
vim.keymap.set({ "n" }, "<Leader>tn", "<CMD>tabnew<CR>", { desc = "Open a new tab" })
vim.keymap.set({ "n" }, "<Leader>to", "<CMD>tabonly<CR>", { desc = "Close all other tabs" })
vim.keymap.set({ "n" }, "<Leader>t>", "<CMD>+tabmove<CR>", { desc = "Move tab to the right" })
vim.keymap.set({ "n" }, "<Leader>t<", "<CMD>-tabmove<CR>", { desc = "Move tab to the left" })

-- Paste the most recent yank
vim.keymap.set({ "n", "v" }, "<Leader>p", '"0p', { desc = "Paste most recent yank after cursor" })
vim.keymap.set({ "n", "v" }, "<Leader>P", '"0P', { desc = "Paste most recent yank before cursor" })

-- Move lines
vim.keymap.set({ "n" }, "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set({ "n" }, "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set({ "v" }, "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set({ "v" }, "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
