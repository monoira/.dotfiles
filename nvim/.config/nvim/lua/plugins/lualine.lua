-- bottom line
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- removes time on right
    opts.sections.lualine_z = {}
    -- removes insert, normal mode on left
    opts.sections.lualine_a = {}
  end,
}
