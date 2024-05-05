-- https://www.lazyvim.org/extras/lang/typescript#nvim-lspconfig
return {
  "neovim/nvim-lspconfig",
  opts = {
    -- https://github.com/typescript-language-server/typescript-language-server/issues/257#issuecomment-1825582878
    -- disable tsserver as a formatter
    format = {
      filter = function(client)
        return client.name ~= "tsserver"
      end,
    },
    -- make sure mason installs the server
    servers = {
      ---@type lspconfig.options.tsserver
      tsserver = {
        keys = {
          {
            "<leader>co",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.organizeImports.ts" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Organize Imports",
          },
          {
            "<leader>cR",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.removeUnused.ts" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Remove Unused Imports",
          },
        },
        ---@diagnostic disable-next-line: missing-fields
        settings = {
          completions = {
            completeFunctionCalls = true,
          },
        },
      },
    },
  },
}
