---
name: analyze
description: Read-only consistency check across a feature's spec, plan and tasks before implementation. Finds duplicated, ambiguous or underspecified requirements, constitution violations, requirements with no task and tasks with no requirement, terminology drift and conflicts, and, for plans that span several repositories, repos that no task touches. Prints a findings table with severities, a coverage table, metrics and next actions, then offers fixes. CRITICAL findings block implementation. Use after the task list is written and before implementing, or when the user says "analyze", "cross-check", "check consistency", "validate the plan" or "find gaps between spec, plan and tasks". Never edits anything without approval.
---

# Analyze

Read `references/conventions.md` and `references/writing.md` first.

The output format is in `references/analysis-template.md`.

Before any code is written, find the inconsistencies, duplication, ambiguity, gaps and constitution violations across the spec, plan and tasks.

## Rules

- **Read-only.** Never change the spec, plan, tasks or constitution during the analysis. Edit only after the user approves specific fixes in step 7.
- **The constitution wins.** Rate conflicts per "What gates" in conventions. Fix the spec, plan or tasks, and never dilute, reinterpret or ignore the principle. Changing the principle itself is a separate amendment with the constitution skill.
- **Only what is there.** A missing section is a finding. Never invent its content.
- **Same input, same output.** A rerun on unchanged artifacts gives the same findings, IDs and counts.
- **Specific findings.** Cite the instance, not a generic pattern.

## 1. Load

- Find the feature per "Finding the feature" in conventions. The analysis needs the spec, the plan and the tasks. If one is missing, name it and the skill that writes it (specify, plan or tasks), and stop.
- Read the constitution per conventions.
- Load only what the passes need.
  - From the spec, read the overview, User Scenarios & Testing, Functional Requirements, Success Criteria, Edge Cases and Key Entities.
  - From the plan, read the technical context and constraints, the architecture and stack choices, the data model, the phases and Repo Impact.
  - From the tasks, read the IDs, descriptions, phases, `[P]` markers, file paths and repositories.

## 2. Build inventories

Keep these inventories to yourself, and don't print the raw artifacts.

- **Requirements.** List every FR- item, plus the SC- items that need buildable work, such as a load-test setup or an audit log. Skip post-launch outcomes and business KPIs such as "cut support tickets by half". Key each one by its ID.
- **User stories.** List each story with its acceptance scenarios.
- **Task map.** Map each task to the requirements or stories it serves, using explicit IDs or clear key phrases.
- **Constitution rules.** List each principle's MUST and SHOULD statements.

## 3. Detection passes

Report at most 50 findings, with the most important first. Summarize the rest in one overflow line by category.

- **Duplication (DU).** Find near-duplicate requirements, and mark the weaker wording for merging.
- **Ambiguity (A).** Find vague adjectives with no measure, such as "fast", "scalable", "secure", "intuitive" or "robust". Find placeholders such as TODO, TKTK, ???, `<placeholder>` or an unresolved `[NEEDS CLARIFICATION]`.
- **Underspecification (U).** Find requirements that have a verb but no object or measurable outcome, stories without acceptance scenarios, and tasks that name files or components the spec and plan never define.
- **Constitution (C).** Find any requirement, plan element or task that conflicts with a MUST. Find sections or quality gates the constitution requires that the artifacts lack.
- **Coverage (G).** Find requirements with no task, tasks with no requirement or story, and buildable success criteria (performance, security, availability) with no task.
- **Inconsistency (I).** Find one concept named differently across files, and entities in the plan but not the spec or the reverse. Find task order that contradicts dependencies, such as an integration task before the setup it needs. Find conflicting requirements or technology choices.
- **Repos (R).** Run this pass only when the plan changes more than one repository.
  - Find a repo in Repo Impact that no task touches, or a task in a repo the plan doesn't list.
  - Find task order that contradicts the Order and Depends on columns of Repo Impact. For example, a `web` task that needs a new `api` endpoint is scheduled before the `api` task.
  - Find a contract change with no task in a repository that consumes the contract.
  - Find follow-on work the constitution requires for cross-repo changes, such as docs or client libraries, that has no task.

Number the findings by category letter, as in DU1, A1, A2 and U1.

## 4. Assign severity

- **CRITICAL.** The finding violates a Ratified MUST (a Draft conflict is at most MEDIUM, per "What gates"), a core artifact or required section is missing, or a requirement with no task blocks baseline functionality.
- **HIGH.** Requirements duplicate or conflict, a security or performance attribute is ambiguous, an acceptance criterion can't be tested, or a repo the plan changes has no task.
- **MEDIUM.** Terminology drifts, non-functional work has no task, or an edge case is underspecified.
- **LOW.** The wording is weak, or a minor redundancy doesn't affect execution order.

## 5. Report

Print the report in the reply, following `references/analysis-template.md`. Don't write it to a file or doc. The analysis is read-only, the report goes stale with the next edit, and a rerun regenerates it. If there are no findings, print the success form with the coverage numbers.

## 6. Next actions

End the report with the next actions.

- **CRITICAL findings.** Say that they block implementation. Implement only after the findings are resolved, or if the user explicitly overrides.
- **Only MEDIUM or LOW findings.** Say the user may proceed, and list the improvements worth making.
- For each fix, name where it happens: the specify, clarify, plan or tasks skill, or a direct edit to a named section. Once tasks exist, route spec fixes through the refine skill.

## 7. Offer fixes

Ask "Do you want concrete edits for the top <N> findings?" and don't apply anything yet.

If the user agrees, show each edit with its artifact, section, current text and proposed text. Apply only the edits the user approves, keeping IDs per "IDs and markers" in conventions. Then suggest a rerun of the analysis.
