# Mapping tasks to tickets

## Ticket marker

After a push, each task line ends with exactly one marker:

```text
- [ ] T012 [P] [US1] api: Create the ResetToken model in src/models/reset_token.py (ticket: ABC-123)
```

- The marker is ` (ticket: <ID>)`, last on the line per "IDs and markers" in conventions.
- `<ID>` is the key the tracker displays, for example `ABC-123`, `#42` or `86c1abcde`.
- One marker per line. On a re-push, update the ticket named by the marker; never create a second one.

## Fields

Map what the tracker supports. For anything it can't hold, put the information in the description and list the gap in the summary.

| Task part | Ticket field |
|---|---|
| `T012` and description | Title: `T012: <description>`, without checkbox, `[P]`, `[US#]` or repo tag, cut to about 100 characters |
| Full task line, story title, FR- and acceptance references, file path, link to the feature | Description (markdown if supported) |
| Repo tag (`api`, `web`) | Label `repo:<name>`, or the tracker's component or project field |
| `[US1]` | Label `us1` |
| Phase with no story | Label `setup`, `foundational` or `polish` |
| `[P]` | Label `parallel` |
| Priority | Setup, Foundational and P1 stories: high. P2: normal. P3 and later, and Polish: low. Use the tracker's nearest scale. |
| `(depends on T010)` and Cross-Repo Dependencies | Blocking dependency or "blocked by" link to that task's ticket. If the tracker has no dependencies, a "Blocked by" line in the description. |
| Phase | The tracker's grouping (epic, milestone, parent ticket, section or list), one per phase. If the tracker has no grouping, the phase label only. |

## Notes

- Put phase gates in the description ("Starts after Phase 2: Foundational") rather than as a dependency from every task to every earlier one, which would bury the real dependencies.
- Only add dependencies that the task lines or the Cross-Repo Dependencies section state.
- Write labels in lowercase. Create a missing label once per target.
