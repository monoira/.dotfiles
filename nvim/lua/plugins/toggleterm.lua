-- return {
--   {
--     "akinsho/toggleterm.nvim",
--     config = true,
--     lazy = true,
--     cmd = "ToggleTerm",
--     keys = {
--       {
--         "<leader>\\",
--         "<cmd>:lcd %:h<cr>",
--         "<cmd>ToggleTerm<cr>",
--         desc = "Toggle terminal",
--       },
--     },
--     opts = {
--       open_mapping = "<leader>\\",
--       direction = "horizontal",
--       size = 10,
--     },
--   },
-- }

return {
  {
    "akinsho/toggleterm.nvim",
    config = true,
    lazy = true,
    cmd = "ToggleTerm",
    keys = {
      {
        [[<C-\>]],
        "<cmd>:lcd %:h<cr>",
        "<cmd>ToggleTerm<cr>",
        desc = "Toggle terminal",
      },
    },
    opts = {
      open_mapping = [[<C-\>]],
      direction = "horizontal",
      size = 10,
    },
  },
}
