# Assessment templates

An assessment has two parts. The Assessment part answers the question on its own. The Research part holds the evidence, which a reader opens separately. In a repository the parts are `assessment.md` and `research.md`. In Docs they are the tabs Assessment and Research. In quick mode, write only a compact Assessment part, with the key evidence and links inside it. Keep the headings. Drop a section that doesn't apply instead of writing "N/A".

## Assessment

```markdown
# Assessment: <topic>

<Lead sentence: the verdict or recommendation and the decisive reason. Before the decide stage: "In progress: <stage>.">

## Verdict

Build-idea: **go | needs-clarification | kill**, or
option-choice / research question: **Recommendation: <option or conclusion>**, proposed status **Leaning | Open | Research**.

| Criterion | Rating | Justification |
|---|---|---|
| Problem validity | strong / adequate / weak / unknown | <one line, from Problem and Research> |
| Evidence strength | | <one line, from Research> |
| Value vs doing nothing | | <one line, from Problem> |
| Feasibility / appetite | | <one line, from Options> |
| Strategic fit | | <one line: which constitution principles it serves or strains> |
| Risk posture | | <strong = key risks known and mitigated; weak = serious unmitigated risk> |

If needs-clarification:
- Blocking: [NEEDS CLARIFICATION: <question>] (one line each)
- Revisit stage: intake | research | define | shape

If go, handoff to the specify skill:
- Problem: <one line>
- Chosen approach: <option>
- In scope / out of scope: <summary>
- Success metrics: <summary>
- Open questions carried forward: <list>

## Options

Recommended: <letter> because <reason tied to the goals and metrics>, or "none, because <reason>".

| Option | How it works | Appetite | Trade-offs | Rabbit holes |
|---|---|---|---|---|
| A: smallest thing that could work | | small | | |
| B: <name> | | medium | | |
| C: do nothing, or buy instead of build | | | | |

Out of scope for the recommended option: <list, including the non-goals>

Assumptions the recommendation depends on: <list>

## Problem

- Problem: <one sentence, in the problem space>
- Who has it: <users, customers, the team>
- Goals: <list>
- Non-goals: <list>
- Success metrics: <measurable, with numbers and a baseline>
- Cost of doing nothing: <what happens if we don't act>
- Constraints: <constitution principles that apply, deadlines, budget>

## Intake

- Question: <one sentence>
- Type: build-idea | option-choice | research question
- Slug: <kebab-case>
- Idea type: new capability | improvement | compliance | cost saving | other (build-ideas only)
- Raised by and trigger: <who raised it, and what prompted it>
- Raised from: <chat, doc, ticket, link>
- Stakeholders with decision power: <names or roles>
- What the user already knows or prefers: <list>
- First-glance unknowns: <list>
- Stages skipped / inputs used: <stage and the input that replaced it, or "none">
```

## Research

```markdown
# Research: <topic>

Overall evidence confidence: **high | medium | low**, because <one line>.

| Finding | Source | Confidence | Bears on |
|---|---|---|---|
| <claim in one line> | [<page name>](<url>) or ASSUMPTION | high / medium / low | for / against / context |

## Prior art

<Internal decisions, competing products, open-source options, past attempts: what worked, what failed and why.>

## Evidence against

<Always present. If none was found, say so and list where you looked.>

## Gaps

- [NEEDS CLARIFICATION: <what research could not settle>]

## Sources

<Pages actually opened, each as a link, with the date they were checked.>
```

## Rules for the content

- Every row in the findings table has a source link or the word ASSUMPTION.
- Paraphrase sources. Quote only when the exact wording matters, and keep quotes short.
- Ratings come from the evidence in the assessment, not from general impressions.
- Prefer primary sources: official documentation, regulators, standards, papers, filings.
- Record links and quotes per "Trust" in conventions.
