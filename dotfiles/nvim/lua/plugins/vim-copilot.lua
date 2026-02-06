return {
  "github/copilot.vim",
  event = "VeryLazy",
  keys = {
    { "<Tab>", mode = "i", desc = "Copilot: Accept suggestion" },
    { "<C-j>", "<Plug>(copilot-accept-word)", mode = "i", desc = "Copilot: Accept word" },
    { "<C-]>", mode = "i", desc = "Copilot: Clear suggestion" },
  },
  init = function()
    vim.g.copilot_filetypes = {
      ["dbout"] = false,
      ["gitcommit"] = false,
      ["gitrebase"] = false,
      ["oil"] = false,
    }

    -- Prevent attaching to sensitive files
    local home_dir = vim.fn.expand("~")
    vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
      pattern = {
        home_dir .. "/.aws/*",
        home_dir .. "/.gnupg/*",
        home_dir .. "/.kube/*",
        home_dir .. "/.ssh/*",
        home_dir .. "/Documents/*",
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
  end,
}
