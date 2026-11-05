---
name: checklist
description: Writes a requirement-quality checklist for a feature, a set of "unit tests for English" that check whether the spec and plan are complete, clear, consistent and measurable for one domain such as security, API, UX, data, accessibility or performance. It never tests whether the code works. Use when the user asks for a checklist, a security, API or UX checklist for this spec, or a domain review gate for the spec. A second run on the same domain appends to that checklist.
---

# Checklist

Read `references/conventions.md` and `references/writing.md` first.

Item rules and examples are in `references/checklist-guide.md`, and the template is `references/checklist-template.md`.

A checklist is a unit-test suite for the requirements. Each item asks whether something is written well: complete, clear, consistent, measurable, covering the scenario. No item asks whether the implementation works.

## 1. Load

- Find the active feature per conventions. If it has no spec, suggest the specify skill and stop.
- Read the spec. Read the plan and tasks if they exist. Load only the sections relevant to the domain; summarize long sections instead of copying them.

## 2. Choose domain, focus and depth

- Derive the domain from the request and the artifacts' signals: domain keywords (auth, latency, export, accessibility), risk words ("must", "critical", "compliance"), named reviewers ("security review", "QA"), named deliverables ("rollback", "contracts").
- Give the checklist a short domain name, which becomes its file name: `security`, `api`, `ux`, `data`, `performance`, `accessibility`.
- Ask scoping questions only where the request and the artifacts leave a choice open and the answer changes the items. Ask at most three, in one set, each with a recommended answer and two to four options, per "Asking questions" in conventions. Pick from these: scope or domain, depth (a quick self-check or a release gate), audience, and what to leave out. Skip any the request already answers. Never ask the user to repeat what they already said. Ask no follow-ups. A gap the answers leave becomes a `[Gap]` item.
- Defaults for anything not asked or not answered: depth per conventions, the reviewer as audience, and the two focus areas the signals point to most.
- Include every must-have item the user named.

## 3. Write the items

Follow `references/checklist-guide.md` for item wording, categories, scenario classes, traceability and the 40-item cap.

- If the constitution lists checklist items for this domain, include the relevant ones, adapted to this feature, and cite `[Constitution §<principle>]`.
- Don't invent requirements the artifacts don't support. If unsure, ask about it as `[Assumption]` or `[Gap]`.

## 4. Save

- **Repository.** Write `<feature folder>/checklists/<domain>.md` from the template.
- **Docs.** Use the feature doc's Checklists tab, one section per domain, headed by the template's title line.
- **Neither.** Put it in the reply, and say it isn't saved.

Numbering and ownership:

- A new checklist starts at CHK001.
- If a checklist for the domain exists, append the new items to it and continue from its last CHK ID: after CHK015 comes CHK016. Never delete, renumber or rewrite existing items.
- Generate every item unchecked, `- [ ]`. Ticking is the reviewer's call. Evaluate items only when the reviewer asks.
- `checklists/requirements.md` is the spec quality checklist that the specify and clarify skills maintain. Never put domain items in it.

## 5. Report

In a few lines:
- the file path or doc link, and whether the run created a checklist or appended to one;
- the item count and CHK range;
- focus areas, depth and audience;
- the user's must-have items included;
- the two or three biggest gaps found.
