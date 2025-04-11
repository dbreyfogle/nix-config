return {
	"zbirenbaum/copilot.lua",
	event = { "InsertEnter" },
	cmd = "Copilot",
	config = function()
		require("copilot").setup({
			suggestion = {
				keymap = { accept = "<C-f>" },
			},
		})
	end,
}
