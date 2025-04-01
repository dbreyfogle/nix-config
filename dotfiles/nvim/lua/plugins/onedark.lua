return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			style = "dark",
			-- transparent = true,
			-- lualine = { transparent = true },
		})
		require("onedark").load()
		vim.cmd("hi ModeMsg guifg=NONE") -- remove styling
	end,
}
