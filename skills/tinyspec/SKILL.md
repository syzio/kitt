---
name: tinyspec
description: 'A light path for small changes. Writes one short file that holds the spec, plan and tasks together, then builds it task by task when the user says go. Use when the user says "tinyspec", "small change", "quick spec", "just a tiny feature", "skip the full process", or asks for a change that fits in one sitting, such as a new flag, a field, a copy change or a small endpoint tweak. Checks the size first and sends the change to specify when it is too big: more than one user story, more than 8 tasks, more than one repository, a shared interface, a schema migration, or money, credentials, personal data or permissions.'
---

# Tinyspec

Read `references/conventions.md` and `references/writing.md` first.

A small change gets one file instead of a spec, a plan and a task list. The file is short enough to read in a minute. When the change turns out bigger, it moves to the full path with its IDs intact.

## Too big for tinyspec

Use specify instead when any of these holds. Check before writing, and again whenever the file grows.

- The change has more than one user story, or more than one P1 behavior a user would test separately.
- It needs more than 8 tasks.
- It touches more than one repository.
- It changes an interface that other teams or customers depend on, such as a public API, an event schema or a file format.
- It needs a schema migration or a new stored entity.
- It handles money, credentials, personal data or permissions.
- It is hard to undo.
- It rests on a decision still Open or needing Research.
- The constitution requires the full path for this kind of change.

When one holds, name it in one sentence and offer the specify skill. Go on with tinyspec only if the user insists, and record the override in the file's Notes.

## Where it lives

- **Repository.** `specs/<NNN>-<slug>/tinyspec.md`, numbered per conventions. Write `.specify/feature.json` pointing to the folder, and create the branch per "Git" in conventions, as specify does.
- **Docs.** Doc "Tinyspec: <Change name>" with one tab, Tinyspec.
- **Neither.** Put the file in the reply, per conventions.

## Write the file

1. **Read the constitution** per conventions. Check the change against its principles. If the change conflicts with a Ratified MUST principle, stop here.
2. **Look up the code.** In a repository, find the files the change touches and how nearby code does the same thing. Ask the user only for decisions, in one set of up to three questions.
3. **Check the size** against the list above.
4. **Write the file** in this shape. Keep it under about 60 lines.

```markdown
# Tinyspec: [Change name]

**Created**: [DATE] · **Status**: Draft

## What and why

[Two or three sentences: the change, who it is for, and the reason.]

## Acceptance

- **AC1**: Given [state], when [action], then [result].
- **AC2**: ...

## Requirements

- **FR-001**: System MUST ...

## Approach

[A few sentences: the files to change, the pattern to follow, and the one decision that mattered with its reason. Tag an unsourced claim ASSUMPTION.]

## Tasks

- [ ] T001 [Action] in [exact file path]
- [ ] T002 [Action] in [exact file path] (depends on T001)
- [ ] T003 Verify AC1 and AC2 [by test or by hand, with the command]

## Notes

[Out of scope, risks, overrides of the size check. Leave out if empty.]
```

- Use the FR- and T IDs and the task line format from conventions, with checkbox, ID and file path. `[P]` is allowed. Story labels and repo tags are not needed.
- Write a test task first when the constitution or the user asks for tests.
- The last task verifies every acceptance line.

5. **Stop.** Reply with the path or link and the task count. Ask whether to build it.

## Build

Building needs a repository. In chat, say so in one sentence and stop after writing the file.

When the user says go:

1. Work through the tasks in order. Resume from the first unticked task.
2. Tick each task in `tinyspec.md` when it is done and verified. Never edit a task's text, ID or order while building.
3. Stop on the first failure and report it. Never weaken a test to make it pass, and never tick a failed task.
4. Keep the size check running. If the work needs a ninth task, a migration or another repository, stop and offer to promote.
5. When every task is ticked, set **Status** to Done, report which acceptance lines passed and how, and suggest a review or a pull request.

## Change it

Edit a tinyspec in place. Keep ticks, and keep IDs and markers per "IDs and markers" in conventions.

## Promote to the full path

When the change outgrows tinyspec, write the full artifacts yourself from its content:

- **Spec.** What and why becomes the overview. Acceptance becomes User Story 1 (P1) with its scenarios. Requirements keep their FR- IDs.
- **Plan.** Approach becomes the summary and the first decision, D1.
- **Tasks.** The tasks keep their IDs, ticks and markers under their phases.

In a repository, write `spec.md`, `plan.md` and `tasks.md` in the same folder. In Docs, rename the doc to "Spec: <Feature name>" and add Spec, Plan and Tasks tabs per conventions. Keep the tinyspec file or tab with a first line "Promoted on [DATE]", so the history stays. Then suggest clarify or plan to fill the gaps.
