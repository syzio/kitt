---
name: critique
description: 'Adversarial review of a feature spec, and of its plan if one exists, before planning or implementing. Attacks the premise, finds requirements that are wrong or missing, and plays hostile users and failing systems to find abuse cases, silent failures and compliance blind spots. Use when the user says "critique the spec", "red-team this spec", "red-team this plan", "poke holes in this spec", "how would someone abuse this", "is this the right thing to build", or before plan on a feature that handles money, credentials, personal data or permissions. Read-only: prints findings with IDs and severity in the reply and edits nothing without approval. Analyze checks that the artifacts agree with each other and clarify asks what the spec means. Critique asks whether the spec is right. For code, use interrogate or blast-radius.'
---

# Critique

Read `references/conventions.md` and `references/writing.md` first.

Argue against the spec before anyone builds it. Assume the spec is clear and consistent, and ask whether it is right: whether the problem is real, whether the requirements solve it, and what hostile users and failing systems will do to it.

## How critique differs

| Skill | Question it asks | Finds |
|---|---|---|
| clarify | What does the spec mean? | Vague terms, gaps, open choices |
| analyze | Do spec, plan and tasks agree with each other? | Conflicts, duplicates, requirements with no task |
| critique | Is the spec right, and what breaks it? | A weak premise, wrong or missing requirements, abuse cases, failure modes |

If the spec still has `[NEEDS CLARIFICATION]` markers, say that clarify should run first, and offer to go on anyway. If a finding is only vagueness or a mismatch between files, leave it to clarify or analyze.

## Rules

- **Read-only.** Never change the spec, plan, tasks or constitution during the critique. Edit only after the user approves specific fixes.
- **Concrete scenarios only.** Each finding tells a short story: who does what, what happens, and what it costs. Cut any finding that would fit another project unchanged, such as "consider security".
- **Evidence.** Each finding cites the spec or plan location it attacks, or the section where the missing requirement belongs.
- **The constitution wins.** A spec item that breaks a Ratified MUST principle is CRITICAL. Never propose weakening a principle.
- **Same input, same output.** A rerun on unchanged artifacts gives the same findings and IDs.
- At most 30 findings, most severe first. Summarize the rest in one overflow line by lens.

## 1. Load

- Find the feature per conventions. In chat, read the Spec tab and the Plan tab if it exists. The user may also paste a spec.
- If there is no spec, suggest the specify skill and stop.
- Read the constitution per conventions.
- From the spec, read the goal, the user stories and scenarios, the requirements, the success criteria, the edge cases, the key entities and the assumptions. From the plan, if it exists, read the technical context, the decisions, the data model, the contracts and Repo Impact.

## 2. Attack through each lens

Work through every lens. Skip a lens only when it can't apply, and say so in the report.

- **Premise (PR).** Is the problem real, and does the spec show evidence of it? If the spec cites an assessment, take its verdict as the premise evidence instead of re-assessing. Would a smaller change, an existing feature or no change solve it? Who loses when this ships? Do the success criteria measure the goal, or only activity?
- **Requirements (RQ).** Find requirements that solve the wrong problem, contradict the goal, or lock in a solution too early. Find actors, states and flows the spec forgot: the first-time user, the admin, the deleted account, the empty list, the second device, the user who stops halfway.
- **Abuse (AB).** Play a hostile actor who uses the feature exactly as specified. Look for enumeration, scraping, spam, fraud, replay, privilege escalation, access to another user's data, cost amplification and denial of service. Name what the attacker gains.
- **Failure modes (FM).** Play a failing system. Look for partial writes, retries that run twice, timeouts, races between two users, a dependency that is down or slow, clocks that disagree, and data that is too large or malformed. Prefer failures that are silent: the user sees success and the data is wrong.
- **Compliance (CO).** Look for personal data with no retention or deletion rule, consent, audit trails, accessibility, data location, and rules for money or age. Cite the rule only when you can name it. Otherwise state the risk and tag it `ASSUMPTION`.
- **Plan (PL).** Only when a plan exists. Find choices that are hard to undo, capacity the plan doesn't size, migrations with no rollback, and operational gaps such as no alert for the failure modes above.

Number the findings by lens: PR1, RQ1, RQ2, AB1, FM1.

**Subagents.** You may offer one subagent per lens, per "Subagents" in conventions, so one lens doesn't anchor another. Merge the results, drop duplicates, and keep the IDs stable.

## 3. Assign severity

- **CRITICAL.** The premise doesn't hold, a Ratified MUST principle is broken, or a scenario leads to loss of money or data, a security breach, or legal exposure in a P1 story.
- **HIGH.** A plausible abuse or failure harms users or the business. A core requirement is wrong or missing.
- **MEDIUM.** The harm is limited or unlikely, or the gap is in a secondary story.
- **LOW.** The finding is a hardening idea or a minor gap.

## 4. Report

Print the report in the reply. Don't write it to a file or doc. It goes stale with the next edit, and a rerun regenerates it.

```markdown
## Spec critique

**Feature**: [NNN-slug or doc link] · **Critiqued**: [DATE] · **Plan read**: [yes/no] · **Constitution**: [version, or "none"]

| ID | Lens | Severity | Location | Scenario | Impact | Recommendation |
|----|------|----------|----------|----------|--------|----------------|
| AB1 | Abuse | HIGH | spec.md FR-002 | An attacker requests resets for a list of emails and the different replies show which accounts exist | Account enumeration | Add an FR: the reply is the same whether or not the account exists |
| FM1 | Failure | HIGH | spec.md Edge Cases | The email service times out after sending and the retry sends a second link; both links work | Two valid tokens per request | Add an FR: a new link invalidates earlier ones |

[Overflow: N more findings not shown (AB: 2, FM: 1).]

**Decisions for the user:** [premise and scope questions only the user can settle, one line each]

**Lenses skipped:** [lens and reason, or "none"]

**Counts:** findings per lens, findings per severity
```

If there are no findings, say so, list the lenses checked, and say what the critique could not check, such as load or legal advice.

## 5. Next actions

- **CRITICAL findings.** Recommend settling them before plan or implement. Critique is advice and blocks nothing by itself, but a broken Ratified principle also fails the plan gate and analyze.
- For each fix, name where it happens: specify for spec edits before planning, refine once a plan or tasks exist, plan for a plan finding, clarify for a decision that needs questions, or the constitution skill for a principle.

## 6. Offer fixes

Ask "Do you want concrete edits for the top <N> findings?" and apply nothing yet.

If the user agrees, show each edit with its artifact, section, current text and proposed text. Apply only the edits the user approves. Follow "IDs and markers" in conventions. If a plan or tasks already exist, hand the approved spec edits to the refine skill, so the plan and tasks follow them. Then suggest a rerun of the critique or of analyze.
