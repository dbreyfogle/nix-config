return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			bash = { "shellcheck" },
			proto = { "buf_lint" },
			dockerfile = { "hadolint" },
			go = { "golangcilint" },
			markdown = { "markdownlint-cli2", "vale" },
			python = { "ruff" },
			terraform = { "tflint" },
			["yaml.ansible"] = { "ansible_lint" },
		}
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged" }, {
			callback = function()
				if vim.opt_local.modifiable:get() then
					lint.try_lint()
				end
			end,
		})
	end,
}
