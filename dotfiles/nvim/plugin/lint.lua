vim.pack.add({
  "https://github.com/mfussenegger/nvim-lint",
})

require("lint").linters_by_ft = {
  bash = { "shellcheck" },
  dockerfile = { "hadolint" },
  go = { "golangcilint" },
  make = { "checkmake" },
  markdown = { "markdownlint-cli2", "vale" },
  python = { "ruff" },
  sql = { "sqlfluff" },
  terraform = { "tofu" },
  yaml = { "yamllint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "TextChanged", "InsertLeave" }, {
  callback = function()
    if vim.opt_local.modifiable:get() then
      require("lint").try_lint()
    end
  end,
})
