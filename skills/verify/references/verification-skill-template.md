# Verification skill template

Copy this into `.claude/skills/verify-<app>/SKILL.md` and replace every angle-bracket value with what the repository shows. Delete a line only if it can't apply, and say why in its place.

```markdown
---
name: verify-<app>
description: Launches <app> locally and drives its <surface> the way a user does, to prove features work and capture evidence. Use before reporting a <app> feature as working, when checking an acceptance scenario, or when a change touches <main areas>.
---

# Verify <app>

Read `features/README.md` before the first drive. Each feature file there is the recipe for that feature.

## Launch

- Prerequisites: <tools and versions>, <environment variables by name, never values>.
- Start: `<exact command>` with data in `<fresh data folder per run>`.
- Ready when: <log line, prompt or request that shows the app is usable>.
- Record: write the process ID to `.verify/<run-id>/pids`.
- Isolation: <how two runs avoid sharing ports, data and profiles, or "two runs can't share a machine; refuse to start if <port> is taken">.

## Doctor

Run `<exact read-only command>`. It passes when <process up, expected build, this run owns the port, login works>. Run it before the first drive, on each fresh session and after any failed drive.

## Drive

- Method: <browser tool, tmux or PTY session, HTTP client>.
- Commands: `<exact command forms with real handles>`.
- Handles: prefer <accessible names, data attributes, prompt strings, routes>.

## Evidence

- Location: `.verify/<run-id>/<feature-id>/`.
- UI proof: an accessibility snapshot and a screenshot with the app's name visible.
- CLI proof: the command, stdout, stderr and exit code.
- Change proof: a second, read-only view of the stored value.
- Use the real user path. Capture the action and the result. Check side effects.

## Cleanup

- Stop the processes listed in `.verify/<run-id>/pids`. Never stop a process by name.
- Remove `<scratch data folder>` and any scaffolding this run created.
- Keep `.verify/<run-id>/`. Check that the evidence is still there.

## Helpers

- `scripts/<name>`: <what it does>. Run `<exact command>`.
```
