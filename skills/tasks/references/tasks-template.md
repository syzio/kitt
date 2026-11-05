# Tasks template

## Task line format

```text
- [ ] T012 [P] [US1] api: Create the ResetToken model in src/models/reset_token.py
```

1. **Checkbox**: always `- [ ]` when written.
2. **Task ID**: T001, T002… in execution order, kept per "IDs and markers" in conventions.
3. **[P]**: only if the task touches different files from the tasks it runs alongside, and depends on no unfinished task.
4. **[US#]**: required in user story phases, absent in Setup, Foundational and Polish.
5. **Repo tag**: a repo name from the constitution's Constraints table, else from the plan's Repo Impact table, then a colon. Omit for single-repo features.
6. **Description**: a clear action with the exact file path.
7. **Markers**, in the order "IDs and markers" in conventions gives: `(depends on <IDs>)`, then `(open decision: <D-ID>)` when the task depends on a plan decision still marked Open or Research. Implement won't start the task until the decision is settled. The ticket-push skill adds `(ticket: <ID>)` last; never write or edit it here.

Correct:

- `- [ ] T001 Create project structure per the plan`
- `- [ ] T005 [P] Add the rate-limit middleware in src/middleware/rate_limit.py`
- `- [ ] T012 [P] [US1] api: Create the ResetToken model in src/models/reset_token.py`
- `- [ ] T014 [US1] api: Implement the reset service in src/services/password_reset.py (depends on T012)`
- `- [ ] T015 [US1] api: Send the reset email in src/services/reset_mailer.py (depends on T014) (open decision: D3)`

Wrong:

- `- [ ] Create ResetToken model` (no ID, no story label)
- `T001 [US1] Create model` (no checkbox)
- `- [ ] [US1] Create ResetToken model` (no ID)
- `- [ ] T001 [US1] Create model` (no file path)

## tasks.md

Replace `<repo>:` with the repo tag, or drop it for single-repo features. Replace the sample tasks with real ones.

```markdown
# Tasks: [FEATURE NAME]

**Input**: Design documents from `[feature folder]/`

**Prerequisites**: plan.md (required), spec.md (required), research.md, data-model.md, contracts/

**Tests**: [Included because <constitution principle / spec / user request>, or "Not requested"]

[Lead: total tasks, phases, MVP scope, e.g., "24 tasks in 5 phases. The MVP is Phase 3 (US1)."]

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [ ] T001 <repo>: Create project structure per the plan
- [ ] T002 [P] <repo>: Configure linting and formatting in [path]

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that must be complete before any user story

- [ ] T003 <repo>: Set up the database schema and migrations in [path]
- [ ] T004 [P] <repo>: Configure error handling and logging in [path]

**Checkpoint**: Foundation ready. User stories can start.

---

## Phase 3: User Story 1 - [Title] (Priority: P1) MVP

**Goal**: [What this story delivers]

**Independent Test**: [How to verify this story on its own]

### Tests for User Story 1 (only if tests are required)

Write these first and make sure they fail before implementing.

- [ ] T005 [P] [US1] <repo>: Contract test for [endpoint] in [path]
- [ ] T006 [P] [US1] <repo>: Integration test for [user journey] in [path]

### Implementation for User Story 1

- [ ] T007 [P] [US1] <repo>: Create [Entity] model in [path]
- [ ] T008 [US1] <repo>: Implement [Service] in [path] (depends on T007)
- [ ] T009 [US1] <repo>: Implement [endpoint/feature] in [path]

**Checkpoint**: User Story 1 works and can be tested on its own.

---

## Phase 4: User Story 2 - [Title] (Priority: P2)

[Same shape]

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect several user stories

- [ ] TXXX [P] <repo>: Documentation updates in [path]
- [ ] TXXX <repo>: Run the quickstart.md validation

---

## Dependencies & Execution Order

### Phase Dependencies

- Setup has no dependencies.
- Foundational depends on Setup and blocks all user stories.
- User stories depend on Foundational. They run in priority order, or in parallel once Foundational is done.
- Polish depends on the stories in scope.

### User Story Dependencies

- [e.g., US2 uses the token model from US1 but can be tested on its own]

### Within Each User Story

- Tests (if included) first, and failing.
- Models before services, services before endpoints, core before integration.

### Cross-Repo Order

[Multi-repo only. From the plan's Repo Impact table, e.g., "api before web before docs", with the task pairs that cross repos.]

### Parallel Opportunities

[Per story, the [P] tasks that can run together, by ID.]

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Setup and Foundational.
2. Complete User Story 1.
3. Stop and validate User Story 1 on its own.

### Incremental Delivery

Add one story at a time. Each story adds value without breaking the earlier ones.

## Notes

- Avoid vague tasks, two parallel tasks editing the same file, and cross-story dependencies that break independence.
```
