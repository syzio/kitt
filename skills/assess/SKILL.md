---
name: assess
description: 'Evidence-based assessment of an idea, a choice between options, or a research question, ending in a recorded verdict. Use whenever the user wants to research a decision before committing to it, even if they never say "assess": "is this worth building?", "should we build or buy?", "which of these should we pick?", "compare these approaches", "look into whether...", choosing a library, vendor, tool or architecture approach, or working through a compliance, risk or build-vs-buy question. Gathers evidence for and against with every claim cited or tagged ASSUMPTION, defines the problem, shapes two or three options including the smallest one and doing nothing, rates six criteria, and records go / needs-clarification / kill, or a recommendation with a proposed status. Runs quick (one pass) or full (one stage per turn). On go, hands a summary to the specify skill.'
---

# Assess

Read `references/conventions.md` and `references/writing.md` first.

Turn an idea or an open decision into a verdict you can defend before anyone specifies or builds it. Many assessments should end in "kill", "needs clarification" or a clear choice of option. A stop with a documented reason is a successful outcome. Assess writes no code and no spec.

The templates are in `references/templates.md`.

## Pick the mode

- **Quick.** Run one pass and write it in one go. Use it for a contained question, such as a library, tool or vendor choice.
- **Full.** Run stage by stage and stop for review after each stage. Use it for anything that meets the full-depth triggers in conventions or would be expensive to reverse.

Say in one line which mode you chose. The user can switch.

In full mode, the user can skip stages that aren't needed, for example start at define when the research already exists. Use what they give you as that stage's input, and record each skipped stage and the inputs used in the intake.

## Stages

1. **Intake.** Restate the question in one sentence and classify it as one of these.
   - A build-idea asks "should we build X?"
   - An option-choice asks "which of A, B or C?"
   - A research question asks "what is true about X?"

   Note the decision needed, the constraints from the constitution, and what the user already knows or prefers. For a build-idea, also note the idea type, such as new capability, improvement, compliance or cost saving. Note who raised it and what triggered it, the stakeholders with decision power, and the unknowns you see at first glance. If the input is a solution such as "build X", note the problem it seems meant to solve. Pick a slug per conventions. If the input is empty or holds no coherent idea, ask for it rather than invent one.
2. **Research.** Search the web and the user's own docs and decisions. In a repository, also search the code and `.specify/`. Cover the lenses that apply:
   - users and demand, separating stated wants from observed behavior
   - prior art, meaning internal decisions, competing products, open source, and past attempts with why they failed
   - market and regulation
   - data and benchmarks
   - feasibility

   For every finding, record the claim, its source link or ASSUMPTION, and a confidence of high, medium or low.
   - Open and read the pages you rely on. A search snippet is not a source.
   - Always write an "Evidence against" section. If you looked and found none, say so and say where you looked.
   - Never present an assumption as evidence, and never invent a citation.
   - Fetch, record links and quote inputs per "Trust" in conventions.
3. **Define.** Write the problem statement, who has the problem, the goals and non-goals, measurable success metrics with a baseline, the cost of doing nothing, and the constraints. Stay in the problem space, with no features or design. Mark any user or metric that the evidence doesn't support `[NEEDS CLARIFICATION: ...]`. If the evidence doesn't show a real problem, say so here rather than shape solutions for it.
4. **Shape.** Write two or three options that span the trade-offs. Always include the smallest thing that could work. Where it fits, include "do nothing" or "buy instead of build". For each option, give these.
   - The appetite is small (days), medium (weeks) or large (months). It is a budget, not an estimate.
   - Say how the option works at the boundary level.
   - List the trade-offs.
   - Name the rabbit holes, the parts most likely to blow up scope.

   Recommend one option, or recommend none. List the assumptions the recommendation depends on. Leave implementation design to the plan.
5. **Decide.** Rate six criteria as strong, adequate, weak or unknown. Give each a one-line justification from the stages above. The criteria are problem validity, evidence strength, value against doing nothing, feasibility and appetite, strategic fit with the constitution, and risk posture. Acknowledge every "unknown" rather than gloss over it. Then give the verdict.
   - **Build-ideas.** Choose one of three verdicts.
     - `go` needs problem validity of adequate or better, evidence strength of adequate or better, and a recommended option. Without all three, the verdict is `needs-clarification`.
     - `needs-clarification` names the blocking questions and the stage to revisit.
     - `kill` states the decisive reason plainly.
   - **Option-choices and research questions.** Recommend an option or conclusion and propose a status per conventions. Propose Leaning at most, since only the user makes something Decided. Weak or unknown evidence means Open or Research, with what would settle it.

## Write it

Store the assessment per conventions. In a repository that is `.specify/assessments/<slug>/`, in Docs the doc "Assessment: <topic>", and otherwise the reply.

- **Full mode.** Create the assessment from `references/templates.md`. Then fill one stage per turn and stop for review.
  - **Assessment part.** This is `assessment.md` or the Assessment tab. Put the verdict and scorecard first once they exist, then the options, problem and intake. Before the decide stage, the verdict section is one line that names the current stage.
  - **Research part.** This is `research.md` or the Research tab. It holds the findings table, prior art, evidence against, gaps and the sources you actually opened.
- **Quick mode.** Use the same structure in compact form: the verdict, the scorecard, the options table, and the key evidence with links. In a repository, always write it as one `assessment.md`, and summarize the verdict in the reply. In Docs, write it as one compact doc. Otherwise, answer in the reply only.

Never overwrite an existing assessment without the user's confirmation.

## After the verdict

- **go.** Hand the work to the specify skill with the handoff summary. The summary gives the problem, the chosen option, what is in and out of scope, the success metrics, and the open questions carried forward.
- **Option-choice.** Offer to record it where the user keeps decisions, such as a decision log or an ADR. Write it only after the user confirms the status.
- **needs-clarification.** Edit the existing assessment in place to resolve the gaps, or use the clarify skill. Then revise the scorecard and verdict. Keep the ASSUMPTION and source tags on new evidence. Rerun a whole stage only for a wrong slug or a discarded draft.
- **kill.** Do nothing further. The record stays for later reference.

## When not to use it

- If the decision is already researched and only needs recording, write an ADR.
- If the user asks a quick factual question, answer it directly.
