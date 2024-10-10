-- delay which-key popup by 1 second to reduce annoyance
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = { delay = 1000 },
}
