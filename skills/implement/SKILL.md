---
name: implement
description: Builds a feature in the repository by working through its tasks.md phase by phase, writing the code and ticking each task as it is done. Use when the user says "implement the feature", "build it", "start on the tasks", "work through tasks.md", "continue implementing", "pick up where we left off", or after converge has appended new tasks. Checks the feature's checklists and runs analyze before starting, follows task order, dependencies and [P] markers, writes tests first where the tasks include them, stops and reports on the first failure, and validates the result against quickstart.md. Needs a repository working tree.
---

# Implement

Read `references/conventions.md` and `references/writing.md` first.

Build a feature from its task list, in the repository. The spec, plan and tasks say what to build. This skill writes code and ticks tasks, and changes nothing else.

## Before you start

1. **Feature.** Find it per "Finding the feature" in conventions. It must hold `tasks.md`, `plan.md` and `spec.md`. If `tasks.md` is missing or lists no tasks, stop and suggest the tasks skill. If `plan.md` is missing, suggest the plan skill.
2. **Constitution.** Find and read it per conventions.

## When to run the gates

Run the checklist gate and the analyze gate on the first start, when no task in `tasks.md` is ticked. After that, run them again only when the text of the spec, the plan or a task has changed since they last ran. Ticked checkboxes and `(ticket: …)` markers don't count as changes. To tell, compare with the earlier run in this conversation, or with the files' version history in the repository. On a resume with no such change, skip both gates and say so in one line.

## Checklist gate

If the feature folder has a `checklists/` folder, scan every file in it. The checklists are read-only. Report their state, and never tick or edit an item. A checked item means a reviewer judged that requirement-quality criterion satisfied. It says nothing about the code.

Count three numbers for each file:
- Total is the number of lines matching `- [ ]`, `- [x]` or `- [X]`.
- Checked is the number of lines matching `- [x]` or `- [X]`.
- Unchecked is the number of lines matching `- [ ]`.

Show the result as a table:

```text
| Checklist       | Total | Checked | Unchecked | Status |
|-----------------|-------|---------|-----------|--------|
| requirements.md | 12    | 12      | 0         | PASS   |
| security.md     | 8     | 5       | 3         | FAIL   |
```

- **All pass.** Show the table and go on to the analyze gate.
- **Any unchecked.** Show the table and ask "Some checklists have unchecked items. Proceed with implementation anyway?" Wait for the answer. Continue only on a clear yes. Otherwise, stop.

## Analyze gate

Run the analyze skill on the feature. Analyze changes no files.

- **CRITICAL findings.** List them and stop. Start implementing only if the user explicitly overrides, and note the override in your reply.
- **No CRITICAL findings.** Give the count of findings per severity in one line and continue.

## Load the context

Always read `tasks.md` for the task list and order, `plan.md` for the stack, architecture and file structure, and `spec.md` for the requirements and acceptance scenarios. If `architecture.md` exists, read it too, and keep the types, signatures and module boundaries it sets. Report any deviation instead of working around it. If the code must depart from the spec or plan, stop and suggest the refine skill. Also read `data-model.md`, `contracts/`, `research.md`, `quickstart.md` and the constitution if they exist.

From `tasks.md`, extract the phases and each phase's checkpoint. For each task, note its ID, `[P]` marker, `[USn]` label and file paths. Read the dependency section and any cross-repo dependencies. A ticked task is done, so resume from the first unticked task.

## Project setup check

Before the first setup task, check that the repository's ignore files cover what the plan's stack produces. That means dependency folders, build output, logs and local environment files. It also means every file that can hold a secret: private keys, `.env*` files, kubeconfig files, `*.tfvars` files and credential files. Check the ignore files only for tools the project uses, such as version control, container builds, linters, formatters and package publishing. Append missing patterns to an existing file. Create a file only if the project uses the tool and the file is missing. Never remove existing patterns.

## Execute

- **Phase by phase.** Finish every task in a phase and verify its checkpoint before you start the next phase.
- **Task order.** Within a phase, work in task ID order. Tasks marked `[P]` may run together. Tasks that touch the same file run one after another, even if marked `[P]`.
- **Dependencies.** Follow the dependency section of `tasks.md`. If a task waits on an unfinished task in another repository, stop and report it.
- **Open decisions.** Don't start a task marked `(open decision: …)` unless the plan now settles that decision. Otherwise stop before it, name the decision, and ask the user to settle it.
- **Tests first.** If the tasks include test tasks for a story, write those tests before the story's implementation tasks. Run them and confirm they fail for the expected reason. Don't add test tasks that the list doesn't have.
- **Scope.** Do what each task says, in the files it names. If a task conflicts with the spec, the plan or the constitution, stop and ask instead of improvising.
- **Tick as you go.** When a task is done and verified, change its `- [ ]` to `- [x]` in `tasks.md` right away. Never edit a task's text, ID or order. Don't touch `spec.md`, `plan.md` or the checklists.
- **Progress.** After each task, report it in one line with the task ID, what changed, and how you verified it.

## Rhythm

Treat the run up to the MVP checkpoint as one stage per conventions. By default, work from the first unticked task through the end of the first user story phase in one turn, and verify each phase's checkpoint as you go. If any checkpoint fails, stop there and report. At the MVP checkpoint, run the verification journeys as Finish step 4 describes, then report and stop for review.

After the MVP, offer two ways to go on: phase by phase, stopping for review after each phase, or run to the end. Without an answer, go phase by phase.

## On failure

- **A sequential task fails.** Stop, and leave the task unticked. Report the task ID, what failed, a short excerpt of the error output, what you tried, and a suggested next step.
- **A `[P]` task fails.** Finish the other tasks in that parallel batch and report the failed ones. Then stop before any task that depends on them.
- Never weaken, skip or delete a test to make it pass. Never tick a task whose verification failed, and never commit after a failed checkpoint.

## Finish

When every task in `tasks.md` is ticked:

1. Confirm that no task is left unticked.
2. Run the full test suite, plus lint and type checks if the project has them.
3. Walk through `quickstart.md`. Run each scenario or command and record whether it passed. If a step can't run here because it needs an external service or similar, say so. Never report it as passed.
4. If the project has a verification skill under `.claude/skills/verify-*/`, run its journeys for the built stories' acceptance scenarios and report each as passed, failed or unreachable, with its evidence path. A failed journey fails the checkpoint. If none exists, offer the verify skill.
5. Report the tasks completed, the test results, the quickstart and verification results, and any deviation from the spec or plan you saw. Suggest converge next, which checks each FR. Implement and converge alternate until converge reports the feature converged.
