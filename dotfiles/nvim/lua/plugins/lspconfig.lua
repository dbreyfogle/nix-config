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
    map("<C-j>", vim.diagnostic.open_float, { "i", "n" })
    map("<Leader>a", vim.lsp.buf.code_action)
    map("<Leader>r", vim.lsp.buf.rename)

    local lspconfig_defaults = require("lspconfig").util.default_config
    lspconfig_defaults.capabilities =
      vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

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
            and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
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
    require("lspconfig").taplo.setup({})
    require("lspconfig").terraformls.setup({
      on_attach = function(client, bufnr)
        vim.api.nvim_set_option_value("commentstring", "# %s", { buf = bufnr })
      end,
    })
    require("lspconfig").yamlls.setup({
      settings = {
        yaml = {
          schemaStore = { enable = false, url = "" },
          schemas = vim.tbl_deep_extend("force", require("schemastore").yaml.schemas({}), {
            kubernetes = {
              "*/k8s/*",
              "*/kubernetes/*",
              "*/manifests/*",
              "*/base/*",
              "*/overlays/*",
              "*/deployments/*",
              "*/services/*",
            },
          }),
        },
      },
    })

    vim.filetype.add({
      pattern = {
        [".*/templates/.*%.ya?ml"] = { "helm", { priority = 10 } },
        [".*/Chart%.ya?ml"] = { "helm", { priority = 10 } },
        [".*/values%.ya?ml"] = { "helm", { priority = 10 } },
      },
    })
  end,
}
