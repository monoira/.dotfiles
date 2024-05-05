return {
  {
    "akinsho/toggleterm.nvim",
    config = true,
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
      shade_filetypes = {},
      hide_numbers = true,
      insert_mappings = true,
      terminal_mappings = true,
      start_in_insert = true,
      close_on_exit = true,
    },
  },
}
