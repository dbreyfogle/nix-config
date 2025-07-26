return {
  "neovim/nvim-lspconfig",
  dependencies = { "b0o/schemastore.nvim" },
  config = function()
    -- Diagnostic options
    vim.diagnostic.config({ severity_sort = true, virtual_text = true })

    -- LSP clients
    vim.lsp.enable("bashls")
    vim.lsp.enable("buf_ls")
    vim.lsp.enable("dockerls")
    vim.lsp.enable("gopls")
    vim.lsp.enable("helm_ls")
    vim.lsp.config("jsonls", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })
    vim.lsp.enable("jsonls")
    vim.lsp.config("lua_ls", {
      on_init = function(client)
        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
          workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
        })
      end,
      settings = { Lua = {} },
    })
    vim.lsp.enable("lua_ls")
    vim.lsp.config("nixd", {
      settings = {
        nixd = {
          nixpkgs = { expr = 'import (builtins.getFlake ("git+file://" + toString ./.)).inputs.nixpkgs { }' },
          options = {
            nixos = {
              expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.desktop.options',
            },
            nix_darwin = {
              expr = '(builtins.getFlake ("git+file://" + toString ./.)).darwinConfigurations.macbook.options',
            },
            home_manager = {
              expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.desktop.options.home-manager.users.type.getSubOptions []',
            },
          },
        },
      },
    })
    vim.lsp.enable("nixd")
    vim.lsp.enable("pyright")
    vim.lsp.enable("taplo")
    vim.lsp.enable("terraformls")
    vim.lsp.config("yamlls", {
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
    vim.lsp.enable("yamlls")

    -- Assign filetypes by path
    vim.filetype.add({
      pattern = {
        [".*/templates/.*%.ya?ml"] = { "helm", { priority = 10 } },
        [".*/Chart%.ya?ml"] = { "helm", { priority = 10 } },
        [".*/values%.ya?ml"] = { "helm", { priority = 10 } },
      },
    })
  end,
}
