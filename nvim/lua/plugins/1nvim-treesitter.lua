-- NOTE: this is default lazy.vim's ensure_installed.
-- you can append more to this list below

-- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in
-- Neovim and to provide some basic functionality such as highlighting based on it:

-- ensure_installed = {
--  "bash",
--  "c",
--  "diff",
--  "html",
--  "javascript",
--  "jsdoc",
--  "json",
--  "jsonc",
--  "lua",
--  "luadoc",
--  "luap",
--  "markdown",
--  "markdown_inline",
--  "python",
--  "query",
--  "regex",
--  "toml",
--  "tsx",
--  "typescript",
--  "vim",
--  "vimdoc",
--  "xml",
--  "yaml",
-- },

return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "css",
      "http",
      "graphql",
    })
  end,
}
