-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- https://medium.com/usevim/changing-vims-title-713001d4049c
-- https://www.imaginaryrobots.net/posts/2021-04-17-converting-vimrc-to-lua/

vim.opt.title = true
vim.opt.titlestring = "%-25.55F %a%r%m"
vim.opt.titlelen = 70

-- HACK: needed for wsl2 clipboard to work on windows
local clip = "/mnt/c/Windows/System32/clip.exe" -- Change this path if needed

if vim.fn.executable(clip) then
  local opts = {
    callback = function()
      if vim.v.event.operator ~= "y" then
        return
      end
      vim.fn.system(clip, vim.fn.getreg(0))
    end,
  }

  opts.group = vim.api.nvim_create_augroup("WSLYank", {})
  vim.api.nvim_create_autocmd(
    "TextYankPost",
    { group = opts.group, callback = opts.callback }
  )
end
