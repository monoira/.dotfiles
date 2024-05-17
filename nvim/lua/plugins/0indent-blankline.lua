-- https://github.com/LazyVim/LazyVim/issues/3192
-- As mentioned in the above comment, the problem arises from the incompatibility of the Neovim version. So, waiting for a while should fix the issue. However, if you want to fix it temporarily, you can add the following line to your custom plugins to downgrade the version of the problem plugin.
return {
  "lukas-reineke/indent-blankline.nvim",
  event = "LazyFile",
  opts = { scope = { enabled = false } },
  -- HACK:
  version = "=3.5.4",
}
