# Feature spec template

Keep the section order and headings. Fill every mandatory section. Remove an optional section that doesn't apply rather than writing "N/A". At lean depth, keep every mandatory section and make each one shorter. Delete a section's HTML comments once you fill it.

```markdown
# Feature Specification: [FEATURE NAME]

**Feature Branch**: `[###-feature-name, or the last segment of a custom feature folder]`

**Created**: [DATE]

**Status**: Draft

**Input**: User description: "[the user's words]" | Assessment: [path or link]

## User Scenarios & Testing *(mandatory)*

<!--
  User stories are user journeys ordered by importance. Each one is independently testable:
  if you build only that story, it still delivers a usable slice of value.
  P1 is the most important, and P1 alone is the MVP.
-->

### User Story 1 - [Brief Title] (Priority: P1)

[Describe this user journey in plain language]

**Why this priority**: [The value, and why it outranks the others]

**Independent Test**: [How this story alone can be tested, e.g. "Can be fully tested by requesting a reset link and signing in with the new password; delivers account recovery"]

**Acceptance Scenarios**:

1. **Given** [initial state], **When** [action], **Then** [expected outcome]
2. **Given** [initial state], **When** [action], **Then** [expected outcome]

---

### User Story 2 - [Brief Title] (Priority: P2)

[Describe this user journey in plain language]

**Why this priority**: [The value, and why it has this priority]

**Independent Test**: [How this story alone can be tested]

**Acceptance Scenarios**:

1. **Given** [initial state], **When** [action], **Then** [expected outcome]

---

[Add more user stories as needed, each with a priority]

### Edge Cases

- What happens when [boundary condition]?
- How does the system handle [error scenario]?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST [specific capability, e.g. "send a password reset link to the account's email address"]
- **FR-002**: System MUST [specific capability, e.g. "expire a reset link after one use"]
- **FR-003**: Users MUST be able to [key interaction, e.g. "choose which columns a CSV export includes"]
- **FR-004**: System MUST [data requirement, e.g. "keep each user's notification settings across sessions"]

*Example of marking an unclear requirement (at most three markers in the whole spec):*

- **FR-005**: System MUST notify users through [NEEDS CLARIFICATION: channel not specified - email, in-app, or both?]

### Key Entities *(include if feature involves data)*

- **[Entity 1]**: [What it represents, key attributes without implementation]
- **[Entity 2]**: [What it represents, relationships to other entities]

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: [Measurable metric, e.g. "Users can reset their password in under 2 minutes"]
- **SC-002**: [Volume metric, e.g. "A CSV export of 100,000 rows is ready to download within 30 seconds"]
- **SC-003**: [User satisfaction metric, e.g. "90% of users change a notification setting on their first attempt"]
- **SC-004**: [Business metric, e.g. "Support tickets about locked accounts drop by 50%"]

## Assumptions

- [Assumption about target users, e.g. "Users have access to the email address on their account"]
- [Assumption about scope boundaries, e.g. "Scheduled exports are out of scope for this feature"]
- [Assumption about data or environment, e.g. "The existing sign-in flow is reused"]
- [Dependency on an existing system, e.g. "Requires the existing email delivery service"]
```

## Success criteria

Success criteria are:
- measurable: a time, percentage, count or rate;
- technology-agnostic: no frameworks, languages, databases or tools;
- user-focused: outcomes a user or the business observes, not system internals;
- verifiable without knowing the implementation.

Good: "Users find a past export in under 10 seconds." "95% of searches return results in under 1 second." "The system supports 10,000 concurrent users."

Not good: "API response time is under 200 ms" (too technical; say what the user sees). "The database handles 1,000 transactions per second" (an implementation detail). "The cache hit rate is above 80%" (specific to one technology).

## Reasonable defaults

Record these as assumptions rather than asking:
- Data retention: the usual practice for the domain.
- Performance: standard web or mobile app expectations, unless the input says otherwise.
- Error handling: user-friendly messages with a fallback.
- Authentication: the project's existing method, or standard session-based or OAuth2 sign-in for a web app.
- Integration: the project's existing patterns.

Areas that may need a marker, only when no reasonable default exists: scope boundaries (which use cases are in or out), user types and permissions with conflicting readings, and security or compliance requirements with legal weight.
