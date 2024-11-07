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
      "stylua",
      "markdownlint",
      "marksman",
      "typos-lsp",
      "prettier",

      -- || docker
      "hadolint",
      "docker-compose-language-service",
      "dockerfile-language-server",

      -- || bash
      "bash-language-server",
      "shfmt",
      "shellcheck",
      -- bash debugger
      "bash-debug-adapter",

      -- || go tools
      -- "goimports",
      -- "gofumpt",
      -- "gomodifytags",
      -- "impl",
      -- go debugger - need both? idk
      -- "delve",
      -- "go-debug-adapter",

      -- || js and ts debugger
      "js-debug-adapter",
    })
  end,
}
