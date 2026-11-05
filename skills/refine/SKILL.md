---
name: refine
description: Carries a change to a feature's spec through its plan and tasks while the feature is being built, without renumbering anything. Use when the user says "refine the spec", "change the requirement", "we need to change FR-003", "update the spec and the tasks", "the spec changed, fix the plan", "propagate this change", "reconcile the spec with what we built", when implement, converge or an architecture check reports that the code had to depart from the plan, or when findings from interrogate, blast-radius, critique, an architecture check or converge need new tasks. Shows the impact on each requirement, plan section and task first, writes nothing until the user approves, keeps IDs, ticks and ticket markers, and marks replaced items as superseded instead of deleting them.
---

# Refine

Read `references/conventions.md` and `references/writing.md` first.

A feature's spec changes after planning has started. Refine works out what the change touches, shows it, and after approval edits the spec, plan, design files and tasks so they agree again. Then implement can carry on from where it stopped.

Refine runs in two turns. The first defines the change and shows its impact. The second applies it, after the user approves.

## Hard rules

- **Ask before writing.** Show the change list and the impact table first. Write only what the user approves.
- **IDs and markers** per "IDs and markers" in conventions. Never delete an item. A new item takes the next free ID.
- **Keep ticks.** Never untick a task. Done work that the change makes wrong gets a new rework task.
- **The constitution wins.** Refine never changes the constitution. A change that breaks a Ratified MUST principle stops here.
- **No code.** Refine edits artifacts only. Implement builds the new tasks.

## Where the change comes from

- **The user.** They describe the change in words, or they already edited the spec themselves.
- **The build.** Implement, converge or an architecture check reported a deviation: the code had to do something the spec or plan didn't say. Refine records the decision so the artifacts match the agreed behavior. Ask whether the deviation should become the new intent or whether the code should change back. Only the first case is a refinement. In the second case, suggest converge instead.
- **Findings.** interrogate, blast-radius, critique, an architecture check or converge reported gaps. Besides converge's own appends, refine is the one mid-build path for adding tasks. Quote each finding, since finding IDs aren't saved, and treat it as a change or a Missing task.

## Turn 1: define the change

1. **Find the feature** per "Finding the feature" in conventions. The spec must exist. The plan, the design files and the tasks are optional. Refine updates whatever exists. If the spec is missing, suggest the specify skill and stop.
2. **Read the constitution** per conventions.
3. **Find what changed.**
   - If the user described the change, use their words.
   - If the user already edited the spec, find the edit. In a repository, compare the spec with its last committed version. In chat, ask which sections changed, since a doc has no diff to read.
   - Ask only about decisions the change leaves open, in one set of questions on this change. Look up facts yourself.
4. **Write the change list.** Give each change a line: add, change or remove, the ID it touches, and the new text in one sentence.
   - New wording with the same behavior keeps its ID and is edited in place.
   - New behavior gets a new ID, and the old item becomes "(superseded by <new ID>)". This keeps the link from ticked tasks to the behavior they built.
5. **Check the constitution** per "What gates" in conventions. A Ratified MUST conflict stops the refinement: name the principle and suggest a different change or an amendment through the constitution skill. List Draft conflicts and go on.
6. **Trace the impact.** For each changed ID, find every plan section, design file (data model, contracts, quickstart, research, architecture sketch), task and checklist item that cites it or depends on it. Also search for the concept by name, since not every task cites an ID.
7. **Sort each affected task** into one case:

   | Case | Action |
   |---|---|
   | Unticked, still needed with new details | Edit the description in place. Keep the ID, labels and markers. |
   | Unticked, no longer needed | Add "(superseded by <ID>)", or "(removed)" if nothing replaces it. |
   | Ticked, still correct | No change. |
   | Ticked, now wrong | Keep the tick and the text. Add a new rework task that changes the built code, and mark the old task "(superseded by <new ID>)". |
   | Ticked, now unneeded | Keep the tick. Add a new task that removes the code, if the code must go. |
   | Missing | Add a new task. |

8. **Check the size.** If the change adds a user story, replaces a stack or architecture decision, or affects more than about half of the open tasks, say that a rerun of plan or tasks fits better than a refinement, and let the user choose.
9. **Show the impact and stop.** Print the change list, then this table, then the proposed new tasks:

   ```markdown
   | Artifact | Location | Now | Proposed |
   |----------|----------|-----|----------|
   | spec | FR-004 | Reset links expire after 60 minutes | (superseded by FR-011) |
   | spec | FR-011 | (new) | Reset links expire after 30 minutes |
   | plan | Technical Context: token lifetime | 60 minutes | 30 minutes |
   | tasks | T014 (ticked) | Implement 60-minute expiry | (superseded by T052) |
   | tasks | T052 (new) | (new) | api: Change the reset token lifetime to 30 minutes in src/services/password_reset.py per FR-011 |
   ```

   Under the table, list:
   - constitution conflicts, or "none"
   - tasks with a ticket marker that the change affects, since their tickets need an update
   - checklist items that now cite a changed ID
   - decisions still open

   Ask "Apply these changes?" and wait.

## Turn 2: apply

Apply only what the user approved. Edit in this order, so each file agrees with the one before it.

1. **Spec.** Edit, add and mark items per the change list. New items take the next free ID in their series. Add one line to a `## Refinement Log` section at the end of the spec, creating it if needed: the date, the change in one sentence, and the IDs it touched.
2. **Plan and design files.** Edit the sections the impact table names. If a decision changes, record the new choice, its rationale and the rejected option, and keep the decision's status. A new decision the user hasn't confirmed is Leaning.
3. **Tasks.**
   - Edit and mark the existing lines per the table. Keep checkboxes, IDs, `[P]`, `[US#]`, repo tags, dependency notes and ticket markers.
   - Give each new task the next free task ID.
   - Put a new task in the phase of the story it serves if that phase still has unticked tasks. Otherwise append one `## Phase N: Refinement` section at the end, with N one more than the highest phase number. A later refinement appends its own phase and never edits an earlier one.
   - Add markers to the new lines per "IDs and markers" in conventions, such as `(depends on T052)`.
   - Update the counts in the lead line.
4. **Checklists.** Don't tick or untick items. Name the items that cite a changed ID in the reply, so the user can rerun the checklist skill.

**Docs.** In chat, make the same edits in the Spec, Plan and Tasks tabs of the feature doc.

## Report

Reply in a few lines: the files or tabs changed, the IDs added, superseded and removed, and the new task IDs. Then name the next step:

- analyze, to check that spec, plan and tasks agree again
- ticket-push, if any affected task has a ticket marker
- implement, which reruns its gates because the text changed, then resumes from the first unticked task
