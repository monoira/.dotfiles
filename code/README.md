# MY VSCODE SETUP

- [MY VSCODE SETUP](#my-vscode-setup)
  - [DEPENDENCIES](#dependencies)
  - [KEYBINDINGS](#keybindings)
    - [fixes to VSCode](#fixes-to-vscode)
    - [QuickOpen, workspace switching and search](#quickopen-workspace-switching-and-search)
    - [editors / buffers](#editors--buffers)
    - [file explorer](#file-explorer)
    - [AI](#ai)
    - [GOTOs](#gotos)
    - [hover over code](#hover-over-code)
    - [warnings and diagnostics](#warnings-and-diagnostics)
    - [integrated terminal](#integrated-terminal)
    - [fold](#fold)
    - [code actions](#code-actions)

## DEPENDENCIES

`markdownlint`  
required for `markdownlint` extension.
install it or uninstall `markdownlint` extension.

`shfmt` and `shellcheck`  
required for `Bash IDE` extension.
install those or uninstall `Bash IDE` extension.

**NOTE:**
Due to how VSCode works, you must first open VSCode at least once for creation of `Code/User` directory.

## KEYBINDINGS

### fixes to VSCode

- `<leader>` is set to `space`.
- extension updates are disabled by default to reduce interruptions.
  You can update extensions by going to `extensions > check for extension updates`.

| Keybinding   | Feature                          |
| ------------ | -------------------------------- |
| `<leader> e` | Open file explorer (with focus)  |
| `ctrl alt b` | toggle bold (in markdown)        |
| `<C-d>`      | Scroll down half page and center |
| `<C-u>`      | Scroll up half page and center   |
| `ctrl n`     | Down (when given a dropdown)     |
| `ctrl p`     | Up (when given a dropdown)       |
| `ctrl h`     | Focus to left pane               |
| `ctrl l`     | Focus to right pane              |

### QuickOpen, workspace switching and search

| Keybinding                  | Feature                                 |
| --------------------------- | --------------------------------------- |
| `ctrl o`                    | QuickOpen file in a new tab             |
| `ctrl shift p`              | Open command palette                    |
| `<leader> f p`              | Open recent workspaces                  |
| `<leader> f p`+`ctrl enter` | Open recent workspaces in a new window  |
| `<leader> s s`              | Go to symbol in current file            |
| `<leader> s S`              | Go to symbol in a whole workspace       |
| `<leader> s d`              | Toggle problems panel                   |
| `<leader> s r`              | Search and replace                      |
| `<leader> /`                | Quick text search in a whole repository |

### editors / buffers

| Keybinding     | Feature                       |
| -------------- | ----------------------------- |
| `[ b`          | Previous editor               |
| `] b`          | Next editor                   |
| `[ B`          | Move editor left              |
| `] B`          | Move editor right             |
| `alt {NUMBER}` | Go to editor {NUMBER}         |
| `ctrl shift t` | Reopen recently closed editor |
| `ctrl w`       | Close current editor          |
| `<leader> b d` | Close current editor          |
| `<leader> b r` | Close editors to the right    |
| `<leader> b l` | Close editors to the left     |
| `<leader> b o` | Close all other editors       |

### file explorer

| Keybinding   | Feature                                          |
| ------------ | ------------------------------------------------ |
| `<leader> e` | Focus file explorer                              |
| `ctrl b`     | Close / open explorer (no focus, toggle)         |
| `ctrl d`     | Go all the way down (when focused)               |
| `ctrl u`     | Go all the way up (when focused)                 |
| `ctrl n`     | Go down one item (when focused)                  |
| `ctrl p`     | Go up one item (when focused)                    |
| `a`          | Create a new file                                |
| `f`          | Create a new directory                           |
| `d`          | Delete selected file/directory                   |
| `y`          | Copy selected file/directory                     |
| `p`          | Paste into selected directory                    |
| `x`          | Cut selected file/directory                      |
| `r`          | Rename selected file/directory                   |
| `o`          | Reveal file/directory in OS file manager         |
| `shift p`    | File preview                                     |
| `ctrl alt r` | Open containing folder of focused file/directory |

### AI

| Keybinding   | Feature                  |
| ------------ | ------------------------ |
| `ctrl i`     | Copilot inline chat `AI` |
| `ctrl alt i` | Copilot chat `AI`        |

### GOTOs

| Keybinding     | Feature               |
| -------------- | --------------------- |
| `g d`          | Go to definition      |
| `g D`          | Go to declaration     |
| `g f`          | Go to file            |
| `g i`          | Go to implementation  |
| `g r`          | Go to references      |
| `g h`          | Go to call hierarchy  |
| `g y`          | Go to type definition |
| `<leader> g g` | Focus source control  |

### hover over code

| Keybinding | Feature              |
| ---------- | -------------------- |
| `K`        | Show hover info      |
| `g K`      | Show parameter hints |

### warnings and diagnostics

| Keybinding | Feature             |
| ---------- | ------------------- |
| `] d`      | Next diagnostic     |
| `[ d`      | Previous diagnostic |
| `] e`      | Next error          |
| `[ e`      | Previous error      |
| `] w`      | Next warning        |
| `[ w`      | Previous warning    |

### integrated terminal

| Keybinding     | Feature                           |
| -------------- | --------------------------------- |
| `alt {NUMBER}` | go to terminal {NUMBER}           |
| `ctrl t`       | create new terminal               |
| `ctrl w`       | delete active terminal            |
| `ctrl i`       | Copilot inline terminal chat `AI` |

### fold

| Keybinding | Feature     |
| ---------- | ----------- |
| `za`       | toggle fold |
| `zR`       | unfold all  |
| `zc`       | fold        |
| `zo`       | open fold   |

### code actions

| Keybinding     | Feature               |
| -------------- | --------------------- |
| `<leader> c a` | Quick fix             |
| `<leader> c A` | Source action         |
| `<leader> c r` | Rename symbol         |
| `<leader> c p` | Preview markdown      |
| `<leader> c u` | Remove unused imports |

**Disclaimer**  
This project is purely a community-driven configuration setup and is not officially affiliated with or endorsed by Visual Studio Code (Microsoft), LazyVim, or any other commercial software vendor.
Use this configuration at your own risk. I make no guarantees regarding compatibility, stability, or fitness for any particular purpose.
