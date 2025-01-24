return {
  "brenoprata10/nvim-highlight-colors",
  config = function()
    require("nvim-highlight-colors").setup({
      render = "background",
      virtual_symbol = "■",
      enable_named_colors = true,
      --- highlight tailwind colors, e.g. 'bg-blue-500'
      enable_tailwind = true,
    })
  end,
}
