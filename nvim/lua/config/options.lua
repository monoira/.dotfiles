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

-- Highlight the current line
vim.opt.cursorline = true

-- Enable 24-bit RGB colors
vim.opt.termguicolors = true

-- HACK: manual root detection - if you change something here, also change it in project.nvim
vim.g.root_spec = {
  {
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
  "cwd",
  "lsp",
}
