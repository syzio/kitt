---
name: tasks
description: Breaks a feature's plan into a dependency-ordered task list, one phase per user story in priority order, with T-IDs, [P] parallel markers, [US#] story labels and repo tags, and checks that every requirement and acceptance scenario has a task. For multi-repo features it also writes one task slice per repository with cross-repo dependencies. Use when the user says "break it down", "create the tasks", "write tasks.md", "task list for this plan", "what do we build first", or "split the work per repo".
---

# Tasks

Read `references/conventions.md` and `references/writing.md` first.

Use `references/tasks-template.md` for the task list and `references/slices.md` for multi-repo slices.

## Outputs

- **Repository.** Write `tasks.md` in the feature folder. For a multi-repo feature, also write one slice per repo as `references/slices.md` describes.
- **Docs.** Write the Tasks tab of the feature doc. For a multi-repo feature, also add one tab per slice.
- **Neither.** Put the task list in the reply, per conventions.

## Steps

1. **Find the feature** per "Finding the feature" in conventions. You need the spec and the plan. If there is no plan, say so and offer the plan skill.

2. **Load context.**
   - From the spec, take the user stories with their priorities, the FR- IDs and the acceptance scenarios.
   - From the plan, take the tech stack, the project structure, the Repo Impact table, and every decision still marked Open or Research.
   - From the constitution, take the principles, the Constraints table with its repo names, and whether tests are required.
   - If they exist, read the data model for entities, the contracts for interfaces, research for decisions that need setup work, the quickstart for validation scenarios, and the architecture sketch for module boundaries and file paths.

3. **Choose the repo tags** per "Repo tag" in `references/tasks-template.md`.

4. **Decide on tests.** Write test tasks only when the spec, the constitution or the user asks for them, and name the source on the **Tests** line. Test tasks come first in each story and must fail before implementation starts.

5. **Build the phases.**
   - Phase 1 is Setup: project initialization and shared configuration.
   - Phase 2 is Foundational: work that blocks every story, such as the schema, auth, routing, base entities and error handling.
   - Phase 3 onward has one phase per user story, in priority order (P1, P2, P3). Each one has a Goal, an Independent Test, Tests if required, Implementation and a Checkpoint. Within a story, order the work as tests, models, services, endpoints, then integration.
   - The final phase is Polish & Cross-Cutting, and it includes a run of the quickstart. Consider validation and error handling, logging, security hardening, performance, extra unit tests and docs. Add a task for each only where the spec or the constitution calls for it.

6. **Map the design to tasks.**
   - Put each contract in the story it serves. When tests are required, add a contract test task [P] before its implementation.
   - Put each entity in the earliest story that needs it, or in Foundational if several stories share it.
   - When a data model field has constraints (max length, required, enum values, validation rules), quote them verbatim in the task description.
   - Turn research decisions that need setup work into Setup tasks.

7. **Write each task line** per "Task line format" in `references/tasks-template.md`, specific enough to do without asking.

8. **Write the dependency sections.** Cover the phase order, story dependencies, the cross-repo order from Repo Impact, parallel opportunities per story, and the MVP-first strategy, in which P1 alone can ship.

9. **Validate before writing.**
   - Every FR maps to at least one task.
   - Every acceptance scenario maps to at least one task.
   - Every story can be tested on its own.
   - No task refers to a file or component outside the plan's project structure. New files inside planned directories are fine.
   - Every line has the checkbox, the ID, the right labels, the repo tag when one applies, and a file path.
   - Add tasks to close any gap. If closing a gap would change the plan or the spec, list the gap and ask.

10. **Write the slices.** For a multi-repo feature, follow `references/slices.md`.

11. **Write and stop.** Put the counts in the lead line of tasks.md. Reply per conventions with the path or link, the total task count, the count per story, and the MVP scope. If any task carries an `(open decision: …)` marker, warn about it and name the decisions to settle first. Suggest the analyze skill as the next stage.

## Re-running

If tasks.md exists, keep its IDs per "IDs and markers" in conventions, and give each new task the next free ID. Keep ticked checkboxes, and keep the `(ticket: <ID>)` markers at line ends. Drop an `(open decision: …)` marker once the plan settles that decision.
