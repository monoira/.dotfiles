-- basic UI options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.hlsearch = false

-- system clipboard integration
vim.opt.clipboard = "unnamedplus"

-- set space as leader
vim.g.mapleader = " "

-- keymaps
local opts = { noremap = true, silent = true }

-- yank to clipboard with leader + y
vim.api.nvim_set_keymap("v", "<Leader>y", [["+y]], opts) -- visual mode yank to system clipboard
vim.api.nvim_set_keymap("n", "<Leader>y", [["+y]], opts) -- normal mode yank to system clipboard

-- paste from system clipboard
vim.api.nvim_set_keymap("n", "<Leader>p", [["+p]], opts)

-- move line/block down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- move line/block up
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- keep cursor centered after half-page scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
