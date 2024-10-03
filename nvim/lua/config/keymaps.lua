-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Panes
map("n", "<leader>w", "<c-w>", { desc = "Panes", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Pane Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Pane Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Pane", remap = true })
LazyVim.toggle.map("<leader>wm", LazyVim.toggle.maximize)
