return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "kristijanhusak/vim-dadbod-completion",
  },
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
    },

    keymap = {
      preset = "default",
      ["<C-d>"] = {
        function()
          local signature = require("blink.cmp.signature.window")
          if signature.win:is_open() then
            signature.scroll_down(4)
            return true
          end
        end,
        "scroll_documentation_down",
        "fallback",
      },
      ["<C-u>"] = {
        function()
          local signature = require("blink.cmp.signature.window")
          if signature.win:is_open() then
            signature.scroll_up(4)
            return true
          end
        end,
        "scroll_documentation_up",
        "fallback",
      },
      ["<C-f>"] = { "snippet_forward" },
      ["<C-b>"] = { "snippet_backward" },
    },

    signature = {
      enabled = true,
      window = { show_documentation = true },
    },

    sources = {
      per_filetype = { sql = { "dadbod", "snippets", "buffer" } },
      providers = { dadbod = { module = "vim_dadbod_completion.blink" } },
    },
  },
}
