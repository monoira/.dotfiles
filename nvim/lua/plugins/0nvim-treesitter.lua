return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      -- NOTE: default syntax highlighting packages in LazyVim
      -- http://www.lazyvim.org/plugins/treesitter#nvim-treesitter

      -- NOTE: personal additions
      "css",
    })
  end,
}
