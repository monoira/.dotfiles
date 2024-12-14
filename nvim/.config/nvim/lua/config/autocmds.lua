-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- HACK: this disables stupid "No information available" notification on every hover
-- ex: shift+k on Typescript code
local banned_messages = { "No information available" }
vim.notify = function(msg, ...)
  for _, banned in ipairs(banned_messages) do
    if msg == banned then
      return
    end
  end
  return msg, ...
end
