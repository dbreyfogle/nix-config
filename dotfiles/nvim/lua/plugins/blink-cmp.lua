return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = { "rafamadriz/friendly-snippets" },
  init = function()
    -- Hide copilot suggestions when menu is open
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuClose",
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
  opts = {
    -- Disable completions for certain filetypes
    enabled = function()
      return not vim.tbl_contains({
        "gitcommit",
        "gitrebase",
        "markdown",
        "oil",
        "txt",
      }, vim.bo.filetype)
    end,

    cmdline = {
      completion = { menu = { auto_show = true } },
      keymap = { preset = "inherit" },
    },

    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = { auto_show = true },
      ghost_text = { enabled = true },
    },

    keymap = {
      preset = "default",
      ["<Tab>"] = { "accept", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<M-\\>"] = { "hide", "fallback" }, -- copilot suggestion
    },

    signature = { enabled = true },
  },
}
