---
name: architect
description: Sketches the types, function signatures and module structure of a change before any code is written, grounded in a real model of the systems the code touches, screens the sketch against design red flags, and records the rationale and rejected alternatives in architecture.md. Use between plan and implement on a feature, or on any non-trivial change where jumping to code would lock in the wrong shape. Trigger phrases include "architect this", "design this", "sketch the types first", "what shape should this take?", "module structure for this plan", and "check the build against the sketch". Can also check work in progress against the sketch and say when the sketch should be scrapped. Changes no production code, except type and signature stubs if the user asks for them. Needs a repository working tree.
---

# Architect

Read `references/conventions.md`, `references/writing.md` and `references/principles.md` first.

Sketch types, signatures, class shapes and module boundaries, with `not implemented` bodies and pseudocode, before anyone writes the code. Implementation then fills in the bodies and keeps the sketch's types and signatures.

Use `references/architecture-template.md` for the output, `references/sketch-discipline.md` for how to sketch, and `references/design-red-flags.md` to screen the result.

## Hard rules

- If no working tree is open, say that architect needs a repository and stop.
- Write only `architecture.md`. Never change production code. The one exception is type and signature stubs with `not implemented` bodies, and only if the user asks for them.
- Never modify `spec.md`, `plan.md`, `data-model.md`, `contracts/` or `tasks.md`. If the sketch shows that one of them is wrong, say so. If `tasks.md` exists, suggest refine. Otherwise suggest tasks.

## Pick the mode

- **Sketch.** There is no `architecture.md` yet, or the user asks for a new design. Run steps 1 to 5.
- **Check.** `architecture.md` exists and implementation has started, or the user asks to check the build against the sketch. Follow "Check mode".

## Inputs and output

- **Feature.** Find it per "Finding the feature" in conventions. Read `plan.md`, `data-model.md` and `contracts/`, plus `spec.md` for the user stories. If `plan.md` is missing, suggest the plan skill and stop. Write `architecture.md` in the feature folder.
- **A change with no feature.** Take the change the user names, pick a slug per conventions, and write `.specify/architecture/<slug>/architecture.md`.

## Steps

1. **Learn the systems.** Build a real model of every system the new code touches. Listing file names is not enough. Read the code paths end to end, and the existing types, interfaces and callers the design must work with. If the design changes who owns what or how layers stack, read the commit history and PR descriptions of the current shape, so that its reasons become constraints instead of guesses. Record the systems touched with `file:line` references. Skip this step only for greenfield work with no surrounding system. For an unfamiliar system, you may run the how skill first to explain it with `file:line` evidence.

2. **Sketch.** Follow `references/sketch-discipline.md`. Write the caller's usage first and derive the types from it. Produce at least two structurally different whole shapes, not point fixes inside one shape, even when the first looks good enough.

   **Optional, several sketches.** For a wide or hard-to-undo design, offer two or three sketcher subagents per "Subagents" in conventions. Before you start them, write a rubric of three to six criteria that a sketch can pass or fail on this task. Draw them from this skill's own tests:
   - The caller's usage reads naturally, and the types follow from it.
   - It raises no flag from `references/design-red-flags.md`, or fewer than the others.
   - It hides the most complexity behind the smallest public interface.
   - A change that looks right from one file is right for the whole repository.
   - It works with the existing types, callers and constraints from step 1.
   - It is cheap to change or undo if a requirement moves.

   Make each criterion specific to the task. Keep the rubric to yourself. Give each subagent the task, the notes from step 1, `references/sketch-discipline.md` and `references/principles.md`, and tell it to return its sketch as text and edit no files. Don't show any subagent another one's sketch.

3. **Screen and choose.** Screen every candidate against `references/design-red-flags.md`. Assume the next contributor is an agent that sees only the files it opened, copies the nearest example, and takes the shortest path that compiles. Prefer the design where a change that looks right from one file is right for the whole repository. Among the shapes that pass, prefer the one that hides the most complexity behind the smallest public interface. With several sketches, pick and graft:
   - Read every sketch in full. Score each one against the rubric, one criterion at a time, not by overall feel.
   - Pick the highest-scoring sketch as the base. On a tie, pick the one with the smaller public interface.
   - Read each other sketch once more for one or two strong ideas, and fold each one into the base by hand so the design stays coherent. Don't paste parts together.
   - If the sketches agree on one shape, say so and keep it with no graft. If they differ wildly, the task was unclear. Sharpen it with the user and sketch again rather than average the shapes.
   - Under Synthesis decision, record the rubric scores, the base and why it won, each graft with the sketch it came from, and what you rejected and why.

4. **Write architecture.md** from the template. Lean by default, per conventions. If the user asked for stubs, write them now, in the files the sketch names, with `not implemented` bodies.

5. **Stop for review.** Reply with the path, the chosen shape in one sentence, and the number of open questions. If `tasks.md` exists, name the tasks whose files or shapes the sketch changes, and suggest refine. Otherwise suggest tasks. If the user rejects the shape, treat the objection as a new constraint. Go back to step 1 and sketch again.

## Check mode

While implementation fills in the sketch, the code keeps the sketch's types and signatures. Report each deviation instead of working around it quietly. If a function needs a parameter the sketch didn't anticipate, ask whether the sketch was wrong, a requirement was missed, or the implementation does more than it should.

Compare the code with the sketch and append each deviation to the Deviations section of `architecture.md`, with its `file:line` and which of those three causes applies. Then look for the signs that the sketch is wrong. One instance is not enough. Look for a pattern:

- The same kind of workaround appears in unrelated code.
- Several unrelated edge cases each need a special-case branch.
- Types need escape hatches to compile, such as `any`, casts, or optional fields that are always set in practice.
- A lock seems needed where the sketch said the state wasn't shared.
- Callers must know the abstraction's internal rules to use it.
- Two or more independent deviations are the same kind of change.

Use judgment. A few edge cases don't condemn a design, and a problem with complex data can still have a simple design.

If the pattern is there, recommend scrapping the sketch, and do it only if the user agrees:

1. Learn the systems again from what has been built.
2. Redesign as if the new constraints had been known from the start. Don't add fixes to the wrong shape.
3. Remove before you add. The new sketch should be smaller than the old one before it grows.
4. Run steps 2 to 5 again. Move the old shape to Alternatives considered, with the reason it lost.
