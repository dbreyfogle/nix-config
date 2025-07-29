return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    dashboard = {
      preset = {
        header = "Neovim",
        keys = {
          { icon = " ", key = "n", desc = "New File", action = ":ene" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "d", desc = "Git Diff", action = ":execute 'DiffviewOpen' | tabonly" },
          { icon = " ", key = "l", desc = "Git Log", action = ":execute 'DiffviewFileHistory' | tabonly" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header", padding = 2 },
        { section = "keys", gap = 1, padding = 4 },
        { section = "startup" },
      },
    },
    indent = {
      animate = { enabled = false },
      scope = { enabled = false },
    },
  },
}
