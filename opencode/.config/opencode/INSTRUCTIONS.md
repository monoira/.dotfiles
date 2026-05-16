# INSTRUCTIONS

## conventional commits

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

| branch name | description                | example                           |
| ----------- | -------------------------- | --------------------------------- |
| main        | Production-ready code      | main                              |
| develop     | Ongoing development branch | develop                           |
| feature/    | New feature                | feature/user-authentication       |
| refactor/   | Refactoring                | refactor/extract-common-functions |
| bugfix/     | Bug fix                    | bugfix/fix-header-styling         |
| hotfix/     | Critical bug fix in prod   | hotfix/security-patch             |
| docs/       | Documentation updates      | docs/update-readme                |
| release/    | Preparing for new version  | release/v2.0.1                    |

## todo-comments

- code comments should explain why, not what. save them for I/O, validation, and edge cases.
- first letter of code comment, after todo-comments prefix, should be lowercase.
- no em-dashes and no dot at the end.

use todo-comments convention for code comments:

- FIX: BUG:
- TODO:
- HACK:
- WARN:
- PERF: PERFORMANCE:
- NOTE: HINT: INFO:
- TEST: TESTING: PASSED: FAILED:

example:
`// PERF: using it this way is faster`

## code, git and testing

- **DO NOT** list out the files changed in a PR.
- **STOP and confirm** before committing, pushing, or creating/updating PRs. Do not assume prior approval continues to apply.
- minimize new dependencies unless necessary or agreed upon.
- install dependencies using the toolchain for the current project (e.g. npm i)
- don't cast things to circumvent type issues. fix them.
- avoid unit tests that simply test language functions or methods (e.g. testing that object spread works)
- PRs should follow this structure:
  - short opening sentence describing the fix/feature
  - explain the issue with concrete context
  - (optional) show real-world data or code demonstrating the problem
  - bullet points that show the major / material functional changes
  - code snippet showing the user-facing result (if applicable)
  - brief mention of (docs, tests, etc) as applicable
- when using nestjs, prefer built-in patterns (guards, pipes, interceptors) over custom middleware and use class-validator or Zod for validation (whichever is installed and used), not manual checks.

## general

- be blunt - agree or disagree directly.
- present options when prudent, but bring opinions - e.g. "recommend B because x, y, z."
- be concise and avoid long walls of text.
