return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "L3MON4D3/LuaSnip" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "rafamadriz/friendly-snippets" },
		{ "windwp/nvim-autopairs" },
	},
	event = { "InsertEnter", "CmdlineEnter" },
	config = function()
		local cmp = require("cmp")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			},
			performance = { max_view_entries = 12 },
			experimental = { ghost_text = true },
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<M-f>"] = cmp.mapping(function()
					local luasnip = require("luasnip")
					if luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					end
				end, { "i", "s" }),
				["<M-b>"] = cmp.mapping(function()
					local luasnip = require("luasnip")
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
				["<C-f>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.close()
					end
					fallback() -- copilot suggestion
				end, { "i", "s" }),
			}),
		})

		-- Hide copilot suggestions when menu is open
		cmp.event:on("menu_opened", function()
			vim.b.copilot_suggestion_hidden = true
		end)
		cmp.event:on("menu_closed", function()
			vim.b.copilot_suggestion_hidden = false
		end)

		-- Disable completions for certain filetypes
		cmp.setup.filetype({ "markdown", "txt" }, {
			sources = {},
		})

		-- Search completions
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})

		-- Command line completions
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({ { name = "path" } }, {
				{ name = "cmdline", keyword_length = 2 },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		-- Insert matching pair after select function or method
		require("nvim-autopairs").setup({})
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
