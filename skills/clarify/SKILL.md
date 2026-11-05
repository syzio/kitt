---
name: clarify
description: Finds the gaps that matter in a feature spec or in any document being built together, or grills the user on an open-ended plan, design or idea. Asks targeted questions in rounds, each with a recommended answer, and records the answers after each round. Use when the user says "clarify", "clarify the spec", "interview me", "grill me", "grill me on this idea", "grill me on this plan", "ask me questions", "go through the open questions" or "what's still unclear", when a spec has [NEEDS CLARIFICATION] markers or vague requirements before planning, or when building a licence, policy, contract, runbook or config together by question and answer.
---

# Clarify

Read `references/conventions.md` and `references/writing.md` first.

The coverage categories are in `references/taxonomy.md`.

Find the questions whose answers change the outcome. Ask them in rounds, grouped by topic, each with a recommended answer. Record the answers after each round.

## 1. Load

- **Spec mode.** The target is the active feature's spec, found per conventions. Read the constitution too. Anything it already decides is not a question. If there is no spec yet, suggest the specify skill and stop. If `plan.md` or `tasks.md` exists, hand the answers to the refine skill instead of editing the spec, per "Changing a spec after planning" in conventions.
- **Document mode.** The target is any other document the user points at, such as a licence, policy, contract, runbook, config or proposal. It may be a file, a doc, or a draft in the conversation.
- **Grill mode.** The target is an open-ended plan, design or idea, with no spec or document needed, as in "grill me on this idea". The goal is a shared understanding, not a finished artifact. Grill mode changes some steps below, and each change is marked.
- If the user skips clarification on purpose, for example for an exploratory spike, proceed. Warn once that the risk of rework goes up.

## 2. Scan coverage

Mark each category of the matching list in `references/taxonomy.md` as Clear, Partial or Missing. In grill mode, map the decision tree instead: each decision branches into the decisions that hang off it. The constitution may add coverage categories for its domain, and you scan those too. Keep the map to yourself, and show it only when no question is needed.

A Partial or Missing category becomes a candidate question only if the answer changes one of these:
- in spec mode, the architecture, data model, task breakdown, test design, UX behavior, operations or compliance;
- in document mode, what the document allows, requires, forbids or commits someone to;
- in grill mode, what gets built or done, how, for whom, or whether at all.

Skip questions the artifact already answers, style preferences, and details of how to build it. Tech-stack choices belong to the plan unless they block functional clarity.

Facts are your job, and decisions are the user's. If a candidate can be answered from the code, the repository's docs, the constitution or the artifact itself, look it up and record what you found as an assumption instead of asking. In Claude Code, use a subagent for a broad search, and keep asking about the topics that don't wait on it.

If no candidate remains, say "No critical ambiguities worth a formal question.", show a compact coverage table, and suggest the next step.

## 3. Group and order

1. **Group by topic.** A topic is one coverage category, or one decision together with the choices that hang off it. Each candidate belongs to exactly one topic.
2. **Order by dependency.** A question that depends on another open question waits until that one is answered, per "Working rhythm" in conventions.
3. **Rank the ready questions** by impact × uncertainty. For example, one open security question outranks two cosmetic ones. Prefer questions that prevent rework or a wrong acceptance test. Each question must clear the impact bar on its own. A high-impact topic does not carry its weaker questions along.
4. **Build the round** from the top-ranked ready questions, at most five, grouped by topic. Take at most three from any one topic, so the session reaches more categories. Never add a low-impact question to fill the round. Never reveal the queue.
   - **Grill mode.** Ask the whole ready frontier each round: every open decision whose prerequisites are settled, with no cap per round or per topic. Dependency order still applies.

## 4. Ask one round

Open each topic in the round with one line naming it. Number the questions Q1, Q2 and so on. Each question has this shape:

1. `**Question:** <a full question ending in ?>`. It must make sense on its own. Never use a topic label, heading or requirement ID as the question. An ID may follow the `?` in parentheses, as in `**Question:** <question>? (FR-004)`.
2. One plain sentence on why it matters.
3. `**Recommended:** <option> - <reason in one sentence>`. Choose it for best practice, lower risk, and fit with the constitution and the artifact.
4. Mutually exclusive options per "Asking questions" in conventions. Outside the question tool, show a short table.

   | Option | Description |
   |--------|-------------|
   | A | <option> |
   | B | <option> |

5. When no discrete options fit, give `**Suggested:** <answer> - <reason>` instead, and ask for an answer of five words or fewer. In grill mode, the question may stay open for the user to answer in their own words. Still give a suggested answer.

Use everyday words, and define any jargon in the same sentence. Word each question so that "yes" accepts the recommendation. A reply of "yes", "recommended" or "suggested" accepts every recommendation in the round, and a reply such as "Q1 yes, Q2 B" answers them one by one. If a reply is ambiguous, ask a quick follow-up on that question only. The follow-up doesn't count as a new question.

## 5. Write the answers in after each round

After each round, and before the next one, do these steps for every accepted answer.

1. **Log it.** Make sure `## Clarifications` exists just after the overview section, with `### Session YYYY-MM-DD` for today. Add `- Q: <question> → A: <answer>`.
2. **Apply it.** Put the answer in the section it affects.
   - Behavior goes in Functional Requirements.
   - Roles and flows go in User Scenarios & Testing.
   - Data goes in Key Entities.
   - A quality attribute goes in Success Criteria as a measurable target.
   - A failure path goes in Edge Cases.
   - A terminology fix applies everywhere, with `(formerly "<old term>")` added once.
3. **Replace contradictions.** Rewrite any statement the answer contradicts, and never leave both versions. Remove the `[NEEDS CLARIFICATION]` marker the answer resolves.
4. **Save.** Save the file or doc, so nothing is lost if the conversation stops. Don't reorder unrelated sections. Add no headings besides the two above.

Then check that the log has one line per answer, that no contradiction or vague placeholder the answer resolved is left, and that the artifact uses one term throughout.

In document mode, put each answer in the section it affects, and keep a Clarifications log where the document has room for one. If the draft lives only in the conversation, keep a running list and show the full revised draft at the end, or offer to make it a doc first.

In grill mode, keep a running list of resolved decisions in the reply. Write it to a doc or file only if the user wants one.

## 6. Stop

After each round, recompute what is ready. An answer may settle other candidates, make new questions ready, or open a new branch of the topic.

Stop when no high-impact question remains, when the user says done, stop or proceed, or after ten questions in the session. If high-impact topics remain after ten, name them and offer another session. Never pad a round with low-impact questions.

In grill mode, there is no question limit. Keep going until the decision tree is empty, with every branch visited and nothing silently assumed, or until the user stops. Then check that you share the same understanding. Restate the resolved decisions in a short list, and ask the user to confirm or correct them. Don't act on the plan until they confirm.

## 7. Re-check spec quality

This step is for spec mode only. The feature may have a spec quality checklist in `checklists/requirements.md` or in its section of the Checklists tab. If it does, re-evaluate each item against the updated spec. Toggle only the markers whose state changed, and change nothing else. Note the counts before and after, the newly passing items and the regressions.

## 8. Report

The reply gives:
- the number of questions asked and answered, the file path or doc link, and the sections touched;
- the spec quality count before and after, if step 7 ran, and the items still unchecked;
- a coverage table that marks each category with one status;
  - Resolved means it was Partial or Missing and is now answered.
  - Deferred means it is over the session limit or belongs to the plan.
  - Clear means it was already sufficient.
  - Outstanding means it is still Partial or Missing but low impact.
- the next step, which is another round or the plan skill. If Deferred or Outstanding items remain, say whether to plan now or settle them first. After the plan exists, changes go through the refine skill.

In grill mode, the report is the confirmed list of decisions and any branches the user chose to leave open. Then suggest the next step. For something to build, pass the list to the specify skill as the feature description. For a decision still in doubt, pass it to the assess skill as the intake.
