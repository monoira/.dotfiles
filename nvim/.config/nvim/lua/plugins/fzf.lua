return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    file_ignore_patterns = {
      "node_modules/",
      "dist/",
      ".next/",
      ".git/",
      ".gitlab/",
      "build/",
      "target/",
      "dadbod_ui/tmp/",
      "dadbod_ui/dev/",

      "package-lock.json",
      "pnpm-lock.yaml",
      "yarn.lock",
    },
  },
}
