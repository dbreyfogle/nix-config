return {
  "jpalardy/vim-slime",
  keys = {
    { "<C-c>;", "<Plug>SlimeLineSend", desc = "Slime: Send line" },
    { "<C-c>;", "<Plug>SlimeRegionSend", mode = "v", desc = "Slime: Send selection" },
    { "<C-c>'", "<Plug>SlimeSendCell", desc = "Slime: Send cell" },
  },
  init = function()
    vim.g.slime_no_mappings = 1
    vim.g.slime_target = "tmux"
    vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
    vim.g.slime_dont_ask_default = 1
    vim.g.slime_cell_delimiter = "# %%"
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        vim.b.slime_bracketed_paste = 1
      end,
    })
  end,
}
