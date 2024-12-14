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

      hover = {
        -- NOTE: this disables stupid "No information available" notification on every hover
        -- ex: shift+k on Typescript code
        silent = true,
      },
    },

    -- NOTE: classic cmdline
    cmdline = {
      view = "cmdline",
    },
  },
}
