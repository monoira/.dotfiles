return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    -- NOTE: time it takes for which_key menu to appear
    vim.o.timeoutlen = 1000
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
  },
}
