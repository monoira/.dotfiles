-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- https://medium.com/usevim/changing-vims-title-713001d4049c
-- https://www.imaginaryrobots.net/posts/2021-04-17-converting-vimrc-to-lua/

vim.opt.title = true
vim.opt.titlestring = "%-25.55F %a%r%m"
vim.opt.titlelen = 70
