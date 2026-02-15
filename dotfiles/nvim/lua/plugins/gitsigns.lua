return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "]c",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          require("gitsigns").nav_hunk("next")
        end
      end,
      desc = "Git: Jump to the next change",
    },
    {
      "[c",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          require("gitsigns").nav_hunk("prev")
        end
      end,
      desc = "Git: Jump to the previous change",
    },
    {
      "<Leader>g-",
      function()
        require("gitsigns").stage_hunk()
      end,
      desc = "Git: Stage/unstage hunk",
    },
    {
      "<Leader>g-",
      function()
        require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = "v",
      desc = "Git: Stage/unstage visual selection",
    },
    {
      "<Leader>gX",
      function()
        require("gitsigns").reset_hunk()
      end,
      desc = "Git: Reset hunk",
    },
    {
      "<Leader>gX",
      function()
        require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = "v",
      desc = "Git: Reset visual selection",
    },
    {
      "<Leader>gtb",
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      desc = "Git: Toggle current line blame",
    },
    {
      "<Leader>gtd",
      function()
        require("gitsigns").toggle_deleted()
      end,
      desc = "Git: Toggle deleted lines",
    },
    {
      "<Leader>gtw",
      function()
        require("gitsigns").toggle_word_diff()
      end,
      desc = "Git: Toggle word diff highlighting",
    },
  },
}
