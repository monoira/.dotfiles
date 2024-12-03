return {
  "ibhagwan/fzf-lua",
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
      file_ignore_patterns = {
        "node_modules/",
        "dist/",
        ".next",
        ".git/",
        ".gitlab/",
        "build/",
        "target/",
        "yarn.lock",
        "package-lock.json",
      },
    })
  end,
}
