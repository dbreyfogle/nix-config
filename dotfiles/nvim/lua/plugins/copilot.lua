return {
	"zbirenbaum/copilot.lua",
	enabled = false,
	dependencies = { "zbirenbaum/copilot-cmp" },
	event = { "InsertEnter" },
	cmd = "Copilot",
	config = function()
		require("copilot").setup({
			suggestion = { enabled = false },
			panel = { enabled = false },
		})
		require("copilot_cmp").setup({})
	end,
}
