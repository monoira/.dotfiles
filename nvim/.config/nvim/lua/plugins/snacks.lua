vim.g.snacks_animate = false

local excluded = {
  "node_modules/",
  "dist/",
  ".next/",
  ".vite/",
  ".git/",
  ".gitlab/",
  "build/",
  "target/",
  "dadbod_ui/tmp/",
  "dadbod_ui/dev/",

  "package-lock.json",
  "pnpm-lock.yaml",
  "yarn.lock",
}

local root_patterns = {
  -- directories
  "client",
  "server",

  -- version control systems
  "_darcs",
  ".hg",
  ".bzr",
  ".svn",
  ".git",

  -- build tools
  "Makefile",
  "CMakeLists.txt",
  "build.gradle",
  "build.gradle.kts",
  "pom.xml",
  "build.xml",

  -- node.js and javascript
  "package.json",
  "package-lock.json",
  "yarn.lock",
  ".nvmrc",
  "gulpfile.js",
  "Gruntfile.js",

  -- python
  "requirements.txt",
  "Pipfile",
  "pyproject.toml",
  "setup.py",
  "tox.ini",

  -- rust
  "Cargo.toml",

  -- go
  "go.mod",

  -- elixir
  "mix.exs",

  -- configuration files
  ".prettierrc",
  ".prettierrc.json",
  ".prettierrc.yaml",
  ".prettierrc.yml",
  ".eslintrc",
  ".eslintrc.json",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintignore",
  ".stylelintrc",
  ".stylelintrc.json",
  ".stylelintrc.yaml",
  ".stylelintrc.yml",
  ".editorconfig",
  ".gitignore",

  -- html projects
  "index.html",

  -- miscellaneous
  "README.md",
  "README.rst",
  "LICENSE",
  "Vagrantfile",
  "Procfile",
  ".env",
  ".env.example",
  "config.yaml",
  "config.yml",
  ".terraform",
  "terraform.tfstate",
  ".kitchen.yml",
  "Berksfile",
}
vim.g.root_spec = { root_patterns, "lsp", "cwd" }

return {
  "folke/snacks.nvim",
  opts = {
    -- need notifier for disabling "No notifications available"
    notifier = { enabled = true },

    image = { enabled = true },

    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          include = excluded,

          layout = {
            layout = { position = "right" },
          },
        },
        projects = {
          dev = {
            "~/.dotfiles",

            "~/dev",
            "~/dev/general",
            "~/dev/projects",
            "~/dev/general/LARGE_PROJECTS",
            "~/dev/general/NEW_PROJECTS",
            "~/dev/general/OLD_PROJECTS",
            "~/dev/general/TO_DO_PROJECTS",
          },
          patterns = root_patterns,
          -- <leader>fp will always open picker_files
          confirm = "picker_files",
        },
        files = {
          hidden = true,
          ignored = true,
          exclude = excluded,
        },
        -- HACK: https://github.com/folke/snacks.nvim/discussions/1581
        -- check later if better solution appears to filter
        -- out excluded directories & files inside excluded directories
        recent = {
          filter = {
            filter = function(item)
              local function is_excluded(file)
                for _, pattern in ipairs(excluded) do
                  if string.match(file, pattern) then
                    return true
                  end
                end
                return false
              end

              return not is_excluded(item.file)
            end,
          },
        },
      },
      -- show hidden files like .env
      hidden = true,
      -- show files ignored by git like node_modules
      ignored = true,

      exclude = excluded,
    },

    dashboard = {
      preset = {
        header = [[
       ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆             
        ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦          
              ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄        
               ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄       
              ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀      
       ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄     
      ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄      
     ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄     
     ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄    
          ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆        
           ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃        
]],
        keys = {
          {
            icon = " ",
            key = "s",
            desc = "Restore Session",
            action = ':lua require("persistence").load({ last = true })',
          },
          {
            icon = "󰒲 ",
            key = "<leader>l",
            desc = "Lazy",
            action = ":Lazy",
          },
        },
      },
    },
  },
}
