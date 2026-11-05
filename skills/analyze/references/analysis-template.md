# Analysis format

Print the analysis in this shape. Keep the headings. Leave out an optional section when it would be empty.

```markdown
## Specification Analysis Report

**Feature**: [NNN-slug or doc link] · **Analyzed**: [DATE] · **Constitution**: [version, or "none"]

| ID | Category | Severity | Location(s) | Summary | Recommendation |
|----|----------|----------|-------------|---------|----------------|
| DU1 | Duplication | HIGH | spec.md FR-003, FR-007 | Both require [...] | Merge into FR-003; mark FR-007 "(removed)" |
| G1 | Coverage | CRITICAL | spec.md FR-005 | No task covers [...] | Add a task in the US1 phase |

[Overflow: N more findings not shown (DU: 2, A: 3, I: 1).]

**Coverage Summary Table:**

| Requirement Key | Has Task? | Task IDs | Notes |
|-----------------|-----------|----------|-------|
| FR-001 | Yes | T004, T007 | |
| FR-002 | No | | |

**Constitution Alignment Issues:** [optional; each conflict with the principle and its MUST statement]

**Unmapped Tasks:** [optional; tasks that serve no requirement or story]

**Repository Coverage:** [optional; only for multi-repo plans]

| Repository | In Repo Impact? | Task IDs | Notes |
|------------|-----------------|----------|-------|
| api | Yes | T003-T009 | |
| docs | Yes | | No task |

**Metrics:**

- Total Requirements: [N]
- Total Tasks: [N]
- Coverage %: [requirements with at least one task / total]
- Ambiguity Count: [N]
- Duplication Count: [N]
- Critical Issues Count: [N]

**Next Actions:**

- [...]
```

In a repository, give each location as the file and the ID or heading, with line numbers when they help (`spec.md:L120-134`). In Docs, give the tab and the ID or heading (`Spec tab, FR-003`).

When there are no findings, print the success form. It has the header line, "No issues found.", the coverage table and the metrics.
