-- LSP clients
vim.lsp.enable("bashls")
vim.lsp.enable("buf_ls")
vim.lsp.enable("dockerls")
vim.lsp.enable("gopls")
vim.lsp.enable("helm_ls")
vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
  on_init = function(client)
    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
    })
  end,
  settings = { Lua = {} },
})
vim.lsp.enable("nixd")
vim.lsp.enable("pyright")
vim.lsp.enable("taplo")
vim.lsp.enable("terraformls")

-- Assign filetypes by path
vim.filetype.add({
  pattern = {
    [".*/templates/.*%.ya?ml"] = { "helm", { priority = 10 } },
    [".*/Chart%.ya?ml"] = { "helm", { priority = 10 } },
    [".*/values%.ya?ml"] = { "helm", { priority = 10 } },
  },
})

-- Diagnostic settings
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
})
