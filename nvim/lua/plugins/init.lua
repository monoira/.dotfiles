return {
  {
    "levouh/tint.nvim",
    config = function()
      require("tint").setup()
    end,
  },
  -- NOTE: colorizer - documentation at github
  -- maybe change to
  -- https://github.com/brenoprata10/nvim-highlight-colors
  -- for better coloring? seems like better option, but needs neovim 10
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = true,
          RRGGBBAA = true,
          AARRGGBB = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
          mode = "background",
          tailwind = true,
          sass = { enable = true, parsers = { "css" } },
          virtualtext = "■",
          always_update = true,
        },
        buftypes = {},
      })
    end,
  },
}
