-- Use absolute line numbers in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.opt.relativenumber = false
	end,
})

-- Use relative line numbers in normal mode
vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.opt.relativenumber = true
	end,
})

-- Clear messages after a few seconds
vim.api.nvim_create_autocmd("CmdlineLeave", {
	callback = function()
		vim.defer_fn(function()
			vim.cmd("echon ''")
		end, 4000)
	end,
})

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Load any existing sessions
vim.api.nvim_create_autocmd("VimEnter", {
	nested = true,
	callback = function()
		if vim.fn.argc() == 0 and vim.fn.filereadable("Session.vim") == 1 then
			vim.cmd("silent source Session.vim")
		end
	end,
})
