-- Options are automatically loaded before lazy.nvim startup Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- || styling options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.showtabline = 2
vim.opt.numberwidth = 2
vim.opt.softtabstop = 2

vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.cindent = true

-- enable line wrapping
vim.opt.wrap = true

-- || other options
vim.opt.undofile = true
vim.o.undodir = "/tmp/.vim/.undodir"

-- disabling the swap file
vim.opt.swapfile = false

-- highlight the current line
vim.opt.cursorline = true

-- enable 24-bit RGB colors
vim.opt.termguicolors = true

-- HACK: manual root detection - if you change something here, also change it in project.nvim
vim.g.root_spec = {
  {
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
  },
  "cwd",
  "lsp",
}
