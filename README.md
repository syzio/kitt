# kitt

A personal Claude plugin for spec-driven development and writing. It works in claude.ai chat, where artifacts are Claude Docs, and in Claude Code, where they are files in the repository.

The name is a nod to KITT, the car that did the work and talked back.

## Skills

| Skill | What it does |
|---|---|
| `whoami` | Explains what kitt is, how the skills fit together, and which one to use next |
| `assess` | Researches an idea or a choice between options, with cited evidence for and against, and records a verdict |
| `constitution` | Writes and amends the project's checkable rules that every spec and plan must meet |
| `specify` | Writes a feature spec: prioritized user stories, FR- and SC- IDs, assumptions |
| `clarify` | Asks the questions that matter in short rounds, with a recommended answer for every question, and writes each answer into the spec or document. Its grill mode stress-tests a plan or idea until nothing is left open |
| `plan` | Writes the technical plan behind a constitution gate: decisions, data model, contracts, quickstart, repo impact |
| `tasks` | Breaks the plan into dependency-ordered tasks per user story, sliced per repository when needed |
| `checklist` | Writes requirement-quality checklists that test the spec, not the code |
| `analyze` | Read-only cross-check of spec, plan and tasks for gaps, conflicts and coverage |
| `implement` | Works through the tasks in a repository, phase by phase |
| `converge` | Compares the code with the spec and appends tasks for what is missing |
| `bug` | Assesses, fixes and verifies a bug report against the code |
| `ticket-push` | Pushes tasks to whatever tracker the session is connected to, and syncs status back |
| `blast-radius` | Finds what a change can break outside its diff, and runs code to prove the fact its safety depends on |
| `architect` | Sketches types, signatures and module structure before implementation |
| `tdd` | Writes a failing regression test before a bug fix, when a cheap test path exists |
| `unslop` | Removes AI tells from writing |
| `technical-writing` | A writing standard for docs, READMEs, RFCs, PR descriptions and commit messages |
| `in-your-own-words` | Restates the user's goal and problem before work starts |
| `sharpen` | Rewrites a task to be deeper, not bigger |
| `bro` | Restates the last reply in plain language |
| `refine` | Carries a mid-build spec change through plan and tasks, keeping IDs and ticks and marking replaced items superseded |
| `critique` | Adversarial, read-only review of spec and plan: premise, wrong or missing requirements, abuse, failure modes |
| `tinyspec` | One short file holding spec, plan and tasks for a small change |
| `how` | Explains how a part of the codebase works, with file:line evidence |
| `interrogate` | Adversarial review that keeps only findings proven by a run |
| `correct` | Turns a repeated mistake into a check that fails, so it can't recur |
| `verify` | Writes and maintains a project skill that drives the real app to prove the spec's acceptance scenarios |

`technical-writing`, `in-your-own-words`, `sharpen`, `bro` and `correct` run only when you call them, as `/kitt:<skill>`. Other skills can use `tdd` and `unslop` too.

In chat, ask in plain words ("spec out CSV export", "clarify the spec"). In Claude Code the skills also run as `/kitt:<skill>`. implement, converge, bug, blast-radius, architect, how, interrogate, correct and verify need a repository and say so in chat.

## Install

1. Run `scripts/build.sh`. It writes `dist/kitt-<version>.zip`.
2. Upload the zip to claude.ai. Claude Code picks the plugin up through sync, so don't install it there a second time.

To install in Claude Code without claude.ai, run `/plugin marketplace add syzio/kitt`, then `/plugin install kitt@syzio`.

## Maintain

- Edit shared rules only in `shared/`. `scripts/build.sh` copies them into each skill's `references/`, and `scripts/build.sh --check` fails if a copy is stale. Never edit the copies.
- Raise `version` in `.claude-plugin/plugin.json` on every change, then rebuild and upload.
- Don't add a top-level `bin/` folder. claude.ai refuses plugins that have one.

## License

MIT. See `LICENSE`. Third-party notices are in `NOTICE.md`.
