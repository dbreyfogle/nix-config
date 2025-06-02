return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged" }, {
      callback = function()
        if vim.opt_local.modifiable:get() then
          require("lint").try_lint()
        end
      end,
    })
  end,
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      bash = { "shellcheck" },
      dockerfile = { "hadolint" },
      go = { "golangcilint" },
      make = { "checkmake" },
      markdown = { "markdownlint-cli2", "vale" },
      python = { "ruff" },
      sql = { "sqlfluff" },
      terraform = { "tflint" },
    }

    local golangcilint = require("lint").linters.golangcilint
    golangcilint.ignore_exitcode = true

    local sqlfluff = require("lint").linters.sqlfluff
    sqlfluff.args = { "lint", "--format=json", "-" }
    sqlfluff.stdin = true
  end,
}
