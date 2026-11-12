---
name: engineering-review
description: Review PRs, branches, and local changes with engineering-principles, prioritizing minimal implementation, clear ownership, and complete review coverage.
---

# Engineering Review

Use this workflow to review the simplest implementation that preserves current requirements and demonstrated guarantees.

Read `engineering-principles` through the available skill catalog before reviewing. If it is absent from the catalog, read the bundled sibling [engineering-principles](../engineering-principles/SKILL.md). It owns the coding criteria, structural comparison, and reporting rules; this skill owns review execution and defaults. If neither source is accessible, disclose the missing criteria and continue with available repository guidance.

Apply the repository's relevant `AGENTS.md` and documented conventions. Keep repository-specific commands, release boundaries, and product policy there.

## Establish scope and evidence

- For a PR, capture its current head, base, and merge-base commits. For a branch, honor the requested comparison or infer the repository's integration branch. For local changes, include staged, unstaged, and relevant new files unless the user narrows the scope. Ask only when the comparison cannot be inferred reliably. Keep the reviewed diff fixed and report its scope.
- Use the PR description, linked requirements, documented contracts, and recorded decisions as evidence. When no separate spec exists, continue the implementation review and label inferred intent or unresolved requirement questions.
- For an existing PR, complete the **Existing PR Conversations** procedure in engineering-principles before reviewing. Carry its decisions into the review rather than treating every historical comment as an outstanding request.

## Complete two passes

Maintain an internal coverage checklist for every changed module and block, including affected consumers and lifecycle behavior.

1. **Correctness and requirements.** Trace observable behavior, contracts, state transitions, async work, and reachable failure/recovery paths using engineering-principles. Distinguish demonstrated defects from uncertainty about intended behavior.
2. **Ownership and simplification.** Compare each module's pre-change responsibility with what the change adds. Apply the structural comparison from engineering-principles to every introduced or changed layer, boundary, and duplicated representation. Inspect the changed blocks and then the affected design as a whole. Establish what a simpler alternative would lose before recommending it.

For UI changes, apply **Application UI and Wording** against nearby screens and shared components. Include workflow or requirement concerns when supported by evidence; state unanswered product decisions as questions.

A pass is complete when every changed block is accounted for and each changed structure has a demonstrated benefit or a substantiated simplification finding. Disclose any remaining coverage gaps.

## Report and follow through

Apply **Review Coverage and Reporting** from engineering-principles, including unlimited substantiated findings, consolidation, classification, severity, and evidence. Present each finding once, grouped under correctness/requirements or ownership/simplification; cross-reference overlapping evidence. Keep minor refinements grouped and accepted/deferred risks separate from outstanding findings.

Include the reviewed commits or local scope, checks performed, and meaningful verification limits. Few or no findings is valid after complete coverage.

Return the review in chat by default. Editing code or publishing PR comments requires user authorization; an instruction to review and post already provides it. When publishing is authorized, follow engineering-principles' conversation refresh, reconciliation, and publication verification procedure. Keep published comments focused on code and decisions.
