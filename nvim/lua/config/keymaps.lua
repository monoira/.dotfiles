-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set({ "n" }, "<C-k>", function()
--   require("lsp_signature").toggle_float_win()
-- end, { silent = true, noremap = true, desc = "toggle signature" })

-- https://www.lazyvim.org/configuration/general#keymaps
local map = vim.keymap.set
-- Use alt for mac instead of ctrl
map("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map({ "n", "v" }, "c", '"_c', { noremap = true, desc = "Change without moving the change to a register" })
map({ "n", "v" }, "C", '"_C', { noremap = true, desc = "Change without moving the change to a register" })
