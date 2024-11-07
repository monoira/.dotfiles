-- Adds extra language tools. By default LazyVim adds them when you activate extra for it.
-- But it doesn't add some bash ones since it doesn't have bash extra for example,
-- so I have to add bash linter, language-server, etc.
return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "emmet-language-server",
      "html-lsp",
      "css-lsp",
      "css-variables-language-server",
      "cssmodules-language-server",

      "vim-language-server",
      "typos-lsp",

      -- NOTE: bash - shfmt is installed by default by LazyVim
      "bash-language-server",
      "shellcheck",
      -- bash adapter for debugger
      "bash-debug-adapter",
    })
  end,
}
