# AGENTS

- present options when prudent, but bring opinions - e.g. recommend B because x, y, z
- be concise, agree or disagree directly and avoid long walls of text
- code comments should explain why, not what. save them for I/O, validation, and edge cases
- first letter of code comment should be lowercase
- no em-dashes or trailing periods

## conventional commits for commit messages

| abbr        | description                              |
| ----------- | ---------------------------------------- |
| `feat:`     | Introduce new feature                    |
| `fix:`      | Fix a bug                                |
| `docs:`     | Update documentation                     |
| `refactor:` | Refactor code without changing behavior  |
| `chore:`    | Maintenance tasks and dependency updates |
| `test:`     | Add or update tests                      |
| `build:`    | Update build system or dependencies      |
| `ci:`       | Modify CI/CD configuration               |
| `perf:`     | Optimize performance                     |
| `revert:`   | Undo previous commit                     |
| `style:`    | Adjust code style (formatting, linting)  |

examples:
`feat: allow provided config object to extend other configs`
`feat(api): send an email to the customer when a product is shipped`

add ! to abbr when committing breaking change:
`fix!: removed api.get_user in index.js`

## git branch names

| name      | description                | example                           |
| --------- | -------------------------- | --------------------------------- |
| main      | Production-ready code      | main                              |
| develop   | Ongoing development branch | develop                           |
| feature/  | New feature                | feature/user-authentication       |
| refactor/ | Refactoring                | refactor/extract-common-functions |
| bugfix/   | Bug fix                    | bugfix/fix-header-styling         |
| hotfix/   | Critical bug fix in prod   | hotfix/security-patch             |
| docs/     | Documentation updates      | docs/update-readme                |
| release/  | Preparing for new version  | release/v2.0.1                    |

## code, git and testing

- **STOP and confirm** before committing, pushing, or creating/updating PRs. Do not assume prior approval continues to apply
- avoid unit tests that simply test language functions or methods (e.g. testing that object spread works)
- minimize new dependencies unless necessary or agreed upon
- don't cast things to circumvent type issues. fix them
