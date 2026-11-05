# Principles pool

These are general engineering principles that the constitution skill can offer as candidates. None of them is a decision of the user. Offer an entry only as a Leaning candidate, and only when its "Applies when" line fits what the project has stated. Reword its rules with the project's own names.

Other skills may cite an entry as advice, per conventions. An entry gates work only after the user ratifies it in the constitution.

Each entry has a name, an "Applies when" line, one to three rules a reviewer can check against a spec, plan or code, and a one-line why.

## Design

### Validate at the boundary

Applies when the system takes input from users, files, config, the network or other services.

- Code that receives outside input MUST parse it into typed domain values where it enters, and reject it there if it is invalid. Outside input includes requests, CLI arguments, config files, environment variables and external API responses.
- Code behind the boundary SHOULD NOT re-validate data that the boundary already parsed.
- Business logic SHOULD live in functions with no framework, transport or storage dependency. Public interfaces MUST NOT expose transport, storage or framework types.

Why: one checked entry point is easier to trust and test than checks spread through the code.

### Model the domain in data structures

Applies when a feature holds state, has a lifecycle, or branches on the same condition in several places.

- A plan SHOULD define the core types, the data shapes and how code reads them before it defines the logic that uses them.
- A lifecycle with more than two states SHOULD be one explicit state machine or tagged union, not several flags that must stay in sync.
- Code that branches on the same kind of value in more than one module SHOULD move that branching into one type, lookup table or registry. Local code that is not expected to grow is exempt.

Why: a structure that matches the domain makes invalid states impossible and removes branches, and adding it later takes a refactor that teams postpone.

### Let the type system reject invalid states

Applies when the project uses a statically typed language.

- Values that share a primitive type but mean different things, such as a user ID and an order ID, SHOULD have distinct types.
- When a schema owns a shape, its types MUST be generated or derived from that schema, not written by hand in parallel. API specs, database migrations and protocol definitions are such schemas.
- Branches over a closed set of variants SHOULD be exhaustive, so that a new variant fails the build until every branch handles it.

Why: the compiler catches every time what review and tests catch only some of the time.

### Minimize reader load

Applies when people other than the author review or maintain the code.

- A wrapper, adapter or interface with one caller or one implementation SHOULD be inlined, unless the plan names the second one.
- A layer that passes the same methods and arguments through to the next layer SHOULD be removed.
- Mutable state SHOULD have the narrowest scope that works. Prefer locals to fields, fields to module state, and module state to globals. Code SHOULD compute derived values instead of keeping copies in sync.

Why: maintainability is the number of layers a reader must trace and the amount of state they must keep in mind.

## Change and migration

### Subtract before you add

Applies when a change adds to, refactors or rewrites existing code.

- A plan that builds in an area SHOULD first remove that area's dead code, unused options and stub references, as its own step.
- A change SHOULD contain only what the spec requires. Each validator, parser, guard or option needs a requirement or an observed use behind it.
- A decision such as a mode, a feature check or a limit SHOULD be made in one place and passed on as a value, not repeated at each use.

Why: each removal makes the next change smaller and easier to review.

### Redesign around a new requirement

Applies when a new requirement changes an assumption that the existing design was built on.

- The plan MUST describe the design as if the new requirement had been known from the start, and list the existing parts it changes.
- The change MUST update every reference to the changed design, including types, docs, examples and rationale sections.
- The team SHOULD deliver the redesign in increments that each work on their own.

Why: a requirement added onto a design that did not expect it leaves special cases that every later change must handle.

### Migrate callers, then delete the old API

Applies when an internal API is replaced, no external user depends on the old one, and the project can take a coordinated breaking change.

- Work that introduces a replacement internal API MUST migrate every caller and delete the old API within the same spec or task list.
- The change MUST NOT add compatibility layers for internal callers unless the plan names an external user who needs them.
- Tests SHOULD assert the new contract. Tests that only protect the old implementation SHOULD be deleted.

Why: an old API kept next to its replacement gets new callers, and nobody removes it later.

### Converge on the end state in planned migrations

Applies when a planned rewrite or migration has explicit phases.

- The plan MUST name each phase in which breakage is allowed, what may break, and how to revert it.
- The team SHOULD NOT write temporary compatibility code only to keep intermediate phases fully working.
- Checks for the areas under change MUST keep running during the migration. The full static and runtime checks MUST pass when the plan completes.

Why: compatibility code written for intermediate states tends to stay after the migration ends.

### Sequence work into verifiable units

Applies when work has several steps, such as a migration, a sweep of similar edits, or a stack of commits.

- Each task SHOULD end in a state with a named check, and the next task MUST NOT start until that check passes.
- Shared foundations such as CI, linting, test setup and shared types SHOULD come before the features that use them. A bug fix SHOULD land after a test that fails without it.
- Each commit or pull request SHOULD build and pass its checks on its own, in an order a reviewer can replay.

Why: a break found at the step that caused it is cheap to locate, and a break found after a batch sits under all the later work.

### Build the lever

Applies when work is not trivial: a sweep of edits, a migration, an analysis, a check, or a verification that a reviewer must be able to repeat.

- Non-trivial work SHOULD come from a tool that does it or proves it, not from hand work. Use a codemod or script for edits, a generator for repeated files, a query or script for analysis, and a check that can be rerun for verification. The tool is committed or linked with the change.
- The author SHOULD do the first case by hand, then check the tool against it before running it on the rest. The tool SHOULD be safe to rerun, and SHOULD be the smallest script that does the job.
- When several agents or people share the work, the recipe, its check and the files they must not touch SHOULD live in one written artifact they all read.

Why: a reviewer can read and rerun a tool, but can only check hand work by redoing it.

## Verification

### Prove it works on the real thing

Applies when any task is reported done.

- A task MUST NOT be marked done until someone checks its result directly, by running the feature, reading the actual value or inspecting the diff. A build that compiles or a report from whoever did the work does not count.
- A check SHOULD read the source of truth, such as the running process or the stored value, not a cache, a timestamp or derived state.
- Where a check can be scripted, it SHOULD be a script whose output stays where a reviewer can rerun it.

Why: work checked only through a proxy has unknown correctness, and acting on a wrong inference costs more than the check.

### Test behavior, not implementation

Applies when someone writes, changes or keeps a test.

- A test MUST assert what users of the code can observe. That means return values, errors, state they can read back, and effects on outside systems such as a request sent or a row written.
- A test MUST fail when the behavior breaks and SHOULD keep passing when only the internals change. A test that fails neither way, or only on a refactor, SHOULD be rewritten or deleted.
- Expected values MUST come from the requirement, not from a run of the code under test.

Why: a test tied to internals breaks on every refactor and still catches no bug.

### Explain the number

Applies when a decision rests on a measurement such as latency, throughput, a speedup or an evaluation score.

- Before a measurement runs, the plan or notes MUST state which result would change the decision and how much run-to-run noise to expect.
- A reported number MUST come with its run count, its run-to-run spread, and the resource that limits it, taken from a profile or system counters. Typical limits are CPU, a lock, disk, network or the load generator.
- The report SHOULD list what else the number could be measuring, such as errors, cached or skipped work, code that never ran, or an untuned baseline. It SHOULD give the evidence that rules out each one.

Why: a number without its spread and its limiter may measure something other than the work.

### Fix root causes

Applies when someone fixes a bug.

- A bug fix MUST name the first place the system went wrong and fix it there. A guard, retry, swallowed error or clamped value at the symptom counts as a fix only when the state it handles is legitimate.
- The fix SHOULD cover every place with the same fault, not only the reported one.
- After two fixes that share one assumption have failed the same check, the next fix MUST NOT start until someone writes that assumption down and tests it directly.

Why: a symptom fix hides the evidence and lets the fault appear somewhere else.

### Encode recurring rules as checks

Applies when the same review comment or correction comes up more than once.

- A rule that reviewers have restated twice SHOULD become a lint rule, type, test, runtime check or script that fails without a reviewer.
- A rule that needs judgment and cannot be automated SHOULD come with an example of the failure it prevents.
- When an automated check enforces a rule, the written instruction that duplicates it SHOULD be removed.

Why: a check enforces the rule every time, while an instruction depends on someone remembering it.

## Operations

### Make operations idempotent

Applies when commands, jobs, lifecycle steps or processing loops can crash, restart or be retried.

- Every state-changing operation MUST reach the same end state whether it runs once, runs twice, or follows a run that stopped at any point.
- A step SHOULD read the current state, compare it with the goal and apply only the difference. It SHOULD NOT replay what an earlier run meant to do.
- The next run MUST be able to recognize as stale anything a run leaves behind, such as a lock, a temporary file, a half-written record or a claimed job. For example, write to a temporary path and rename it into place.

Why: if partial state changes the next run's outcome, someone has to debug every restart.

### Separate before serializing shared state

Applies when concurrent workers, processes or users might write the same file, key, record or branch.

- The design MUST state, for each piece of mutable state that more than one actor writes, why they need the same object.
- Actors that publish independent facts SHOULD each own their own file, key or record. Their results merge only where they are read.
- When one shared writer is a real requirement, a structure MUST serialize access, not a convention or a document. Locks, a single-writer process, compare-and-swap and sequential phases are such structures.

Why: concurrent writes cause intermittent races that are hard to reproduce and expensive to debug.

## Product

### Experience first

Applies when scope, UX or API trade-offs come up. The user is whoever consumes the work, such as an end user, a developer calling an API, or the next maintainer.

- Every feature, control and option in a spec MUST name the user need it serves.
- When implementation convenience conflicts with the user's experience, the plan SHOULD choose the experience and record the trade-off.
- A spec SHOULD cover the details users meet, including error states, empty states, feedback and transitions. It SHOULD cut scope rather than ship features without them.

Why: users judge the product by the details they meet, and a few finished features serve them better than many unfinished ones.

### Compare options for novel decisions

Applies when a UI interaction or architecture decision has no precedent in the codebase, or depends on how it feels to use.

- The plan MUST compare at least two prototypes or options side by side before committing, and record why the chosen one won.
- Prototypes SHOULD be throwaway code, kept out of the production codebase.

Why: a design decision is cheaper to change in a prototype than in production code.
