return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "emmet-language-server",
      "html-lsp",
      "css-lsp",
      "css-variables-language-server",
      "cssmodules-language-server",

      "vim-language-server",
      "stylua",
      "markdownlint",
      "marksman",
      "typos-lsp",
      "prettier",

      -- docker
      "hadolint",

      -- bash
      "bash-language-server",
      "shellcheck",
      "shfmt",
      -- bash debugger
      "bash-debug-adapter",

      -- go tools
      "goimports",
      "gofumpt",
      "gomodifytags",
      "impl",
      -- go debugger - need both
      "delve",
      "go-debug-adapter",

      -- js and ts debugger
      "js-debug-adapter",
    },
  },
}
