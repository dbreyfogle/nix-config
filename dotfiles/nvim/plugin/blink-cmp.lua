vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("blink.cmp").setup({
  -- Disable completions for certain filetypes
  enabled = function()
    return not vim.tbl_contains({
      "dbout",
      "gitcommit",
      "gitrebase",
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
    per_filetype = {
      markdown = { "lsp" },
      sql = { "dadbod", "lsp", "path", "snippets", "buffer" },
    },
    providers = {
      dadbod = { module = "vim_dadbod_completion.blink" },
    },
  },
})

vim.keymap.set({ "i", "n", "s" }, "<C-h>", function()
  vim.snippet.stop()
end, { desc = "Exit snippet" })
