require("config.lazy")

local notifier = require("snacks.notifier")

local ok, err = pcall(require, "config.dbs")
-- if not ok then
--   notifier(
--     "You forgot to create dbs.lua file at \n ~/.config/nvim/lua/config/dbs.lua \n READ monoira/.dotfiles documentation"
--   )
-- end

-- NOTE: for databases, create dbs.lua file at
-- ~/.config/nvim/lua/config/dbs.lua
-- example of it's content:

-- vim.g.dbs = {
--   { name = "dev", url = "postgres://USERNAME:PASSWORD@HOST:PORT/DATABASE_NAME" },
-- }
