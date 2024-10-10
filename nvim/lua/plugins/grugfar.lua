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
        local ignoreThosePaths = "!node_modules !dist !.eslintcache !*json !*mock* !*mdx !*stories* !*test*"

        grug.open({
          transient = true,
          prefills = {
            search = "",
            replacement = "",
            filesFilter = ignoreThosePaths,
            flags = "",
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
}
