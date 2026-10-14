---
name: instruction-curator
description: Design or refine agent instructions and coding rules for AGENTS.md or SKILL.md. Use when deciding rule scope, placement, specificity, inheritance, activation, or when interviewing a user before drafting instruction files.
---

# Instruction Curator

Design instruction documents that are scoped to the decisions they own. Use this skill when creating, restructuring, or adding rules to `AGENTS.md` or `SKILL.md`, including when a proposed rule may belong in another artifact instead.

Do not treat a proposed rule as accepted merely because it was suggested. First determine what problem it solves, where it belongs, and how strongly it should apply.

> Put each instruction where its decision is owned and enforced; do not duplicate it merely to make it visible.

## Choose the Instruction Mechanism

Determine the target from the intended behavior, not from the user's first filename suggestion.

| Target | Use when the content owns |
| --- | --- |
| `AGENTS.md` | Ambient repository guidance that should apply whenever an agent works in a directory tree |
| `SKILL.md` | Reusable, task-triggered guidance that should activate because of what the user is doing |
| README or API documentation | Explanation for human users and consumers, including setup, concepts, and supported usage |
| Design specification or ADR | Product intent, architectural decisions, alternatives, rationale, and consequences |
| Tests | Executable behavioral examples, contracts, regressions, and invariants |
| Linting, schemas, types, or other automated checks | Mechanically enforceable constraints that should fail consistently when violated |

An instruction file may point to the artifact that owns a fact or enforcement mechanism. Do not copy the same content into multiple places.

If the target is `AGENTS.md`, read [references/agents-md.md](references/agents-md.md) before drafting.

If the target is `SKILL.md`, read [references/skill-md.md](references/skill-md.md) before drafting.

## Working Method

### Inspect before interviewing

Read the existing instructions and the material they govern before asking questions. Bound the investigation according to the requested outcome.

- For `AGENTS.md`, inventory the full governed scope through its instruction files, directory structure, manifests, commands, configuration, and public entry points. Inspect representative implementations and tests for each relevant responsibility. Expand the sample only when patterns conflict, evidence is insufficient, risk justifies it, or the user requests an exhaustive audit.
- For `SKILL.md`, read the target skill and its required references completely. Inspect neighboring skills through their discovery metadata first, then read only those whose responsibilities materially overlap. Consider realistic triggering requests and the environment in which the skill will be installed.

Do not imply exhaustive implementation review when only representative evidence was inspected. State meaningful limits when they affect confidence.

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
