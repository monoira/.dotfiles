-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("javascript", {
  s("clog", {
    t({ "console.log(" }),
    i(1),
    t({ ")" }),
  }),
  s("lobj", {
    t({ "console.log({" }),
    i(1),
    t({ "})" }),
  }),
})

return {}
