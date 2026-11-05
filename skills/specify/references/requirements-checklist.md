# Requirements quality checklist

Run this silently after drafting a spec and after every update. Write the result to `checklists/requirements.md` in the feature folder, or to the Checklists tab in chat. Check an item only when it passes. Leave items that need the user's input to the clarify skill.

```markdown
# Specification Quality Checklist: [FEATURE NAME]

**Purpose**: Validate specification completeness and quality before proceeding to planning
**Created**: [DATE]
**Feature**: [Link to spec.md or the Spec tab]
**Score**: [passed]/16 after [1-3] passes

## Content Quality

- [ ] CHK001 No implementation details (languages, frameworks, APIs, schemas)
- [ ] CHK002 Focused on user value and business needs
- [ ] CHK003 Written for non-technical stakeholders
- [ ] CHK004 All mandatory sections completed

## Requirement Completeness

- [ ] CHK005 No [NEEDS CLARIFICATION] markers remain
- [ ] CHK006 Requirements are testable and unambiguous
- [ ] CHK007 Success criteria are measurable
- [ ] CHK008 Success criteria are technology-agnostic (no implementation details)
- [ ] CHK009 All acceptance scenarios are defined
- [ ] CHK010 Edge cases are identified
- [ ] CHK011 Scope is clearly bounded
- [ ] CHK012 Dependencies and assumptions identified

## Feature Readiness

- [ ] CHK013 All functional requirements have clear acceptance criteria
- [ ] CHK014 User scenarios cover primary flows
- [ ] CHK015 Feature meets measurable outcomes defined in Success Criteria
- [ ] CHK016 No implementation details leak into specification

## Notes

- [For each unchecked item: the item ID, the spec text that fails it, and what would fix it]
- Items marked incomplete require spec updates before clarify or plan.
```
