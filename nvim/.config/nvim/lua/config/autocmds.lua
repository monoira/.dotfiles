-- HACK: this disables certain notifications like
-- e.g: shift+k on typescript / tsx code says
-- "No information available" notification on every hover.
-- using snacks.notifier for notifications.
local notifier = require("snacks.notifier")

local banned_messages = { "No information available", "^# Conversion failed.*" }

local function is_banned_message(msg)
  for _, banned in ipairs(banned_messages) do
    if string.match(msg, banned) then
      return true
    end
  end
  return false
end

vim.notify = function(msg, ...)
  if not is_banned_message(msg) then
    notifier(msg, ...)
  end
end
