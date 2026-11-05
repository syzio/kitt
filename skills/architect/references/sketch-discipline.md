# Sketch discipline

These rules produce one candidate design: the usage, the type sketch, the function signatures, the module map, and the rationale in the shape of `architecture-template.md`. Architect follows them in a single pass. In the optional several-sketch mode, each subagent gets this file as its brief.

## If you are a subagent sketching one candidate

You produce one candidate design. Other subagents produce theirs independently. Make the best design you can. Don't move toward a middle design that looks safe, because the comparison depends on the differences between candidates. Return the candidate as text and edit no files. End it with a short rationale that names the alternatives you considered and why you rejected them.

## Rules

Apply these entries from `references/principles.md`: "Validate at the boundary", "Model the domain in data structures", "Minimize reader load", "Make operations idempotent" and "Separate before serializing shared state".

- **Caller's usage first.** Write the README-style usage and two or three realistic call sites before the types, then derive the type sketch from them. The usage is the spec. When the two disagree, change the sketch to match the usage, not the reverse.
- **Access patterns.** Trace each main access pattern through the core types. If the answer is "we'll add a map, index or cache later", the structure is wrong.
- **Interface depth.** Compare the capability hidden behind the public interface with the size of that interface. Prefer a simple interface that moves complexity into the callee, even when the implementation gets harder.
- **Visible boundaries.** Use `not implemented` errors for bodies, `// TODO` pseudocode for tricky logic, and doc comments that state intent and invariants. A reader should be able to trace data from input to output by reading the types and signatures alone.
- **Invariants in types.** Prefer types that are hard to misuse over runtime checks, and runtime checks over comments.
