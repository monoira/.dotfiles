return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",

  require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/my_snippets" }),
}
