-- keep cursor to center when using ctrl+d and ctrl+u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- paste without yank
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })
