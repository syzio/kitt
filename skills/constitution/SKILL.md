---
name: constitution
description: Create, ratify or amend the project constitution, the short list of checkable MUST and SHOULD rules that every spec, plan and task list is checked against. Use when the user wants to set, write, review, ratify or change project principles, ground rules, non-negotiables or engineering standards, says "draft a constitution", "add a principle", "ratify the constitution" or "amend principle III", or when another skill finds no constitution and the user agrees to draft one. Records each principle with its rationale, source and status, keeps Leaning ideas in a Candidates table, lists the repositories and what each owns, bumps a semantic version on every amendment, logs the open specs a change affects, and lists the templates, docs and specs that no longer match.
---

# Constitution

Read `references/conventions.md` and `references/writing.md` first. The template is `references/constitution-template.md`.

The constitution holds the rules that every spec, plan and task list must meet. This skill writes only the constitution. It never writes code, specs or plans.

## 1. Find and sort

- Find the constitution per conventions. If one exists, this run amends or ratifies it. If none exists, this run creates it.
- Sort the user's input into constitution content and other requests, such as building a feature, writing a spec or refactoring code. Don't act on the other requests. List each one under "Next actions" in the reply, with the kitt skill that handles it. For example, specify handles a new feature.
- If you can't tell whether an instruction is a rule for the project or a request for work, ask before you change anything.

## 2. Gather sources

Principles come only from these sources:
- rules the user states in this conversation;
- items marked Decided in documents the user points to, such as an assessment or a decision record;
- rules the repository's own files state, as candidates only (see "Repository rules" below).

Put Leaning items in the Candidates table, never in Core Principles. Leave out Open and Research items. Never invent a principle, and never turn a common practice into one.

**Repository rules.** In a repository, you may also read rules the project already writes down: README, CONTRIBUTING, CLAUDE.md, AGENTS.md, lint and CI config, and `docs/`. Add each rule you find to the Candidates table as Leaning. Set its Source to the file and section, such as "CONTRIBUTING.md §Tests" or ".github/workflows/ci.yml". Take only rules the file states or enforces. Never infer a rule from how the code happens to look. A repository rule never binds until the user promotes it and then ratifies it.

**Principles pool.** When you create or review a constitution, you may suggest up to five entries from `references/principles.md`. They go in the Candidates table as Leaning, never in Core Principles. Suggest an entry only when its "Applies when" line fits what the user or the repository has said about the project. Skip an entry that repeats an existing principle or candidate. Set its Source to "principles pool", and tell the user why it fits. If the user promotes it, its source is "principles pool, promoted YYYY-MM-DD".

Constraints are facts, not rules. They cover the repositories and what each owns, the stack, and the deployment targets. Take them from the user, from Decided items, or from the repository itself (README, top-level folders, manifests). Record where each fact came from.

## 3. Draft or amend

Use `references/constitution-template.md` and keep its headings.

Each principle has these parts:
- a short name and a Roman numeral (I, II, III…);
- one or more rules that a reviewer can check against a spec or plan, each with MUST or SHOULD and the thing it constrains;
- a one-line rationale, starting "Why:";
- its source, which is a doc section, a repository file and section, or "your words, YYYY-MM-DD";
- a status of Draft, Ratified or Rejected.

**Extra sections.** Add an optional section after Constraints only when the user or a Decided item sets standards for one area that would crowd the principles, such as Security, Performance or Compliance standards. Keep each standard checkable, with MUST or SHOULD and a source. Never rename or reorder the fixed headings.

Keep five to nine principles. If the user has decided fewer than five, don't pad the list. Say how many more the Candidates table could supply. If there are more than nine, propose merges. If the user asks for a specific number, use it.

Rewrite a vague rule until a reviewer could check it. "Code SHOULD be fast" fails. "Every user-facing page MUST load within 2 seconds on the reference device" passes.

Every new principle starts as Draft.

**Amending.** Change only what the user asked for. Retire a principle per "IDs and markers" in conventions.

## 4. Version and log

Bump the version by semantic versioning:
- Bump MAJOR when a principle is removed or redefined, or when a rule changes so that work that passed before now fails.
- Bump MINOR when a principle or section is added, or a rule gains new requirements.
- Bump PATCH for wording, clarifications and typo fixes.

A new constitution starts at 0.1.0. The first ratification makes it 1.0.0. If the bump type is unclear, give your reasoning and let the user choose.

Add one row to the Amendment Log for every change, with the version, the date, the change and the open specs it affects. An open spec is a feature whose tasks are not all done. In a repository, find every folder that holds a `spec.md`, under `specs/` or a custom feature folder, and read its `tasks.md`. In chat, use the specs the user has linked in this conversation or that earlier log rows list. If you know of none, ask for links.

Set **Last Amended** to today on every change. Set **Ratified** to the date of the first ratification, or to "pending" before it.

## 5. Ratify

Only the user ratifies, rejects or promotes. When the user does one of these, update the item's status in Core Principles, the Ratification table and the Candidates table, then log the change. Promoting a candidate adds a Draft principle and bumps MINOR.

In Docs, use a dropdown column for every Status column and for the "Your call" column, so the user can decide in place.

## 6. Check before writing

- No placeholder text is left, except fields you leave as "TODO(<field>): <reason>".
- The version line matches the newest Amendment Log row.
- Dates use ISO format (YYYY-MM-DD).
- Every rule uses MUST or SHOULD and names what it constrains. No rule relies on an unmeasured adjective such as "fast", "simple" or "appropriate".
- Every principle has a source and a status.

Write the constitution per conventions.

## 7. Propagation check after an amendment

After an amendment, list the artifacts that no longer match the principles. Don't change them yet.

- In a repository, check `.specify/templates/*.md` if it exists, README and `docs/` text that cites a principle, and the `spec.md`, `plan.md` and `tasks.md` of each open spec. In `plan.md`, check the Constitution Check section.
- In chat, check the open spec docs you found in step 4.

For each mismatch, name the file or doc, the section, and the principle it conflicts with. Change an artifact only after the user approves that change. Record each approved update in the "Specs affected" cell of the Amendment Log row.

## Report

Reply in one or two lines with the path or link. Give the new version and the reason for the bump, what awaits ratification, and the propagation list if there is one. Then list any deferred requests under "Next actions". Commit per "Git" in conventions, with a message such as `constitution: v1.1.0, add principle VI`.
