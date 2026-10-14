# AGENTS.md Lens

Use this lens when creating or refining an `AGENTS.md` file.

## Instruction Model

`AGENTS.md` is ambient and hierarchical. It applies because an agent is working within its directory tree, not because a user explicitly invokes it.

An ancestor file already governs the target unless a deeper file adds or explicitly overrides guidance. A nested file should usually describe local deltas rather than recomposing the parent.

## Establish Scope

Determine:

- the exact directory tree the file will govern;
- every ancestor `AGENTS.md` that already applies;
- whether sibling areas share the proposed rule;
- whether the rule belongs at the current directory, a parent, or a deeper child;
- whether an override is intentional, explicit, and justified.

Place an instruction at the highest directory where it remains true and useful for every affected descendant. Do not move a local product rule upward merely to make it easier to find.

## Inspect the Governed Area

Inventory the full governed area at the structural level: instruction files, directories, manifests, package boundaries, commands, configuration, public entry points, and generated or externally owned paths.

Then inspect representative implementation and test files for each responsibility relevant to the requested instructions. Expand beyond that sample only when observed patterns conflict, the evidence is insufficient, the area is unusually risky, or the user requests an exhaustive audit.

Derive evidence from:

- package responsibilities and public interfaces;
- consumers and dependency direction;
- domain terminology and invariants;
- package-specific commands and validation;
- generated, vendored, or externally owned files;
- established naming, data flow, error handling, and testing patterns;
- compatibility, performance, accessibility, or lifecycle constraints;
- recent corrections or repeated failures that indicate missing guidance.

Do not infer a convention from one occurrence, an unused file, or a framework default. Record uncertainty as a question rather than a rule.

Distinguish an inventory from an audit. Do not claim complete implementation coverage when the work used representative samples.

## Derive the Interview

Build questions around unresolved decisions such as:

- What responsibility does this directory own?
- What must callers or consumers be able to rely on?
- Which decisions repeatedly go wrong without written guidance?
- Which observed patterns are intentional policy rather than historical accident?
- What may vary, and what must remain stable?
- Which failures are costly enough to require an explicit instruction?
- Is a constraint permanent, migration-specific, or temporary?
- What local validation demonstrates compliance?

Ask only questions whose answers cannot be established from code, configuration, history, or existing instructions.

## Content Test

Keep an instruction when it changes what the agent should do, what choices are acceptable, or how work is verified.

Exclude:

- general programming knowledge;
- duplicated ancestor instructions;
- broad aspirations with no operational consequence;
- exhaustive architecture documentation that belongs elsewhere;
- commands that do not exist;
- restrictions with no product or technical policy behind them.

If a local instruction contradicts an ancestor, name the override and explain why this subtree differs. Never rely on silent precedence.
