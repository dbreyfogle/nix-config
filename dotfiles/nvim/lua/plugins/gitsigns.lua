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

      map("<Leader>gdD", gitsigns.diffthis)
      map("<Leader>ghb", function()
        gitsigns.blame_line({ full = true })
      end)
      map("<Leader>ghp", gitsigns.preview_hunk)
      map("<Leader>ghs", gitsigns.stage_hunk)
      map("<Leader>ghs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "v")
      map("<Leader>ghX", gitsigns.reset_hunk)
      map("<Leader>ghX", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "v")
      map("<Leader>gbl", gitsigns.blame)
      map("<Leader>gs", gitsigns.stage_buffer)
      map("<Leader>gtb", gitsigns.toggle_current_line_blame)
      map("<Leader>gtd", gitsigns.toggle_deleted)
      map("<Leader>gtw", gitsigns.toggle_word_diff)
      map("<Leader>gu", gitsigns.reset_buffer_index)
      map("<Leader>gX", gitsigns.reset_buffer)

      map("]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end)
      map("[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end)
    end,
  },
}
