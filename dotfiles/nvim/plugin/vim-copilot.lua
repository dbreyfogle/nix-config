vim.g.copilot_filetypes = {
  ["dbout"] = false,
  ["gitcommit"] = false,
  ["gitrebase"] = false,
  ["oil"] = false,
}

vim.pack.add({
  "https://github.com/github/copilot.vim",
})

-- Prevent attaching to sensitive files
local home_dir = vim.fn.expand("~")
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  pattern = {
    home_dir .. "/.aws/*",
    home_dir .. "/.gnupg/*",
    home_dir .. "/.kube/*",
    home_dir .. "/.ssh/*",
    home_dir .. "/Documents/*",
    home_dir .. "/Library/CloudStorage/*",
    "*/secrets/*",
    ".env",
    ".env.*",
    ".envrc",
    "id_rsa",
    "id_ed25519",
    "*.key",
    "*.pem",
    "*.tfvars",
  },
  callback = function()
    vim.b.copilot_enabled = false
  end,
})

vim.keymap.set("i", "<C-j>", "<Plug>(copilot-accept-word)", { desc = "Copilot: Accept word" })
