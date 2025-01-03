-- bottom line
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- time on right
    opts.sections.lualine_z = {}
    -- mode on left - insert, normal
    opts.sections.lualine_a = {}
  end,
}
