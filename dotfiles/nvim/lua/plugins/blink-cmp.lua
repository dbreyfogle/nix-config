return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    require("blink.cmp").setup({
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
        ["<C-f>"] = { "snippet_forward" },
        ["<C-b>"] = { "snippet_backward" },
      },

      signature = { enabled = true },
    })

    -- Additional snippet keymaps
    local cmp = require("blink.cmp")
    vim.keymap.set({ "n" }, "<C-f>", function()
      cmp.snippet_forward()
    end)
    vim.keymap.set({ "n" }, "<C-b>", function()
      cmp.snippet_backward()
    end)
    vim.keymap.set({ "i", "n", "s" }, "<C-h>", function()
      vim.snippet.stop()
    end)
  end,
}
