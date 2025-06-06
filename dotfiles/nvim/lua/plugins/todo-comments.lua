return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
    },
  },
  opts = { signs = false },
}
