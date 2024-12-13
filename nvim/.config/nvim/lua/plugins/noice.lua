return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      -- NOTE: this configuration change hides auto ctrl+k hint box popups that annoy you while typing.
      signature = {
        auto_open = {
          enabled = false,
        },
      },
    },

    -- NOTE: Classic Cmdline
    cmdline = {
      view = "cmdline",
    },
  },
}
