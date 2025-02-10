-- || vim.opt options
-- styling
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

-- disabling the swap file
vim.opt.swapfile = false

-- highlight the current line
vim.opt.cursorline = true

-- enable 24-bit RGB colors
vim.opt.termguicolors = true

-- || other options
vim.opt.undofile = true
vim.o.undodir = "/tmp/.vim/.undodir"

-- show mode on : command line
vim.o.showmode = true
