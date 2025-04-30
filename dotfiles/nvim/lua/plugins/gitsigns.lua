return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map("n", "<Leader>gB", "<CMD>Gitsigns blame<CR>")
      map("n", "<Leader>gs", gitsigns.stage_buffer)
      map("n", "<Leader>gtb", gitsigns.toggle_current_line_blame)
      map("n", "<Leader>gtd", gitsigns.toggle_deleted)
      map("n", "<Leader>gtw", gitsigns.toggle_word_diff)
      map("n", "<Leader>gu", gitsigns.reset_buffer_index)
      map("n", "<Leader>gX", gitsigns.reset_buffer)
      map("n", "<Leader>hb", function()
        gitsigns.blame_line({ full = true })
      end)
      map("n", "<Leader>hp", gitsigns.preview_hunk)
      map("n", "<Leader>hs", gitsigns.stage_hunk)
      map("v", "<Leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end)
      map("n", "<Leader>hu", gitsigns.undo_stage_hunk)
      map("n", "<Leader>hX", gitsigns.reset_hunk)
      map("v", "<Leader>hX", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end)
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end)
      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end)
    end,
  },
}
