return {
  "dstein64/nvim-scrollview",
  config = function(_, opts)
    require("scrollview").setup(opts)
    require("scrollview.contrib.gitsigns").setup(opts)

    vim.g.scrollview_excluded_filetypes = { "neo-tree", "nerdtree" }
    vim.g.scrollview_current_only = true
    vim.g.column = 80
    vim.g.scrollview_signs_on_startup = {
      "diagnostics",
      "marks",
      "search",
      "conflicts",
      "cursor",
      "search",
      "textwidth",
    }
    vim.g.scrollview_diagnostics_severities = {
      vim.diagnostic.severity.ERROR,
      -- vim.diagnostic.severity.INFO,
      -- vim.diagnostic.severity.HINT,
      -- vim.diagnostic.severity.WARN,
    }
  end,
  opts = {
    always_show = true,
  },
}
