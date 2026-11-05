# Task slices per repo

For a multi-repo feature, write one slice per repo after the full tasks.md. The full tasks.md stays the source of truth. A slice is what one repo's implementer works from.

## Where slices go

- **Repository.** `slices/<repo>/tasks.md` in the feature folder. The user copies each into that repo's feature folder as `tasks.md`, along with spec.md, plan.md and the design files.
- **Docs.** One tab per slice, named "Tasks: <repo>".

## What a slice holds

- The title and header lines of tasks.md, plus `**Repo**: <repo>`.
- A "Cross-Repo Dependencies" section at the top:
  - **Waits on.** List the tasks in other repos that this repo needs first, for example "T020 web waits on T011 api."
  - **Blocks.** List the tasks in other repos that wait on this repo's tasks.
- Only the lines tagged with that repo, with their original T-IDs. Gaps in numbering are fine.
- The phase headings, Goal, Independent Test and Checkpoint lines of every phase that has at least one task for this repo.
- The Implementation Strategy section, unchanged.

## Keeping slices in step

- Regenerate every slice when tasks.md changes. Only tasks and ticket-push write slices.
- Ticked checkboxes and ticket markers in tasks.md carry over into the slices.
