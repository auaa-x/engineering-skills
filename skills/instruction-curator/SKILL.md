---
name: instruction-curator
description: Design or refine AGENTS.md and SKILL.md by inspecting existing context, deriving a purpose-specific checklist, interviewing for missing intent, and preventing misplaced, duplicated, or ambiguous instructions.
---

# Instruction Curator

Design instruction documents that are scoped to the decisions they own. Use this skill when creating, restructuring, or adding rules to `AGENTS.md` or `SKILL.md`.

Do not treat a proposed rule as accepted merely because it was suggested. First determine what problem it solves, where it belongs, and how strongly it should apply.

## Choose the Instruction Mechanism

Determine the target from the intended behavior, not from the user's first filename suggestion:

- Use `AGENTS.md` for ambient repository guidance that should apply whenever an agent works in a directory tree.
- Use `SKILL.md` for reusable, task-triggered guidance that should activate because of what the user is doing.
- Keep ordinary explanation in project documentation when it does not direct agent behavior.

If the target is `AGENTS.md`, read [references/agents-md.md](references/agents-md.md) before drafting.

If the target is `SKILL.md`, read [references/skill-md.md](references/skill-md.md) before drafting.

## Working Method

### Inspect before interviewing

Read the existing instructions and the material they govern before asking questions.

- For `AGENTS.md`, inspect every ancestor instruction file, the target subtree, its manifests, commands, public interfaces, tests, and representative implementation.
- For `SKILL.md`, inspect the existing skill, related skills, realistic triggering requests, supporting resources, and the environment in which it will be installed.

Separate what can be discovered from what requires human intent. Do not ask the user to repeat facts already available in the repository.

### Derive the checklist

Do not apply one fixed questionnaire to every document. Build a working checklist from:

1. the instruction mechanism;
2. the document's intended outcome;
3. its scope and audience;
4. inherited or neighboring instructions;
5. the relevant implementation and tooling;
6. unresolved product, policy, or tradeoff decisions.

The checklist should test the decisions that matter for this document. A coding-principles skill, a chart-package `AGENTS.md`, and a deployment skill require different questions.

At minimum, establish:

- what problem the instruction should prevent;
- when and where it applies;
- what owns the decision;
- whether it is evidence, policy, preference, or temporary context;
- whether it duplicates or conflicts with an existing instruction;
- whether a reader can act on it and determine whether it was followed.

### Interview for missing intent

Ask targeted questions in small groups. Ask only when the answer materially changes scope, wording, placement, or enforcement.

Prefer questions about intent, policy, tradeoffs, exceptions, ownership, and priorities. Do not turn framework defaults or observed coincidences into rules without evidence or confirmation.

When the user is exploring possible rules, keep them as candidates until the user accepts them or asks to finalize the document.

### Evaluate candidate instructions

For each substantive candidate, decide whether to:

- accept it as written;
- generalize its underlying reasoning;
- narrow its scope;
- label it as a preferred default rather than a requirement;
- merge it into an existing instruction;
- keep it as an example;
- defer it until an unresolved decision is made;
- reject it.

Check whether the candidate is too vague, too prescriptive, tied to one example, difficult to verify, missing meaningful exceptions, or likely to conflict with a higher-priority instruction.

Prefer wording that states the decision and its boundary. Keep a concrete mechanism when the mechanism itself is the intended convention; otherwise express the underlying reasoning and use the mechanism as an example.

### Draft and audit

Write the smallest document that preserves the decisions the agent cannot safely infer.

Before finalizing, verify:

- every instruction has a clear owner and scope;
- inherited guidance is not repeated;
- conflicting priorities are resolved or explicitly ranked;
- requirements, defaults, examples, and temporary constraints are distinguishable;
- commands, paths, names, and claims match the actual repository;
- exceptions do not make the main instruction meaningless;
- obsolete or superseded instructions are removed or clearly replaced;
- the document contains operational guidance rather than tutorial prose.

When the user asks only to discuss or evaluate instructions, return the analysis and proposed wording without editing files. When the user asks to create, update, or finalize the document, apply the accepted decisions and validate the result.

## Candidate Decision Format

Use this format when it helps the discussion; do not force it for trivial edits:

```markdown
Candidate:
Purpose:
Classification:
Decision: accept | generalize | narrow | default | merge | example | defer | reject
Rationale:
Exceptions:
Target document:
Target section:
Proposed wording:
```
