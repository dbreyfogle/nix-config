return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<Leader>f",
			function()
				require("conform").format({ async = true })
			end,
		},
	},
	opts = {
		formatters_by_ft = {
			bash = { "shfmt" },
			proto = { "buf" },
			go = { "gofmt" },
			json = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			nix = { "nixfmt" },
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			ruby = { "rubocop" },
			terraform = { "terraform_fmt" },
			toml = { "taplo" },
			yaml = { "prettier" },
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500 }
		end,
	},
	init = function()
		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, { bang = true }) -- FormatDisable! for only the current buffer
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {})
	end,
}
