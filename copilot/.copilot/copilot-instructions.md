---
description: global context
applyTo: "**"
---

# AGENTS.md

- present options when prudent, but bring opinions - e.g. recommend B because x, y, z
- be concise and pragmatic, agree or disagree directly and avoid long walls of text
- prefer KISS and YAGNI engineering principles over DRY, prefer conventional solutions and use OOP and SOLID principles when appropriate
- code comments should explain why, not what. save them for I/O, validation, and edge cases
- the first letter of a code comment YOU write should be lowercase, though don't correct already uppercase comments unless explicitly told
- minimize new dependencies unless necessary or agreed upon
- don't cast things to circumvent type issues, fix them.
  Use websearch if you don't know how to fix that type issue
- A question is a request for an answer, not for changes. If the message opens with "how", "what are", "why does", "should we", "is it possible", "can we do X", "so will", "will this" and such, then answer it instead of editing files
- always output reports of following subagents **verbatim** without summarization: "architect-designer", "QA-tester-playwright"

## text quality

- no em-dashes, trailing periods or emojis
- No trailing "-ing" phrases that add no fact ("highlighting...", "ensuring...").
- No vague attributions ("experts believe"). Name the source or delete.
- No AI vocabulary: additionally, crucial, delve, enhance, foster, landscape, pivotal, showcase, testament, underscore, vibrant.
- Say "is" or "has", not "serves as", "stands as", "boasts", "features".
- No "not just X, but Y". State the point.
- Don't force ideas into threes.
- One name per thing. Repeat it.
- No "from X to Y" unless X and Y sit on a real scale.
- No em dashes, en dashes, or hyphens used as dashes, and no parentheses in their place. Use a period or a comma.
- A colon goes before a list or an example, never mid-sentence as a connector.
- Don't bold every proper noun or acronym.
- No bold label and colon that restates its line ("**Performance:** Performance improved..."). A bold lead-in that ends in a period and adds new detail is fine.
- Sentence case headings.
- No decorative emojis.
- Straight quotes.
- No chatbot phrases ("I hope this helps!", "Let me know if...").
- No praise or agreement openers. Respond directly.
- Cut filler. "In order to" becomes "to". Delete "it is important to note that".
- One hedge at most: "may".
- No generic conclusions. State specific plans or facts.
- No abstract metaphor nouns: substrate, wedge, vector, nexus, primitive, harness, surface, scaffolding, paradigm, ratchet, north star, flywheel. Use the concrete word.
- Say what it does, not how it feels. Name the mechanism or the number. Cut a sentence that could appear unchanged in another project's docs.
- One idea per sentence. Split a sentence the reader has to reread.
- Active voice. Name the actor unless it is unknown or doesn't matter.
- Cut adverbs or use a stronger verb. Give the number.
- Use the plain word: "use", not "utilize" or "leverage".
- No metaphor, aphorism, personified code, or figurative verb where a literal phrase exists.
- Write whole sentences with their articles and verbs. Spell out arrows and abbreviations.

## testing

- avoid unit tests that simply test language functions or methods (e.g. testing that object spread works)
- don't write any tests unless explicitly told

## git and Github

- use git and gh CLIs
- **STOP and confirm** before committing, pushing, or creating/updating PRs. Do not assume prior approval continues to apply

### conventional commits for commit messages

| commit type | description                              |
| ----------- | ---------------------------------------- |
| feat:       | introduce new feature                    |
| fix:        | fix a bug                                |
| docs:       | update documentation                     |
| refactor:   | refactor code without changing behavior  |
| chore:      | maintenance tasks and dependency updates |
| test:       | add or update tests                      |
| build:      | update build system or dependencies      |
| ci:         | modify CI/CD configuration               |
| perf:       | optimize performance                     |
| revert:     | undo previous commit                     |
| style:      | adjust code style (formatting, linting)  |

examples

`feat: extend config support`

`feat(api): send shipment email`

add ! to the commit type for breaking changes

`fix!: remove api.get_user`

`<type>(<scope>)!: <description>`

### git branch names

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
