---
name: engineering-principles
description: Apply practical engineering principles when implementing, reviewing, or debugging code, with clear ownership, justified abstractions, explicit invariants, focused changes, and complete review coverage.
---

# Engineering Principles

Apply these principles when implementing, reviewing, debugging, or refactoring frontend, backend, tooling, and application code. This skill is self-contained; the recommended companion skills below add depth and workflows when available.

Apply only the sections relevant to the task. Before implementation, identify the affected ownership, guarantees, and main design decisions. For debugging, focus on reachable failure modes and state transitions. For reviews, apply the criteria below; `engineering-review` adds execution and PR mechanics when installed.

Use as little code as possible to meet current, demonstrated requirements while preserving correctness and clear intent. Prefer reuse and deletion over new code; retain extra structure only for a demonstrated benefit. Reduce code across the whole change rather than compressing logic or shifting it into helpers to shorten a caller. Keep changes focused on the requested outcome, without speculative capabilities or unrelated refactoring.

## Ownership and Domain State

- Derive behavior from the module that owns the relevant data, rule, or capability. Avoid forwarding duplicated metadata when the receiver can obtain it from the authoritative source.
- Keep one authoritative representation of each live domain value and derive its presentation. Capture immutable values directly when that preserves the required snapshot; justify extra copies through mutation isolation, identity, or lifetime requirements.
- Make state changes and transitions explicit at their owner so readers can see what changes and why.
- Compare each changed module's original purpose with its added responsibilities. Report cohesion, ownership, and change-locality problems even when behavior is correct. Keep feature-specific state, effects, workflows, and presentation out of generic containers, composition components, and infrastructure that does not own that policy.

## Control Flow

- Prefer early returns to keep the main path visible; avoid deeply nested conditionals and opaque nested ternaries.
- Prefer `switch` for named, mutually exclusive cases discriminated by one value. Use conditional logic for ranges, multiple variables, unrelated predicates, or different kinds of checks.
- When cases share a processing shape, represent meaningful differences, including structured capability differences, as domain data or configuration and centralize the shared iteration. Preserve case-specific behavior visibly rather than hiding differences behind an overly generic abstraction.
- Keep related decisions together instead of scattering them across helpers.
- Combine repeated passes when related results can be accumulated clearly; retain separate passes when they make behavior easier to understand.

## Abstractions and Indirection

- Introduce an abstraction only when it reduces total reasoning cost by owning or naming a meaningful concept, invariant, policy, state transition, volatile implementation detail, complex decision, or genuine reuse. A single-use abstraction can be valid; line count and usage count alone do not establish its value.
- Keep local variables, aliases, and helpers when they clarify intent or structure, own independently meaningful or shared behavior, or control evaluation, reference identity, ownership, allocation, or lifetime. Otherwise prefer direct code, especially for single-use values in demos, fixtures, and configuration.
- Prefer early destructuring of repeatedly used or deeply nested properties to reduce chained access and clarify local intent. Keep simple single-use access direct, and preserve type narrowing, method binding, and read timing—especially in async callbacks.
- Do not introduce pass-through abstractions that merely rename, forward, wrap, or repackage another construct without adding meaning, constraints, or behavior.
- Pass existing functions directly as callbacks when signatures, invocation behavior, and binding are compatible, for example `onClick={onNext}`. Retain wrappers only when they adapt arguments, preserve binding, add required behavior, or satisfy a required return/async contract.
- After control-flow or discriminated-union narrowing, check whether a branch reconstructs an object field by field even though the narrowed value already satisfies the downstream contract. Prefer the narrowed value directly when reconstruction performs no transformation and is not an intentional runtime whitelist or boundary. If filtering the runtime shape is important, keep that boundary explicit.

For each introduced or changed layer, boundary, or duplicated representation, make a structural comparison:

- Identify the behavior, guarantee, or reasoning benefit it provides.
- Compare a concrete simpler alternative: reuse, inline, merge, derive, or remove.
- Establish what that alternative would lose using current callers and documented requirements. Audit direct and indirect consumers, including aggregate status observers, side effects, mutation, identity, and lifetime guarantees before declaring code unused or redundant. A plausible architectural label alone does not establish a required distinction.
- Retain structure when its demonstrated benefit justifies its total cost, including dependent types, adapters, configuration, and tests.

## Defensive Code and Invariants

- Establish invariants at their owning boundary and preserve them when simplifying. Trust those guarantees downstream unless data can change or lose them.
- Before adding a guard, identify the concrete source, reachable event that can violate the invariant, and intended response. Apply this to each clause of a compound condition. An external dependency, broad TypeScript type, or `await` alone is insufficient justification; internal misuse excluded by the application lifecycle does not need a runtime check.
- Validate inputs where their guarantees are established or can be lost, including external HTTP/IPC inputs, persisted data versions, devices, files, plugins, and third-party APIs. A transport hop alone does not create a new trust boundary: honor documented same-release internal contracts while handling reachable lifecycle, concurrency, missing-record, and device/network failures at their owner.

## Types and Interfaces

- Make invalid states unrepresentable through types, constructors, state machines, or interface shape.
- Define input shapes near their consumers; infer obvious local types and annotate public or non-obvious contracts. Avoid `any` unless the boundary genuinely requires it.
- Prefer `field?: T` when omission is valid. Use required `field: T | undefined` when the key must exist but its value may be undefined; keep `field: T` when the value is required. Preserve these semantic differences rather than applying a blanket syntax replacement.
- Give optional fields and modes a supported meaning. Audit current producers, consumers, and documented requirements before allowing omission; remove dependent fallback or wildcard branches when that mode has no supported caller.
- Prefer `Pick` for an explicit, stable field set. Use `Omit` when future source fields should intentionally flow through except for the named exclusions. Replace chained or nested projections with a named type when that clarifies the resulting shape.
- Keep interfaces smaller and simpler than the complexity they own, explicit, and difficult to misuse. Accept dependencies through interfaces or parameters when that improves testability; return meaningful results instead of exposing unnecessary side effects.
- Keep internal presentation policy out of public domain events and commands unless consumers need it. Apply the reconstruction rule above when narrowing these contracts.

## Errors and Async Code

- Handle reachable failures at the layer with enough context to respond, rather than swallowing them. Choose safe continuation, a domain error, retry, or failure with useful context; preserve that context in messages and logs.
- Make async ordering, concurrency, retry, fallback, cancellation, and cleanup decisions explicit.
- When work or external effects can outlive a view, keep operation ownership with an owner that survives that view. Check cancellation during queued initialization, pending entry, active work, and cleanup; serialize incompatible operations while preserving a way to interrupt active work.
- When failed cleanup leaves an external resource or state changed, preserve that unresolved state and its recovery action. Distinguish restoration failure from failure of the main operation rather than presenting an unverified idle state.
- Apply the reachable-failure criterion from Defensive Code and Invariants to error handling as well.

## Comments and Naming

- Use names that explain domain meaning and behavior rather than implementation details.
- Avoid abbreviations and one-letter variables except for trivial conventional cases.
- Prefer improving names and structure over explanatory comments. Use comments for decisions, constraints, invariants, compatibility requirements, and non-obvious ordering that the code does not make clear.
- Update or remove comments invalidated by code or lifecycle changes.

## Tests and Validation

- Test observable domain behavior through public interfaces and document meaningful invariants.
- Cover important reachable empty, boundary, failure, and state-transition cases; use the actual lifecycle to select scenarios rather than testing impossible defensive paths.
- Keep expected results independent from the implementation under test.
- Validate focused changes first, then run broader repository checks when appropriate.

## Application UI and Wording

Apply this section to UI changes, using the application's existing screens and shared components as the reference.

- Reuse existing components, slots, design tokens, and interaction conventions before introducing another surface or customization API.
- Match established product and domain terminology. Reuse existing translations and formatters where the meaning is the same; verify units, singular/plural forms, and locale-specific formatting.
- Make labels and feedback describe the actual action, affected scope, and result. For destructive actions, inspect confirmation or undo conventions; for asynchronous failures, provide perceivable feedback and the appropriate recovery action.

## Change Discipline

- Change contracts coherently across their types, runtime behavior, boundary representations, and relevant tests.
- When APIs, callers, capabilities, ownership, or representable states are narrowed, re-evaluate affected branches, options, guards, types, abstractions, configuration, copy, comments, and tests. Remove dependent behavior that is now unreachable, redundant, or speculative; retain compatibility only for an explicit requirement.
- After a structural fix, review the affected code again as well as running checks. Scope this second review to changed assumptions and expand it when shared or public behavior is affected.

## Review Coverage and Reporting

- Account for every changed module and block in the pinned diff, including affected callers, consumers, and lifecycle behavior. State any remaining coverage or verification limits.
- Make separate correctness and simplification passes. Inspect changed blocks for avoidable reconstruction, forwarding, duplication, and indirection, then evaluate the affected design as a whole. The simplification pass is complete only when every introduced or changed layer, boundary, or duplicated representation has a demonstrated benefit under the structural comparison above or is reported as a simplification opportunity.
- Report every distinct, substantiated issue without a fixed finding-count or word cap unless the user explicitly requests one. Keep each finding concise and compress routine verification rather than omitting findings. Complete coverage can legitimately yield few or no findings.
- Distinguish behavior defects, specification gaps, documented-standard violations, design judgment calls, and minor refinements. Assign severity from the demonstrated consequence, and group low-impact refinements without counting them as independent defects.
- Support each finding with a concrete trigger or violated requirement, a tight code location, its consequence, and a fix or simpler alternative. Identify uncertainty; keep hypothetical failures separate from confirmed findings.
- Consolidate findings that share a cause and fix, using related scenarios as supporting evidence. Keep failure paths separate when they require different fixes or recovery; proximity in one file alone does not establish duplication. Re-evaluate findings whose assumptions change after another structural fix.

### Existing Review Discussions

Reconcile findings with the complete prior conversation and recorded decisions. Distinguish fixes, withdrawn claims, accepted or deferred risks, unresolved questions, and independent new findings. Verify claimed fixes against current code; a closed discussion can retain technical risk without remaining an outstanding change request. Revisit settled decisions only with material new evidence that changes their assumptions; explain that evidence and revise or withdraw invalidated claims.

## Optional Companion Skills

These skills are recommended when installed and relevant to the task. They supplement the principles here; their absence does not prevent implementation, review, or debugging.

- `karpathy-guidelines`: task clarification, implementation, and focused refactoring.
- `codebase-design`: module-design vocabulary and deeper interface decisions.
- `engineering-review`: preferred PR and local-diff workflow for these principles, including conversation retrieval and publishing.
- `code-review`: a structured review workflow, including separate Standards and Spec passes.
- `tdd`: test-first development for behavior-heavy logic and stateful changes.
- Frontend-specific skills: framework, performance, accessibility, and visual validation guidance.
