return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
	},
	keys = {
		{ "<C-Left>", "<CMD>TmuxNavigateLeft<CR>" },
		{ "<C-Down>", "<CMD>TmuxNavigateDown<CR>" },
		{ "<C-Up>", "<CMD>TmuxNavigateUp<CR>" },
		{ "<C-Right>", "<CMD>TmuxNavigateRight<CR>" },
	},
}
