---
name: converge
description: Compares the code in the repository against a feature's spec, plan and tasks, and appends new tasks to tasks.md for work that is still unbuilt or that contradicts the spec, plan or constitution. Use after implement, or when the user asks "is the feature done?", "what's left to build?", "check the code against the spec", "converge", or "close the gaps". Never rewrites the spec, plan or existing tasks and never changes code. Ends either with "converged" or with the list of tasks it appended, so implement can pick them up. Alternate implement and converge until converged. Needs a repository working tree.
---

# Converge

Read `references/conventions.md` and `references/writing.md` first.

Close the gap between what the spec, plan and tasks call for and what the code does now. Converge assesses the code as it is today. It reads no git history and compares no branches.

## Hard rules

- The only write is one new `## Phase N: Convergence` section appended to the end of `tasks.md`. It needs no approval, because it never changes an existing line.
- Never modify `spec.md`, `plan.md`, the design files or the constitution.
- Never rewrite, renumber, reorder, untick or delete an existing task. That includes tasks in earlier Convergence phases.
- Never create, edit or delete application code. Implement does the appended tasks.
- When nothing is left to do, leave `tasks.md` byte-for-byte unchanged. Don't add an empty Convergence header.

## Before you start

1. **Feature.** Find it per "Finding the feature" in conventions. It must hold `spec.md`, `plan.md` and `tasks.md`. If one is missing, stop and name the skill to run, which is specify, plan or tasks. Report no findings and write nothing.
2. **No ticked tasks.** If no task in `tasks.md` is ticked, look for code in the feature's scope, as Build the inventory describes. Ticks are claims, not evidence. If code exists, go on and say that no task is ticked. If none exists, say so and suggest implement, instead of appending tasks that repeat the existing list.
3. **Constitution.** Find and read it per conventions. If it is still an unfilled template, skip the constitution checks and say so.

## Load only what you need

- **From spec.md.** Take the functional requirements (FR-), the success criteria (SC-) that need buildable work, the user stories with their acceptance scenarios, and the edge cases. Leave out post-launch outcome metrics.
- **From plan.md.** Take the stack and technical decisions, the data model references, the files and components the plan says will be created or changed, and the technical constraints. Read `data-model.md` and `contracts/` where the plan points to them.
- **From tasks.md.** Take the task IDs, which give the next ID and phase number, plus the descriptions, phases and file paths.
- **From the constitution.** Take the principle names and their MUST and SHOULD statements.

## Build the inventory

Keep the inventory internal. Don't echo the artifacts back.

- **Requirements inventory.** Make one key per FR-, SC- and acceptance scenario, for example `US1/AC2`. Add the plan decisions and constitution principles that impose buildable obligations, and every existing task.
- **Code scope.** Take the files named in `plan.md` and `tasks.md`. Add what a keyword search finds for the concepts each requirement describes. Assess only within this scope.

## Assess the code

- Check every item in the inventory against the current code. A ticked box is a claim, not evidence.
- For a chain of corrective tasks, assess the behavior that results, not the superseded code.
- Record a finding only where there is a gap. Give each one a gap type:
  - `missing` means the required work is absent from the code.
  - `partial` means the work exists but doesn't fully meet the requirement, scenario or decision.
  - `contradicts` means the code conflicts with the spec, the plan or a constitution MUST principle.
  - `unrequested` means the code does work that the spec, plan and tasks don't call for.
- Each finding has an ID (F1, F2…), the source it traces to, the gap type, a severity, and the evidence. The evidence is the file or area you looked at.
- If a story that the tasks mark done has little or no code, treat that story's scope as `missing`.
- If the project has a verification skill under `.claude/skills/verify-*/`, treat a failed journey as evidence for a `partial` or `contradicts` finding on its scenario. For a scenario with no journey, suggest the verify skill's maintain mode instead of appending a task.

### Severity

- **CRITICAL.** The code conflicts with a Ratified MUST, per "What gates" in conventions, or a `missing` or `contradicts` gap blocks the baseline function of a P1 story.
- **HIGH.** A `missing` or `partial` gap sits on a core requirement or acceptance scenario.
- **MEDIUM.** A `partial` gap sits on a secondary requirement, or `unrequested` work has no clear reason.
- **LOW.** The gap is a minor partial one, polish, or low-risk `unrequested` work.

## Report findings

Before you write anything, show the findings in the reply:

```markdown
## Convergence Findings

| ID | Gap Type | Severity | Source | Evidence | Remaining Work |
|----|----------|----------|--------|----------|----------------|
| F1 | missing  | HIGH     | FR-004 | no expiry check in api/src/reset/token.ts | Reject reset links older than 30 minutes |
```

Under the table, give these counts:
- requirements and scenarios checked
- plan decisions checked
- constitution principles checked, or "skipped, template"
- findings per gap type
- findings per severity

## Append tasks, or report converged

Append a task for each `missing`, `partial` and `contradicts` finding. Those are the work that is unbuilt or that contradicts the intent. If unrequested work contradicts the spec, classify it `contradicts` instead. If a gap reflects a change of intent rather than missing work, suggest the refine skill instead of a task.

`unrequested` findings are for the user to judge. If there are any, ask in your report whether to append one combined task for them, such as `- [ ] T045 api: Review unrequested work, then keep, justify in the spec, or remove it: "CSV export button" in src/ui/export.tsx; "debug endpoint" in src/routes/debug.ts (unrequested)`. Quote each finding, since F-IDs aren't saved. Append it only if the user agrees. Put it last in the Convergence phase this run wrote, with the next free ID. If this run wrote no phase, append a new Convergence phase that holds only this task.

**Tasks to append.** Follow these steps.

1. Find the highest existing task ID `M` and the highest phase number. The new phase number `N` is one more.
2. Append one header `## Phase N: Convergence` at the end of `tasks.md`.
3. Add one task per actionable finding, numbered from `M+1`. Put Ratified constitution conflicts first, then order by severity.

   ```markdown
   - [ ] T042 [US1] api: <imperative description> in <file path> per <source-ref> (<gap type>)
   ```

   Write the full line per the tasks skill's template, with the story label in a story's scope and the repo tag when the feature has repos. Put markers in the order conventions gives. `<source-ref>` names the origin, such as `FR-003`, `SC-002`, `US1/AC2`, `plan D2` or `Constitution II`.
4. If an earlier Convergence phase exists, add the new one below it. Never touch the old one or reuse its IDs.

Then report how many tasks you appended and under which phase. Suggest running implement, then converge again.

**Nothing actionable.** Leave `tasks.md` untouched, unless the user agrees to the review task for unrequested work. Report "Converged: the implementation satisfies the spec, plan and tasks." with the counts of what you checked. Suggest a review or a pull request.
