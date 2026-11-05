# Constitution template

Keep these headings, their order, and the version line format. Other skills find sections by them. The plan skill reads Core Principles for its Constitution Check, and the tasks skill reads the Constraints table for repo tags.

Replace every `[PLACEHOLDER]`. Delete a section's HTML comments once you fill it. When no candidates are left, remove the Candidates rows and keep the heading.

```markdown
# [PROJECT_NAME] Constitution

[One sentence: version and state, e.g. "Draft v0.1.0: the rules every spec, plan and task list for [PROJECT_NAME] is checked against. Nothing binds until it is ratified."]

## Ratification

<!-- One row per principle. In Docs, Status is a dropdown column: Draft, Ratified, Rejected. -->

| # | Principle | Source | Status |
|---|---|---|---|
| I | [PRINCIPLE_1_NAME] | [doc section, or "your words, YYYY-MM-DD"] | Draft |

## Core Principles

### I. [PRINCIPLE_1_NAME]

- [Subject] MUST [checkable rule].
- [Subject] SHOULD [checkable rule].

Why: [one line].

<!-- Example:
### II. Test-First
- Every user story MUST have an acceptance test that fails before implementation starts.
- Contract changes SHOULD ship with a contract test in the same change.
Why: a failing test is the only proof that the story is not done yet.
-->

<!-- Repeat for each principle. Five to nine in total. -->

## Candidates

<!-- Leaning items that would become principles if the user promotes them. In Docs, "Your call" is a dropdown column. -->

| Candidate | Rule if promoted | Source | Decision status | Your call |
|---|---|---|---|---|
| [name] | [rule in one or two sentences] | [doc section, the user's words, a repository file and section such as "CONTRIBUTING.md §Tests", or principles pool] | Leaning | Promote / Keep Leaning / Drop |

## Constraints

<!-- Facts that specs and plans must respect: repositories and what each owns, stack, deployment targets. The tasks skill uses this table for repo tags. A single-repository project has one row. -->

| Repository | Owns |
|---|---|
| [repo, e.g. api] | [what lives there, e.g. HTTP API, background jobs, database migrations] |
| [repo, e.g. web] | [e.g. browser app] |

[Other constraints, one bullet each, with their source.]

<!-- Optional: add extra sections here, after Constraints and before Development Workflow, only when needed. Examples: "## Security Standards", "## Performance Standards", "## Compliance Standards". Each standard uses MUST or SHOULD and names its source. Delete this comment if you add none. -->

## Development Workflow

<!-- How work moves from idea to code, and the gates: which features need full depth, what analyze must show before implementation starts, review requirements. -->

[DEVELOPMENT_WORKFLOW]

## Governance

- This constitution outranks other practices. A spec or plan that conflicts with a ratified principle changes, or the principle is amended first.
- Amendments bump the version per the constitution skill's versioning rules.
- Claude proposes. Only the user ratifies, rejects or promotes.
- Plans gate on principles per "What gates" in the kitt conventions.

**Version**: [CONSTITUTION_VERSION] | **Ratified**: [RATIFICATION_DATE or "pending"] | **Last Amended**: [LAST_AMENDED_DATE]

## Amendment Log

| Version | Date | Change | Specs affected |
|---|---|---|---|
| [x.y.z] | [YYYY-MM-DD] | [what changed] | [open specs, or "none"] |
```
