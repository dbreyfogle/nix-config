return {
  "jpalardy/vim-slime",
  keys = {
    { "<C-c>;", "<Plug>SlimeLineSend" },
    { "<C-c>;", "<Plug>SlimeRegionSend", mode = "v" },
    { "<C-c>'", "<Plug>SlimeSendCell" },
  },
  init = function()
    vim.g.slime_no_mappings = 1
    vim.g.slime_target = "tmux"
    vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
    vim.g.slime_dont_ask_default = 1
    vim.g.slime_cell_delimiter = "# %%"
  end,
}
