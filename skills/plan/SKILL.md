---
name: plan
description: Turns an approved feature spec into a technical plan behind the project constitution's gate. Fills the technical context, records decisions with rationale, alternatives and status, and designs the data model, interface contracts, a runnable quickstart and, for multi-repo features, a repo impact table. Use when the user says "plan this", "plan the feature", "how do we build it", "design the implementation", "write the technical plan", or wants research, a data model or contracts for a spec.
---

# Plan

Read `references/conventions.md` and `references/writing.md` first.

Use `references/plan-template.md` for the plan and `references/design-files.md` for research, the data model, contracts and the quickstart.

## Outputs

- **Repository.** Write `plan.md`, `research.md`, `data-model.md`, `contracts/` and `quickstart.md` as separate files in the feature folder.
- **Docs.** Write the Plan, Research, Data Model, Contracts and Quickstart tabs of the feature doc. Add any tab that is missing.
- **Neither.** Put all five in the reply, per conventions.

## Steps

1. **Find the feature** per conventions. If there is no spec, say so and offer the specify skill. For a feature that handles money, credentials, personal data or permissions, suggest the critique skill before planning.

2. **Check preconditions.** The spec must have no `[NEEDS CLARIFICATION]` markers.
   - If markers remain, list them and suggest the clarify skill.
   - Continue only if the user accepts the rework risk. Then copy each marker into the plan's Risks and Open Questions section.

3. **Load context.** Read the spec, the constitution (found per conventions), and any decisions or assessments the spec links to. In a repo, also read the existing code layout. For unfamiliar code the plan touches, you may run the how skill first to explain it with `file:line` evidence.

4. **Fill Technical Context.** Cover language and version, primary dependencies, storage, testing, target platform, project type, performance goals, constraints, and scale and scope.
   - Write every unknown as `NEEDS CLARIFICATION`. Never guess silently.
   - Write N/A for a line that doesn't apply.

5. **Run the constitution gate before research.** Mark each Ratified and Draft principle pass or violation in the same table. Mark each Draft row "advisory".
   - Per "What gates" in conventions, a Ratified violation either changes the plan or goes in Complexity Tracking, with why it is needed and the simpler alternative you rejected. An unjustified one stops the plan. Show it to the user and wait.
   - Note a Draft violation in its row and in the reply. If every principle is still Draft, say the gate passes with advisory rows only.
   - Flag Leaning candidates that the plan would make hard to change.
   - If there is no constitution, follow conventions: say so once and offer to draft one.

6. **Research (Phase 0).** Write research.md with one item per unknown in Technical Context, one per new dependency (best practices), and one per integration (patterns).
   - Research independent unknowns in parallel read-only subagents per "Subagents" in conventions, and merge their findings into research.md yourself.
   - Write each item, its status, and the handling of costly, Open and Research items per `references/design-files.md`. Ask for confirmation of Leaning costly choices in one set.
   - Resolve every `NEEDS CLARIFICATION` from Technical Context here, or carry it as Open.

7. **Design (Phase 1).** Start only when research.md is written.
   - **data-model.md.** List the entities from the spec with their fields, relationships, validation rules from the requirements, and state transitions.
   - **contracts/.** Describe the interfaces the feature exposes to users or other systems, in the project's own format: an OpenAPI fragment, a CLI command schema, a library's public API, a UI contract, or an event schema. Name the repo that owns each contract. For purely internal work, skip contracts and say so.
   - **quickstart.md.** Write runnable validation scenarios that prove the feature end to end, with prerequisites, setup and run commands, and expected results, per `references/design-files.md`.
   - **Repo Impact.** For a multi-repo feature, fill this table in plan.md with the repositories, what changes in each, the order, and what each depends on. Take repo names from the constitution's Constraints table. If the constitution makes a contract or spec repo the source of truth, that repo goes first.

8. **Run the constitution gate again after design.** Fill the "After design" column. Handle new violations by the rules in step 5.

9. **Write and stop.** Write plan.md last, with the Summary drawn from the spec and research. Reply per conventions with the paths or doc link, the gate result, any advisory Draft violations, the Open decisions, and the Leaning choices that await the user's confirmation. Suggest the tasks skill as the next stage.

## Rules

- Keep the template headings and IDs.
- Set depth per conventions. A lean plan still fills every mandatory section.
- Use project-relative paths inside the documents.
- The plan never edits the spec. Take gaps found while planning back to the user or to the clarify skill.
