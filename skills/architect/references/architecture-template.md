# Architecture template

`architecture.md` holds the sketch and its rationale in one file. Keep the headings. Replace each italic note with content. Keep the prose to about a page, plus the code blocks.

```markdown
# Architecture: <feature or change name>

**Source**: <the feature folder's plan.md, or the change the user named> | **Mode**: <single pass | N sketches> | **Status**: <Leaning | Decided>

## Problem

*One paragraph. Say what we are trying to do, and what about the existing system or its constraints makes the shape non-obvious. Name the constraints the design must honor, such as existing types it must work with, callers it can't break, and invariants that cross its boundary.*

## Systems touched

*One bullet per system or module the new code touches, with `file:line` references and one line on what the design must respect there. Write "Greenfield, nothing to integrate" if that is the case.*

## Usage (caller's view)

*Write this first, before the shape. Show the README or quickstart the consumer reads, plus two or three realistic call sites in their code. Show what they import, what they call, and what comes back. The sketch below is derived from this. When the two disagree, change the sketch to match the usage.*

## Shape

*The recommended architecture. Give the data structures first, then how data flows through the signatures. Name the decisions everything else depends on. Say which invariants the types encode, where validation happens, and what the system deliberately does not do. Judge interface depth. Say what complexity the public interface hides, what stays exposed to callers, and why the interface is no larger than it needs to be.*

### Module map

*One line per module or file, with its path, what it owns, and what it exposes.*

### Type sketch

*The types and signatures, with `not implemented` bodies and `// TODO` pseudocode for tricky logic, in the project's language.*

## Synthesis decision

*In several-sketch mode, give the rubric and each candidate's score per criterion. Say which candidate became the base and why, what was taken from each of the others, and what was rejected and why. In a single pass, write "Single pass."*

## Tradeoffs accepted

*One bullet per tradeoff, in the form "we accept X in exchange for Y". Name anything a future reader might mistake for an oversight, including things that look like premature optimization or premature simplification.*

## Alternatives considered

*Required. Give at least one concrete alternative shape, with one line on why it lost. Judge each on interface depth, not only on how simple it is to build. Name the complexity it exposes to callers and the complexity it hides. Two or three belong here when the design space had real contenders. One is fine when the constraints forced the answer, phrased as "this was the only viable shape because...". Don't list variants of the same shape. A scrapped earlier sketch goes here too.*

## Open questions and risks

*What the user needs to decide, and the risks to flag before implementation starts. Phrase each as a question, so the user's answer resolves it. Give each a decision status per conventions.*

## Next implementation step

*In one sentence, name the first thing to build against the sketch.*

## Deviations

*Filled in during check mode. One bullet per deviation, with the `file:line`, what differs from the sketch, and whether the sketch was wrong, a requirement was missed, or the implementation does more than it should.*
```
