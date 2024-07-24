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
        local myPath = "!node_modules !dist !.eslintcache !*json !*mock* !*mdx !*stories* !*test*"

        grug.grug_far({
          transient = true,
          prefills = {
            search = "",
            replacement = "",
            filesFilter = myPath,
            flags = "",
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
}
