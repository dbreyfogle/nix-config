return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      local map = function(keys, func, mode, opts)
        mode = mode or "n"
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, keys, func, opts)
      end

      map("<Leader>gdD", gitsigns.diffthis, "n", { desc = "Git: Diff buffer" })
      map("<Leader>ghb", function()
        gitsigns.blame_line({ full = true })
      end, "n", { desc = "Git: Blame hunk" })
      map("<Leader>ghp", gitsigns.preview_hunk, "n", { desc = "Git: Preview hunk" })
      map("<Leader>ghs", gitsigns.stage_hunk, "n", { desc = "Git: Stage/unstage hunk" })
      map("<Leader>ghs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "v", { desc = "Git: Stage/unstage selected hunk" })
      map("<Leader>ghX", gitsigns.reset_hunk, "n", { desc = "Git: Reset hunk" })
      map("<Leader>ghX", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "v", { desc = "Git: Reset selected hunk" })
      map("<Leader>gbl", gitsigns.blame, "n", { desc = "Git: Blame buffer" })
      map("<Leader>gs", gitsigns.stage_buffer, "n", { desc = "Git: Stage buffer" })
      map("<Leader>gtb", gitsigns.toggle_current_line_blame, "n", { desc = "Git: Toggle current line blame" })
      map("<Leader>gtd", gitsigns.toggle_deleted, "n", { desc = "Git: Toggle deleted lines" })
      map("<Leader>gtw", gitsigns.toggle_word_diff, "n", { desc = "Git: Toggle word diff highlighting" })
      map("<Leader>gu", gitsigns.reset_buffer_index, "n", { desc = "Git: Unstage buffer" })
      map("<Leader>gX", gitsigns.reset_buffer, "n", { desc = "Git: Reset buffer" })

      map("]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, "n", { desc = "Git: Jump to the next change" })
      map("[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, "n", { desc = "Git: Jump to the previous change" })
    end,
  },
}
