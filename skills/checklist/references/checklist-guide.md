# Writing requirement-quality checklist items

If the spec is code written in English, the checklist is its unit-test suite. Each item tests whether the requirements are complete, clear, consistent, measurable and ready to build. It never tests whether the implementation works.

## Wrong vs right

| Wrong: tests the implementation | Right: tests the requirement |
|---|---|
| Verify the password reset email arrives | Is the delivery time for the password reset email specified? [Clarity, Spec §SC-002] |
| Test that the reset link expires | Is the reset link's lifetime defined, and what the user sees after it expires? [Completeness, Spec §FR-004] |
| Confirm the CSV export downloads | Are loading, empty and error states specified for the CSV export? [Gap] |
| Check that large exports work | Is a maximum export size defined, with the behavior above it? [Edge Case, Gap] |
| Verify notification settings save | Is the behavior defined when two devices change notification settings at once? [Coverage, Spec §FR-009] |

## Prohibited

These make an item an implementation test:

- starting with "Verify", "Test", "Confirm" or "Check" followed by system behavior;
- code execution, user actions or system behavior ("click", "navigate", "render", "load", "execute");
- "displays correctly", "works properly", "functions as expected";
- test cases, test plans or QA procedures;
- implementation details: frameworks, APIs, algorithms.

## Item patterns

- Are [requirement type] defined for [scenario]?
- Is [vague term] quantified with specific criteria?
- Are requirements consistent between [section A] and [section B]?
- Can [requirement] be objectively measured?
- Are [edge cases or scenarios] addressed in the requirements?
- Does the spec define [missing aspect]?

## Categories

Group items under these headings, in this order, and skip any with no items:

1. **Requirement Completeness**: are all necessary requirements written down?
2. **Requirement Clarity**: is each requirement specific and unambiguous?
3. **Requirement Consistency**: do requirements agree with each other?
4. **Acceptance Criteria Quality**: are the success criteria measurable?
5. **Scenario Coverage**: are primary, alternate, exception, recovery and non-functional flows addressed?
6. **Edge Case Coverage**: are boundaries, empty states and concurrency defined?
7. **Non-Functional Requirements**: are performance, security, accessibility and observability specified?
8. **Dependencies & Assumptions**: are they documented and validated?
9. **Ambiguities & Conflicts**: what needs clarification?

## Examples by quality dimension

- Completeness: "Are error handling requirements defined for every way the export can fail? [Gap]"
- Clarity: "Is 'fast export' quantified with a time limit for a stated file size? [Clarity, Spec §SC-001]"
- Clarity: "Are the rules for 'inactive account' explicitly defined? [Ambiguity, Spec §FR-006]"
- Consistency: "Do the notification channels listed in §FR-002 match those in §FR-008? [Consistency]"
- Coverage: "Are requirements defined for a user with no notifications enabled? [Coverage, Edge Case]"
- Coverage: "Are requirements specified for an export that fails halfway? [Coverage, Exception Flow]"
- Measurability: "Can 'easy to find' for the settings page be objectively verified? [Measurability, Spec §SC-004]"

## Scenario classes

For each class (primary, alternate, exception or error, recovery, non-functional), ask whether its requirements are complete, clear and consistent. If a class is missing, ask: "Are [class] requirements intentionally excluded or missing? [Gap]". Where an operation changes state, ask about recovery: "Are rollback requirements defined if [operation] fails halfway? [Gap]".

## Traceability

- At least 80% of items include a reference: `[Spec §<ID or section>]`, `[Plan §<section>]`, `[Constitution §<principle>]`, or a marker: `[Gap]`, `[Ambiguity]`, `[Conflict]`, `[Assumption]`, `[Dependency]`.
- Put the quality dimension first in the brackets: `[Clarity, Spec §FR-003]`.
- If the spec has no ID scheme, add: "Is an ID scheme established for requirements and acceptance criteria? [Traceability]".

## Surfacing problems

- Ambiguity: "Is 'recent' quantified for the activity list? [Ambiguity, Spec §FR-003]"
- Conflict: "Do §FR-010 and §FR-012 agree on who may change another user's settings? [Conflict]"
- Assumption: "Is the assumption that the email service is always available validated? [Assumption]"
- Dependency: "Are the requirements on the external email service documented? [Dependency, Gap]"

## Consolidation

- Soft cap of 40 items. Over that, rank by risk and impact.
- Merge near-duplicates that check the same aspect of a requirement.
- Fold more than five low-impact edge cases into one item: "Are edge cases X, Y and Z addressed in the requirements? [Coverage]".

## Sample items by domain

**UX** (`ux.md`)
- Are interaction states (hover, focus, active, disabled) defined consistently? [Consistency]
- Are accessibility requirements specified for every interactive element? [Coverage, Gap]
- Is fallback behavior defined when an image fails to load? [Edge Case, Gap]

**API** (`api.md`)
- Are error response formats specified for every failure scenario? [Completeness]
- Are rate limits quantified with specific thresholds? [Clarity]
- Are retry and timeout requirements defined for external dependencies? [Coverage, Gap]
- Is the versioning strategy documented? [Gap]

**Performance** (`performance.md`)
- Are performance targets defined for every critical user journey? [Coverage]
- Are requirements specified under different load conditions? [Completeness]
- Are degradation requirements defined for high load? [Edge Case, Gap]

**Security** (`security.md`)
- Are authentication requirements specified for every protected resource? [Coverage]
- Are data protection requirements defined for sensitive information? [Completeness]
- Is the threat model documented, and do the requirements follow from it? [Traceability]
- Are breach response requirements defined? [Gap, Exception Flow]
