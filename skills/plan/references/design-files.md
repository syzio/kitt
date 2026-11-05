# Design files

Shapes for the files the plan writes besides `plan.md`. In Docs each one is a tab of the same name.

## research.md (Research tab)

```markdown
# Research: [FEATURE]

## D1: [Topic]

- **Decision**: [what was chosen]
- **Rationale**: [why]
- **Alternatives considered**: [what else was evaluated, and why not]
- **Status**: Leaning | Decided | Open | Research
```

- One block per unknown, dependency or integration. Number decisions D1, D2… and never renumber.
- Status is Leaning at most when Claude writes it. Decided only when the user says so.
- An irreversible or costly choice, such as a datastore, a public interface shape or a vendor, holds a concrete recommendation as Leaning until the user confirms it. Then it becomes Decided.
- Open lists the options. Copy every Open item, with its D- ID, into the plan's Risks and Open Questions.
- Research names the question and suggests the assess skill. Use it only when the options are close or the user wants a deep evaluation.

## data-model.md (Data Model tab)

```markdown
# Data Model: [FEATURE]

## [Entity]

| Field | Type | Required | Rules |
|-------|------|----------|-------|
| [email] | string | yes | [max 254 chars, unique, from FR-003] |

**Relationships**: [e.g., belongs to User; has many ResetTokens]

**State transitions**: [e.g., pending -> used | expired]
```

- Cite the FR- ID behind each validation rule.
- Draw a state diagram only when transitions branch.

## contracts/ (Contracts tab)

- Use the project's own format: an OpenAPI fragment for an HTTP API, a JSON Schema for events, a command and flag table for a CLI, signatures for a library's public API, a screen and state list for UI.
- In a repo, one file per interface: `contracts/<name>.yaml`, `.json` or `.md`.
- Cover inputs, outputs, error cases, and versioning or compatibility impact. Name the repo that owns the source of truth.
- Skip for purely internal work, and write one line saying why.

## quickstart.md (Quickstart tab)

```markdown
# Quickstart: [FEATURE]

## Prerequisites

[Tools, accounts, seed data]

## Setup

[Commands to get a working environment]

## Scenario 1: [maps to US1 acceptance scenario 1]

1. [Step or command]
2. **Expected**: [observable result]
```

- One scenario per P1 acceptance scenario at least. Add others as depth requires.
- Link to contracts and the data model. Don't repeat them.
- No implementation code: no model, service or controller bodies, migrations, or full test suites.
