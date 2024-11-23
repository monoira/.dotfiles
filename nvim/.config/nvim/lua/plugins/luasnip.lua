return {
  "L3MON4D3/LuaSnip",
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
  require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" }),
}
