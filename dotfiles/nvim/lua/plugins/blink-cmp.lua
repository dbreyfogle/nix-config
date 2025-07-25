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
      "<C-f>",
      function()
        require("blink.cmp").snippet_forward()
      end,
      desc = "Jump to the next snippet placeholder",
    },
    {
      "<C-b>",
      function()
        require("blink.cmp").snippet_backward()
      end,
      desc = "Jump to the previous snippet placeholder",
    },
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
      documentation = {
        auto_show = true,
        window = {
          max_width = 80,
          max_height = 15,
        },
      },
      ghost_text = { enabled = true },
    },

    keymap = {
      preset = "default",
      ["<Tab>"] = { "accept", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "snippet_forward" },
      ["<C-b>"] = { "snippet_backward" },
    },

    sources = {
      per_filetype = { sql = { "dadbod", "snippets", "buffer" } },
      providers = { dadbod = { module = "vim_dadbod_completion.blink" } },
    },
  },
}
