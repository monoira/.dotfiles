-- this configuration change hides auto ctrl+k hint box popups that annoy you while typing.
return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      signature = {
        auto_open = {
          enabled = false,
        },
      },
    },
  },
}
