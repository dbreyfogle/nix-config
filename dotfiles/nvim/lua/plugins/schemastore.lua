return {
  "b0o/schemastore.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    require("lspconfig").jsonls.setup({
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
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
  end,
}
