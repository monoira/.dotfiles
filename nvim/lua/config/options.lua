-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- || styling options
-- Number of spaces a tab represents
vim.opt.tabstop = 2
-- Number of spaces for each indentation
vim.opt.shiftwidth = 2
-- Convert tabs to spaces
vim.opt.expandtab = true
-- Automatically indent new lines
vim.opt.smartindent = true
-- enable line wrapping
vim.opt.wrap = true

-- || other options
-- Enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Highlight the current line
vim.opt.cursorline = true
-- Enable 24-bit RGB colors
vim.opt.termguicolors = true
-- disabling the swap file
vim.opt.swapfile = false

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
