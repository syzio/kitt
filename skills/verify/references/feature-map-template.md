# Feature map template

The map is the project's maintained source for verifying user-facing behavior. It has one index and one file per feature. The example below is for a notes app with a browser UI and a CLI, driven by a helper called `verify-notes`. Replace it with the real app's names, handles and commands.

## Index: `features/README.md`

```markdown
# <App> verification map

Read this index before driving the app. Then use the matching feature file as the recipe.

## Baseline preconditions

- Launch <app> at `http://127.0.0.1:4173` with a fresh data folder per run.
- Set `NOTES_DATA_DIR=/tmp/notes-verify-$RUN_ID` so runs don't share state.
- Seed notes titled `Quarterly plan` and `Grocery list`.
- Run doctor and require the expected URL, data folder and build.
- Never drive an instance this run didn't start.

## Driving rules

- Start every recipe from the baseline state unless its preconditions say otherwise.
- Prefer accessible roles and names over CSS selectors or position.
- Treat every command as literal. Keep quoted names and flags unchanged.
- Restore seeded data after a change. Keep proof artifacts during cleanup.

## Proof and skip reporting

- Capture the user action and the state that results.
- Record the feature ID, the entry point and the scenario ID with every artifact.
- Report an unreachable path with the command you tried and the missing precondition.
- Never report a skipped entry point as verified through a different one.

## Feature file shape

Each feature file has an H1 title and one paragraph on what the user sees, then these H2 sections in this order: `Sub-features`, `How to get to it (user POV)`, `Driving it with <helper>`, `Acceptance scenarios`, `Gotchas`. Keep implementation details out. Name only user paths, stable handles, required state, commands and observable proof.

## Features

- [Create a note](./create-note.md): browser and CLI creation, cancel, persistence.

## Uncovered scenarios

- `US2/AC3` (specs/004-sharing): no journey yet; sharing needs a second account.
```

## Feature file: `features/create-note.md`

```markdown
# Create a note

A user saves a titled note from the browser or the CLI, cancels an unfinished draft, and sees the saved note in a second view.

## Sub-features

- `create-open` opens a blank editor from each browser entry point.
- `create-save` stores a title and body.
- `create-cancel` discards an unfinished draft.
- `create-cli` creates the same note from the terminal.

## How to get to it (user POV)

- Choose the `New note` button in the toolbar.
- Press `n` while focus is outside a text field.
- Run `notes create --title <title> --body <body>`.

## Driving it with verify-notes

Preconditions:

- Doctor passes for `http://127.0.0.1:4173`.
- No note is titled `Release checklist`.

- **Open editor.** Run `verify-notes browser click --role button --name "New note"`. A form named `Note editor` appears with focus in `Title`.
- **Enter content.** Run `verify-notes browser fill --role textbox --name "Title" --value "Release checklist"`. The `Save note` button becomes enabled.
- **Save note.** Run `verify-notes browser click --role button --name "Save note"`. A status `Note saved` appears.
- **Confirm it was stored.** Run `verify-notes browser click --role link --name "All notes"`, then open `Release checklist`. The editor shows the saved title and body.
- **CLI entry.** Run `verify-notes cli -- notes create --title "CLI note" --body "From terminal" --format json`. Exit code is `0` and stdout has the new note's ID.
- **Proof.** Run `verify-notes browser snapshot --path .verify/$RUN_ID/create-note/list.txt` and `verify-notes browser screenshot --path .verify/$RUN_ID/create-note/list.png`. Both show `Release checklist` and `CLI note`.

## Acceptance scenarios

| Scenario | Spec | Journey steps |
|---|---|---|
| `US1/AC1` | specs/003-notes | Open editor, Enter content, Save note, Confirm it was stored |
| `US1/AC2` | specs/003-notes | CLI entry |

## Gotchas

- Pressing `n` in a text field types the letter instead of opening the editor.
- The app trims titles on save. Check the shown title, not the draft input.
- The save status alone proves nothing. Reopen the note from the list.
```
