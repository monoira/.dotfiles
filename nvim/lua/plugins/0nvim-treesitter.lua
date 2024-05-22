return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      -- defaults
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",

      -- NOTE: MY ADDITIONS
      "css",
      "gitcommit",

      -- golang
      "go",
      "gomod",
      "gowork",
      "gosum",

      -- docker
      "dockerfile",
    })
  end,
}
