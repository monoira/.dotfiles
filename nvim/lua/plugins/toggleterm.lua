return {
  {
    "akinsho/toggleterm.nvim",
    config = true,
    lazy = true,
    cmd = "ToggleTerm",
    keys = {
      {
        "<leader><C-\\>",
        "<cmd>:lcd %:h<cr>",
        "<cmd>ToggleTerm<cr>",
        desc = "Toggle terminal",
      },
    },
    opts = {
      open_mapping = "<leader><C-\\>",
      direction = "horizontal",
      size = 10,
    },
  },
}
