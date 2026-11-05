# Plan template

Write `plan.md` (or the Plan tab) in this shape. Keep the headings. Delete guidance lines in angle brackets once filled. Fill Complexity Tracking only when the Constitution Check has a justified violation. Include Repo Impact only for multi-repo features.

```markdown
# Implementation Plan: [FEATURE]

**Feature**: `[###-feature-name]` | **Date**: [DATE] | **Spec**: [link]

**Input**: Feature specification from `[feature folder, e.g. specs/###-feature-name]/spec.md`

## Summary

[Primary requirement from the spec, and the technical approach from research]

## Technical Context

**Language/Version**: [e.g., Python 3.12, TypeScript 5.6, Go 1.23 or NEEDS CLARIFICATION]

**Primary Dependencies**: [e.g., FastAPI, React, Cobra or NEEDS CLARIFICATION]

**Storage**: [if applicable, e.g., PostgreSQL, SQLite, files or N/A]

**Testing**: [e.g., pytest, Vitest, go test or NEEDS CLARIFICATION]

**Target Platform**: [e.g., Linux server, modern browsers, iOS 17+ or NEEDS CLARIFICATION]

**Project Type**: [e.g., library, cli, web-service, web-app, mobile-app or NEEDS CLARIFICATION]

**Performance Goals**: [domain-specific, e.g., 500 req/s, export of 100k rows under 10 s or NEEDS CLARIFICATION]

**Constraints**: [domain-specific, e.g., p95 under 200 ms, works offline or NEEDS CLARIFICATION]

**Scale/Scope**: [domain-specific, e.g., 10k users, 20 screens or NEEDS CLARIFICATION]

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design. Only Ratified principles block. Draft rows are advisory.*

| Principle | Status | Before design | After design | Note |
|-----------|--------|---------------|--------------|------|
| [I. Name] | Ratified | pass / violation | pass / violation | [plan change made, or see Complexity Tracking] |
| [II. Name] | Draft (advisory) | pass / violation | pass / violation | [what would block once ratified] |

## Project Structure

### Documentation (this feature)

```text
[feature folder]/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
└── tasks.md          # written by the tasks skill
```

### Source Code (repository root)

```text
[The real directories this feature touches, e.g.:
src/
├── models/
├── services/
└── api/
tests/
├── contract/
├── integration/
└── unit/]
```

**Structure Decision**: [The chosen layout and the real directories above]

## Repo Impact

| Repository | Changes | Order | Depends on |
|------------|---------|-------|------------|
| [api] | [new endpoint and schema] | 1 | none |
| [web] | [settings screen] | 2 | api |

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., a second datastore] | [current need] | [why the existing one is not enough] |

## Risks and Open Questions

- [Risk, or NEEDS CLARIFICATION carried from the spec, with what would resolve it]
- [D3 (Open): the question, the options, and what would resolve it]
```
