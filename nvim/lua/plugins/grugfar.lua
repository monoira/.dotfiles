-- search and replace plugin
return {
  "MagicDuck/grug-far.nvim",
  opts = { headerMaxWidth = 80 },
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      function()
        local grug = require("grug-far")
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        grug.grug_far({
          transient = true,
          prefills = {
            search = "",
            replacement = "",
            filesFilter = "!node_modules !dist !.eslintcache !*json !*mock* !*mdx !*stories* !*test*",
            flags = "",
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
}
