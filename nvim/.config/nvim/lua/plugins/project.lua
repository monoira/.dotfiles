local project_patterns = {
  -- Version Control Systems
  "_darcs",
  ".hg",
  ".bzr",
  ".svn",
  ".git",

  -- Build Tools
  "Makefile",
  "CMakeLists.txt",
  "build.gradle",
  "build.gradle.kts",
  "pom.xml",
  "build.xml",

  -- Docker
  "Dockerfile",
  "docker-compose.yml",

  -- Node.js and JavaScript
  "package.json",
  "package-lock.json",
  "yarn.lock",
  ".nvmrc",
  "gulpfile.js",
  "Gruntfile.js",

  -- Python
  "requirements.txt",
  "Pipfile",
  "pyproject.toml",
  "setup.py",
  "tox.ini",

  -- Rust
  "Cargo.toml",

  -- Go
  "go.mod",

  -- Elixir
  "mix.exs",

  -- Configuration Files
  ".prettierrc",
  ".prettierrc.json",
  ".prettierrc.yaml",
  ".prettierrc.yml",
  ".eslintrc",
  ".eslintrc.json",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintignore",
  ".stylelintrc",
  ".stylelintrc.json",
  ".stylelintrc.yaml",
  ".stylelintrc.yml",
  ".editorconfig",
  ".gitignore",

  -- HTML Projects
  "index.html",

  -- Miscellaneous
  "README.md",
  "README.rst",
  "LICENSE",
  "Vagrantfile",
  "Procfile",
  ".env",
  ".env.example",
  "config.yaml",
  "config.yml",
  ".terraform",
  "terraform.tfstate",
  ".kitchen.yml",
  "Berksfile",
}

vim.g.root_spec = { project_patterns, "cwd", "lsp" }

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
    patterns = project_patterns,

    ignore_lsp = {},
    exclude_dirs = {},
    show_hidden = true,
    silent_chdir = true,
    scope_chdir = "global",
    datapath = vim.fn.stdpath("data"),
  },
}
