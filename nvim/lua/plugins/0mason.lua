return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "html-lsp",
      "css-lsp",
      "css-variables-language-server",
      "cssmodules-language-server",

      "vim-language-server",
      "stylua",
      "typos-lsp",
      "markdownlint",

      "bash-language-server",
      "shellcheck",
      "shfmt",

      "emmet-language-server",
      "prettier",

      -- bash debugger
      "bash-debug-adapter",
      -- js and ts debugger
      "js-debug-adapter",
      -- go debugger - need both
      "delve",
      "go-debug-adapter",
    },
  },
}
