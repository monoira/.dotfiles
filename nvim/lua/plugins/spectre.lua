-- NOTE: plugin that finds and replaces texts
local path = "!node_modules !dist !.eslintcache !*json !*mock* !*mdx !*stories* !*test*"
return {
  "nvim-pack/nvim-spectre",
  build = false,
  cmd = "Spectre",
  opts = {
    open_cmd = "noswapfile vnew",
  },
  -- stylua: ignore
  keys = {
    {
      "<leader>sR",
      function()
        require("spectre").open_visual({ select_word = true, path = path })
      end,
      desc = "Replace current word in files (Spectre)",
    },
    {
      "<leader>sr",
      function()
        require("spectre").open_visual({ path = path })
      end,
      desc = "Replace in files (Spectre)",
    },
    {
      "<leader>sP",
      function()
        require("spectre").open_file_search({ select_word = true })
      end,
      desc = "Replace current word in current file (Spectre)",
    },
    {
      "<leader>sp",
      function()
        require("spectre").open_file_search()
      end,
      desc = "Replace in current file (Spectre)",
    },
  },
}
