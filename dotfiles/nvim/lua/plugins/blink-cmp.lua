return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = { "rafamadriz/friendly-snippets" },
  event = { "InsertEnter", "CmdlineEnter" },
  keys = {
    {
      "<C-h>",
      function()
        vim.snippet.stop()
      end,
      mode = { "i", "n", "s" },
      desc = "Exit snippet",
    },
  },
  opts = {
    -- Disable completions for certain filetypes
    enabled = function()
      return not vim.tbl_contains({
        "dbout",
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
      trigger = { show_on_backspace_in_keyword = true },
    },

    keymap = {
      preset = "default",
      ["<C-d>"] = { "scroll_signature_down", "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_signature_up", "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "snippet_forward" },
      ["<C-b>"] = { "snippet_backward" },
      ["<Tab>"] = { "fallback" },
      ["<S-Tab>"] = { "fallback" },
    },

    signature = {
      enabled = true,
      window = { show_documentation = true },
    },

    sources = {
      per_filetype = { sql = { "dadbod", "path", "snippets", "buffer" } },
      providers = { dadbod = { module = "vim_dadbod_completion.blink" } },
    },
  },
}
