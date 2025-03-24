return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	priority = 1000,
	keys = { { "-", "<CMD>Oil<CR>" } },
	---@module "oil"
	---@type oil.SetupOpts
	opts = {
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name, bufnr)
				return vim.tbl_contains({
					".DS_Store",
				}, name)
			end,
		},
	},
}
