---
description: global context
applyTo: "**"
---

# AGENTS.md

- present options when prudent, but bring opinions - e.g. recommend B because x, y, z
- be concise, agree or disagree directly and avoid long walls of text
- prefer conventional solutions over clever or heavy abstractions
- prefer KISS and YAGNI engineering principles over DRY
- code comments should explain why, not what. save them for I/O, validation, and edge cases
- the first letter of a code comment you write should be lowercase
- no em-dashes, trailing periods or emojis
- minimize new dependencies unless necessary or agreed upon
- don't cast things to circumvent Typescript type issues, fix them.
  Use Web Search if you don't know how to fix that type issue
- avoid unit tests that simply test language functions or methods (e.g. testing that object spread works)
- don't write any tests unless explicitly told
- **STOP and confirm** before committing, pushing, or creating/updating PRs. Do not assume prior approval continues to apply

## conventional commits for commit messages

| abbr        | description                              |
| ----------- | ---------------------------------------- |
| `feat:`     | introduce new feature                    |
| `fix:`      | fix a bug                                |
| `docs:`     | update documentation                     |
| `refactor:` | refactor code without changing behavior  |
| `chore:`    | maintenance tasks and dependency updates |
| `test:`     | add or update tests                      |
| `build:`    | update build system or dependencies      |
| `ci:`       | modify CI/CD configuration               |
| `perf:`     | optimize performance                     |
| `revert:`   | undo previous commit                     |
| `style:`    | adjust code style (formatting, linting)  |

### examples

`feat: extend config support`

`feat(api): send shipment email`

add ! to the commit type for breaking changes

`fix!: remove api.get_user`

`<type>(<scope>)!: <description>`

## git branch names

| name      | description                | example                           |
| --------- | -------------------------- | --------------------------------- |
| main      | production-ready code      | main                              |
| develop   | ongoing development branch | develop                           |
| feature/  | new feature                | feature/auth                      |
| refactor/ | refactoring                | refactor/extract-common-functions |
| bugfix/   | bug fix                    | bugfix/fix-header-styling         |
| hotfix/   | critical bug fix in prod   | hotfix/security-patch             |
| docs/     | documentation updates      | docs/update-readme                |
| release/  | preparing for new version  | release/v2.0.1                    |
