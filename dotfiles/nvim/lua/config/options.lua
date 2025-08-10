-- Display line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable line wrapping
vim.opt.wrap = false

-- Search settings
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indentation settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0 -- follow tabstop
vim.opt.softtabstop = -1 -- follow shiftwidth
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Folding settings
vim.opt.foldenable = false
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldtext = " "

-- Automatically focus new splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Keep cursor centered
vim.opt.scrolloff = 12
vim.opt.sidescroll = 0

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable mouse usage
vim.opt.mouse = "a"

-- Increase mapping timeout
vim.opt.timeoutlen = 2000

-- Save undo history
vim.opt.undofile = true

-- Set terminal colors
vim.opt.termguicolors = true

-- Reserve a space for signs
vim.opt.signcolumn = "yes"

-- Hide mode indicator
vim.opt.showmode = false

-- Disable ruler
vim.opt.ruler = false

-- Cursor blinking
vim.opt.guicursor = vim.opt.guicursor + "a:blinkon500-blinkoff500"

-- Disable highlighting matching parens
vim.g.loaded_matchparen = 1

-- Disable SQL mappings
vim.g.omni_sql_no_default_maps = 1

-- Diagnostic options
vim.diagnostic.config({ severity_sort = true, virtual_text = true })
