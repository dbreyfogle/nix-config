return {
  "justinmk/vim-sneak",
  keys = {
    { "s", mode = { "n", "v" }, desc = "Sneak forward" },
    { "S", mode = { "n", "v" }, desc = "Sneak backward" },
  },
  init = function()
    -- Disable highlighting
    vim.api.nvim_set_hl(0, "Sneak", {})
    vim.api.nvim_set_hl(0, "SneakCurrent", {})
    vim.api.nvim_create_autocmd("User", {
      pattern = "SneakLeave",
      callback = function()
        vim.api.nvim_set_hl(0, "Sneak", {})
        vim.api.nvim_set_hl(0, "SneakCurrent", {})
      end,
    })
  end,
}
