return {
  "ahmedkhalf/project.nvim",
  opts = {
    -- Manual mode doesn't automatically change your root directory, so you have
    -- the option to manually do so using `:ProjectRoot` command.
    manual_mode = false,

    -- Methods of detecting the root directory. **"lsp"** uses the native neovim
    -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
    -- order matters: if one is not detected, the other is used as fallback. You
    -- can also delete or rearangne the detection methods.
    detection_methods = { "pattern", "lsp" },

    -- All the patterns used to detect root dir, when **"pattern"** is in
    -- HACK: manual root detection - if you change something here,
    -- also change it in options.lua - vim.g.root_spec matters more
    patterns = {
      "_darcs",
      ".hg",
      ".bzr",
      ".svn",
      "Makefile",
      "Dockerfile",

      ".git",
      "package.json",
      ".prettierrc",
      ".prettierrc.json",
      ".eslintrc.cjs",
      "index.html",
    },

    ignore_lsp = {},
    exclude_dirs = {},
    show_hidden = true,
    silent_chdir = true,
    scope_chdir = "global",
    datapath = vim.fn.stdpath("data"),
  },
  event = "VeryLazy",
  config = function(_, opts)
    require("project_nvim").setup(opts)
    require("lazyvim.util").on_load("telescope.nvim", function()
      require("telescope").load_extension("projects")
    end)
  end,
  keys = {
    { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
  },
}