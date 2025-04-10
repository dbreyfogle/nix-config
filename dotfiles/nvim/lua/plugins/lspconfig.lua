return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "nvim-telescope/telescope.nvim" },
		{ "b0o/schemastore.nvim" },
	},
	config = function()
		local map = function(keys, func, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func)
		end
		map("gd", require("telescope.builtin").lsp_definitions)
		map("gi", require("telescope.builtin").lsp_implementations)
		map("go", require("telescope.builtin").lsp_type_definitions)
		map("gr", require("telescope.builtin").lsp_references)
		map("<C-k>", vim.lsp.buf.signature_help, { "i", "n" })
		map("<Leader>a", vim.lsp.buf.code_action)
		map("<Leader>r", vim.lsp.buf.rename)
		map("<C-j>", vim.diagnostic.open_float, { "i", "n" })
		map("]d", vim.diagnostic.goto_next)
		map("[d", vim.diagnostic.goto_prev)

		local lspconfig_defaults = require("lspconfig").util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			"force",
			lspconfig_defaults.capabilities,
			require("cmp_nvim_lsp").default_capabilities()
		)

		require("lspconfig").ansiblels.setup({})
		require("lspconfig").bashls.setup({})
		require("lspconfig").buf_ls.setup({})
		require("lspconfig").dockerls.setup({})
		require("lspconfig").gopls.setup({})
		require("lspconfig").helm_ls.setup({})
		require("lspconfig").jsonls.setup({
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
		require("lspconfig").lua_ls.setup({
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end
				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = { version = "LuaJIT" },
					workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
				})
			end,
			settings = { Lua = {} },
		})
		require("lspconfig").nixd.setup({})
		require("lspconfig").pyright.setup({})
		require("lspconfig").solargraph.setup({})
		require("lspconfig").taplo.setup({})
		require("lspconfig").terraformls.setup({
			on_attach = function(client, bufnr)
				vim.api.nvim_set_option_value("commentstring", "# %s", { buf = bufnr })
			end,
		})
		require("lspconfig").yamlls.setup({
			settings = {
				yaml = {
					schemas = require("schemastore").yaml.schemas(),
					schemaStore = { enable = false, url = "" },
				},
			},
			filetypes = table.insert(
				require("lspconfig").yamlls.document_config.default_config.filetypes,
				"yaml.kubernetes" -- custom handling for kubernetes files
			),
		})

		-- Detect filetypes by pattern
		vim.filetype.add({
			pattern = {
				[".*/templates/.*%.ya?ml"] = { "helm", { priority = 10 } },
				[".*/Chart%.ya?ml"] = { "helm", { priority = 10 } },
				[".*/values%.ya?ml"] = { "helm", { priority = 10 } },

				[".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
				[".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
				[".*/group_vars/.*/.*%.ya?ml"] = "yaml.ansible",
				[".*/.*playbook.*%.ya?ml"] = "yaml.ansible",
				[".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
				[".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
				[".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
				[".*/tasks/.*%.ya?ml"] = "yaml.ansible",
				[".*/molecule/.*%.ya?ml"] = "yaml.ansible",

				[".*/k8s/.*%.ya?ml"] = "yaml.kubernetes",
				[".*/kubernetes/.*%.ya?ml"] = "yaml.kubernetes",
				[".*/manifests/.*%.ya?ml"] = "yaml.kubernetes",
				[".*/base/.*%.ya?ml"] = "yaml.kubernetes",
				[".*/overlays/.*%.ya?ml"] = "yaml.kubernetes",
				[".*/deployments/.*%.ya?ml"] = "yaml.kubernetes",
				[".*/services/.*%.ya?ml"] = "yaml.kubernetes",
				[".*/.*deployment.*%.ya?ml"] = "yaml.kubernetes",
				[".*/.*service.*%.ya?ml"] = "yaml.kubernetes",
				[".*/.*configmap.*%.ya?ml"] = "yaml.kubernetes",
				[".*/.*secret.*%.ya?ml"] = "yaml.kubernetes",
				[".*/.*daemonset.*%.ya?ml"] = "yaml.kubernetes",
				[".*/.*ingress.*%.ya?ml"] = "yaml.kubernetes",
				[".*/.*statefulset.*%.ya?ml"] = "yaml.kubernetes",
			},
		})

		-- Apply kubernetes schema to custom yaml.kubernetes filetypes
		vim.api.nvim_create_autocmd({ "LspAttach", "FileType" }, {
			callback = function()
				if vim.bo.filetype == "yaml.kubernetes" then -- filetype matched by pattern rules or applied manually
					local client = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf(), name = "yamlls" })[1]
					if client then
						local set = {} -- create the set of names which are already part of the schema table
						if not client.config.settings.yaml.schemas["kubernetes"] then
							client.config.settings.yaml.schemas["kubernetes"] = {}
						else
							for _, name in ipairs(client.config.settings.yaml.schemas["kubernetes"]) do
								set[name] = true
							end
						end
						local buf_name = vim.api.nvim_buf_get_name(0)
						if not set[buf_name] then -- add the current name if not present
							table.insert(client.config.settings.yaml.schemas["kubernetes"], buf_name)
							client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
						end
					end
				end
			end,
		})
	end,
}
