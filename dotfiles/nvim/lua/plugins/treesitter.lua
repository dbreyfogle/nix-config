return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  init = function()
    local ensure_installed = {
      "html",
      "markdown",
      "markdown_inline",
    }
    local installed = require("nvim-treesitter").get_installed()
    local to_install = {}
    for _, lang in ipairs(ensure_installed) do
      if not vim.tbl_contains(installed, lang) then
        table.insert(to_install, lang)
      end
    end
    if #to_install > 0 then
      vim.schedule(function()
        vim.cmd("silent! TSInstall " .. table.concat(to_install, " "))
      end)
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local function ts_setup(bufnr)
          if vim.api.nvim_get_current_buf() ~= bufnr then
            return
          end
          vim.treesitter.start()
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        -- Auto install missing parsers
        local lang = vim.bo[args.buf].filetype
        if vim.tbl_contains(require("nvim-treesitter").get_installed(), lang) then
          ts_setup(args.buf)
        else
          if vim.tbl_contains(require("nvim-treesitter").get_available(), lang) then
            vim.cmd("silent! TSInstall " .. lang)
            vim.defer_fn(function()
              pcall(ts_setup, args.buf)
            end, 4000) -- wait a few seconds for install to complete
          end
        end
      end,
    })
  end,
}
