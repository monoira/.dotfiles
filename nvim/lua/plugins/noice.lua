-- this one hides hint box popups that annoy you while typing.
-- you can set auto_open to false to reduce annoyance.
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
