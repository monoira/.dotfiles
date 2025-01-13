require("config.lazy")

-- NOTE: DATABASES
-- ~/.config/nvim/lua/config/dbs.lua content example
-- vim.g.dbs = {
--   { name = "dev", url = "postgres://USERNAME:PASSWORD@HOST:PORT/DATABASE_NAME" },
-- }

-- imports dbs.lua if it exists
pcall(require, "config.dbs")
