return {
  {
    "levouh/tint.nvim",
    config = function()
      require("tint").setup()
    end,
  },

  -- Ensure termguicolors is enabled if not already in options.lua
  -- vim.opt.termguicolors = true
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        ---Render style
        ---@usage 'background'|'foreground'|'virtual'
        render = "background",

        ---Set virtual symbol (requires render to be set to 'virtual')
        virtual_symbol = "■",

        ---Highlight named colors, e.g. 'green'
        enable_named_colors = true,

        ---Highlight tailwind colors, e.g. 'bg-blue-500'
        enable_tailwind = false,
      })
    end,
  },
}
