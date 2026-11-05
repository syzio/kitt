---
name: specify
description: Write or update a feature specification, which says what to build and why with no implementation detail. Use when the user wants to spec out, define, scope or write requirements for a feature, flow, screen, endpoint or product capability ("spec out CSV export", "write a spec for password reset", "turn this assessment into a spec"), when an assessment ends with a go verdict and needs turning into a spec, or when an existing spec needs a change before planning. Produces prioritized, independently testable user stories with Given/When/Then scenarios, FR- and SC- IDs, technology-agnostic success criteria, an assumption for every default, at most three [NEEDS CLARIFICATION] markers, and a requirements quality checklist. Features that span several repositories get one product-level spec.
---

# Specify

Read `references/conventions.md` and `references/writing.md` first. Use `references/spec-template.md` for the spec and `references/requirements-checklist.md` for the quality checklist.

A spec describes what users need and why. Languages, frameworks, schemas and endpoints belong to the plan.

## 1. Input

- The input is the user's feature description or an assessment handoff. An assessment handoff is an assessment with a go verdict, in `.specify/assessments/<slug>/assessment.md` or in the assessment doc. Take the problem, the users, the scope and the Decided items from it, and cite it in the **Input** field.
- If there is no description at all, ask for one and stop.
- If the user asks to change an existing spec, go to "Updating a spec".
- Create one feature per run.

## 2. Name and create

- Name the feature with a slug per conventions, in action-noun form. Keep technical terms and acronyms. "Add OAuth2 sign-in to the API" gives `oauth2-sign-in`.
- In a repository, assign the number per conventions and create `specs/<NNN>-<slug>/`. If the user names a feature folder, such as `docs/features/csv-export/`, use it as given and skip the number. Never write into a folder that already holds a `spec.md` for another feature. Write `spec.md` there from the template.
- Write `.specify/feature.json` with the real path relative to the repository root, for example `{"feature_directory": "specs/004-csv-export"}` or `{"feature_directory": "docs/features/csv-export"}`. Write it for a custom folder too. Set **Feature Branch** to the folder's last segment.
- In a git repository, create and switch to the feature branch per "Git" in conventions before you write `spec.md`, and use the branch name that passes the naming check.
- In chat, create the doc "Spec: <Feature name>" with the tabs Spec and Checklists. The plan and tasks skills add their tabs later. Set **Feature Branch** to "assigned when exported to a repository".

## 3. Depth

Choose lean or full per conventions, and say which in one line.

## 4. Draft

Find the actors, actions, data and constraints in the input. Then fill the template, and keep its section order and headings.

- **User stories.** Write independent slices, each with a priority. P1 alone must be a usable MVP. Each story says why it has its priority and how someone can test it on its own, and lists Given/When/Then acceptance scenarios. If the input has no user flow, don't invent one. Record an assumption, or a marker if it meets the bar in step 5.
- **Edge cases.** List boundary conditions and error scenarios.
- **Functional requirements.** Number them FR-001 onward. Each one is testable and unambiguous, in the form "System MUST …" or "Users MUST be able to …".
- **Key entities.** Add them only if the feature involves data. Say what each entity represents and give its key attributes, without implementation.
- **Success criteria.** Number them SC-001 onward. Each one is measurable and technology-agnostic. It names a time, rate, count or percentage that a user or the business would observe.
- **Assumptions.** Write one for every default you chose where the input was silent.

Remove optional sections that don't apply. Never write "N/A".

At full depth, add more edge cases, cover every user type and permission, and add success criteria for failure and recovery.

## 5. Unclear points

Make an informed default from context and common practice, and record it under Assumptions. Use `[NEEDS CLARIFICATION: <question>]` only when all three of these hold:
- the choice changes scope, security or privacy, or user experience;
- it has several reasonable readings with different outcomes;
- there is no sensible default.

Use at most three markers in the whole spec. If you have more, keep the three with the most impact and turn the rest into assumptions. Rank impact in this order: scope, then security and privacy, then UX, then technical details. Don't ask the questions here. The clarify skill asks them.

## 6. Quality check

Run `references/requirements-checklist.md` against the spec silently. Decide pass or fail for each item, and note the spec text that fails.

- Fix what fails and run the check again, up to three passes. Open markers don't count as failures to fix here.
- Record the final result in `checklists/requirements.md` in the feature folder, or in the Checklists tab in chat. Record each item as checked or unchecked, the score (for example "14/16"), and a note for each item that still fails.

## 7. Report

Reply in one or two lines with the path or link. Give the depth, the checklist score and the number of open markers. If markers remain or the checklist flags ambiguity, the next step is clarify. Otherwise it is plan.

## Updating a spec

This applies only before a plan exists. If `plan.md` or `tasks.md` exists, or the Plan or Tasks tab, hand the change to the refine skill per "Changing a spec after planning" in conventions.

- Find the feature per conventions, and change only what the user asked for.
- Keep and retire IDs per "IDs and markers" in conventions. A new item takes the next free ID.
- Run the quality check again and update the checklist.

## Features across several repositories

Write one product-level spec that describes the behavior across every repository involved. Don't split the spec by repository. The plan's repo impact and the task list do that, using the Constraints table in the constitution.
