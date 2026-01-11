return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<Leader>f",
      function()
        require("conform").format({ async = true })
      end,
      desc = "Format buffer",
    },
  },
  init = function()
    -- Commands to enable/disable autoformatting
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then -- FormatDisable! for just the current buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { bang = true })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {})
  end,
  opts = {
    formatters_by_ft = {
      ["*"] = { "injected" },
      bash = { "shfmt" },
      proto = { "buf" },
      go = { "goimports" },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      nix = { "nixfmt" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      sql = { "sqlfluff_format" },
      terraform = { "terraform_fmt" },
      toml = { "taplo" },
      yaml = { "prettier" },
    },

    formatters = {
      sqlfluff_format = {
        inherit = "sqlfluff",
        args = { "format", "-" },
      },
    },

    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 3000 }
    end,
  },
}
