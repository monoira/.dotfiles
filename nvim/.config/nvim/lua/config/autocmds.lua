-- HACK: this disables stupid "No information available" notification on every hover
-- e.g: shift+k on Typescript code
-- THIS NEEDS snacks.notifier!!!
local banned_messages = { "No information available" }
vim.notify = function(msg, ...)
  for _, banned in ipairs(banned_messages) do
    if msg == banned then
      return
    end
  end
  return require("snacks.notifier")(msg, ...)
end
