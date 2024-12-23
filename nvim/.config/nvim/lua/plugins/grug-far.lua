-- search and replace plugin
return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>sr",
      function()
        local grug = require("grug-far")
        local ignore_these =
          "!node_modules/ !dist/ !.next/ !.git/ !.gitlab/ !build/ !target/ !package-lock.json !pnpm-lock.yaml !yarn.lock"

        grug.open({
          transient = true,
          prefills = {
            search = "",
            replacement = "",
            filesFilter = ignore_these,
            flags = "",
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
}
