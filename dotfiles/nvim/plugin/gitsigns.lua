vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

vim.keymap.set("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal({ "]c", bang = true })
  else
    require("gitsigns").nav_hunk("next")
  end
end, { desc = "Git: Jump to the next change" })

vim.keymap.set("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal({ "[c", bang = true })
  else
    require("gitsigns").nav_hunk("prev")
  end
end, { desc = "Git: Jump to the previous change" })

vim.keymap.set("n", "<Leader>g-", function()
  require("gitsigns").stage_hunk()
end, { desc = "Git: Stage/unstage hunk" })

vim.keymap.set("v", "<Leader>g-", function()
  require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Git: Stage/unstage visual selection" })

vim.keymap.set("n", "<Leader>gX", function()
  require("gitsigns").reset_hunk()
end, { desc = "Git: Reset hunk" })

vim.keymap.set("v", "<Leader>gX", function()
  require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Git: Reset visual selection" })

vim.keymap.set("n", "<Leader>gtb", function()
  require("gitsigns").toggle_current_line_blame()
end, { desc = "Git: Toggle current line blame" })

vim.keymap.set("n", "<Leader>gtd", function()
  require("gitsigns").toggle_deleted()
end, { desc = "Git: Toggle deleted lines" })

vim.keymap.set("n", "<Leader>gtw", function()
  require("gitsigns").toggle_word_diff()
end, { desc = "Git: Toggle word diff highlighting" })
