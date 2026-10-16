---
name: engineering-principles
description: Apply practical engineering principles for clear control flow, justified abstractions, explicit invariants, and focused changes.
---

# Engineering Principles

Apply these principles when writing, reviewing, debugging, or refactoring code. They are shared across frontend, backend, tooling, and application code. Framework-specific guidance should be applied separately.

For decisions about module boundaries, interface shape, seams, adapters, dependency placement, or module depth, use `codebase-design` as the authoritative guidance. This skill governs implementation-level decisions and does not redefine that architecture vocabulary.

## Applying These Principles

Apply only the sections relevant to the current task; do not treat every rule as a mandatory checklist for every change.

- When reviewing changes, use the review passes below in addition to the relevant principles; they do not replace or narrow the rest of this skill.
- Before implementation, identify the main design decisions and apply the relevant principles.
- During implementation, use the control-flow, abstraction, type, and invariant rules touched by the change.
- After narrowing APIs, capabilities, callers, ownership, or representable states, re-evaluate dependent behavior against the new reachable state space.
- During final review, use the review checklist for the affected code and contracts.
- For debugging, focus on reachable failure modes, ownership, invariants, and state transitions.

## Reviewing Changes

When reviewing a PR or change, perform two passes:

### Correctness pass

Check behavioral, state, error-handling, lifecycle, contract, and invariant problems.

### Responsibility and design pass

For every changed module or component:

- Infer its pre-change responsibility from its name, callers, and implementation.
- Identify responsibilities introduced by the change.
- Compare the pre-change and post-change responsibility surface.
- Flag material growth in feature coupling, side effects, dependencies, state, mutations, logging, notifications, or rendering.
- Check whether feature-specific behavior has leaked into generic containers or composition components.
- Check whether domain workflows remain at the boundary that owns them.
- Report cohesion, ownership, and change-locality problems even when behavior is functionally correct.
- Identify the responsibility or ownership mismatch and report the affected boundary. Defer decisions about new module boundaries, seams, adapters, interfaces, dependency placement, or module depth to `codebase-design`.

Rank the strongest responsibility-growth findings and cite exact changed lines.

## Core Principles

- Prefer simple, direct code over speculative design.
- Make domain behavior, ownership, and state transitions explicit.
- Optimize for local reasoning: a reader should understand code without tracing unnecessary indirection.
- Prefer deriving behavior from the module that owns the relevant data or capability. Avoid passing duplicated metadata when the receiving module can obtain it from its authoritative source.
- Keep changes focused and avoid unrelated refactoring.
- Prefer current, demonstrated requirements over hypothetical future needs.
- Reduce duplication when it improves consistency, but do not hide meaningful differences.

## Control Flow

- Prefer early returns to reduce nesting and keep the main path visible.
- Prefer `switch` over a long `if`/`else if` chain when branches discriminate on one value and represent named, mutually exclusive cases.
- Prefer conditional logic when conditions involve ranges, multiple variables, unrelated predicates, or different kinds of checks.
- When several cases share the same processing shape, represent their meaningful differences as configuration and centralize the shared iteration.
- Avoid deeply nested conditionals and opaque nested ternaries.
- Keep related decisions together instead of scattering them across helpers.
- Avoid unnecessary repeated passes over the same data. Prefer one pass when related results can be accumulated without making the state harder to understand.
- Do not force a one-loop solution when separate passes make the behavior easier to understand.
- Make state changes visible so readers can see what changes and why.
- Reduce line count when doing so removes repetition or improves scanability, not by compressing meaningful logic.

## Abstractions and Indirection

- Introduce an abstraction only when it reduces total reasoning cost by owning or naming a meaningful concept, invariant, policy, state transition, volatile implementation detail, complex decision, or genuine reuse.
- Justify a local variable or type alias when it makes intent, structure, or a domain concept clearer.
- In demo, fixture, or configuration code, prefer inlining a single-use value at its consumer when the binding adds no independent meaning.
- Keep a single-use binding only when it names an independent domain concept or intentionally controls evaluation, reference identity, ownership, allocation, or lifetime.
- Extract helpers mainly when the behavior is shared, independently meaningful, or substantially easier to understand as a separate operation.
- Do not introduce pass-through abstractions that merely rename, forward, wrap, or repackage another construct without adding meaning, constraints, or behavior.
- Prefer direct code until a stable responsibility emerges.
- Prefer configuration-driven deduplication when several cases share the same structure and differ primarily by data.
- Keep case-specific behavior visible in configuration instead of hiding it behind an overly generic abstraction.
- Represent structured capability differences as domain data when the behavior has a stable shared structure.
- Remove abstractions when the responsibility that justified them disappears.
- Do not judge abstractions by line count or usage count alone. A single-use abstraction is valid when it names an important concept or decision.

When reviewing an abstraction, ask:

- What does this construct make explicit?
- What responsibility, decision, or guarantee does it own?
- Does it reduce duplication or centralize a meaningful policy?
- Does it improve readability enough to justify the indirection?
- Is it based on current behavior or only hypothetical reuse?

## Defensive Code and Invariants

- Do not add runtime checks solely to protect against internal misuse that cannot occur in the current application lifecycle. Prefer types, API design, state transitions, and tests.
- Add a guard only for a concrete, reachable failure mode.
- Before adding a guard, identify the source, the event that can violate the invariant, and the intended response.
- An external dependency, broad TypeScript type, or `await` does not by itself justify a guard.
- Validate invariants at the boundary that owns them.
- Trust guarantees downstream unless data can change or lose its guarantee.
- Treat each clause in a compound condition as an independent decision with its own reachable failure mode.
- Handle reachable failures intentionally: continue safely, return a domain error, retry, or fail with useful context.
- Remove checks that become unreachable after lifecycle, ownership, or control-flow changes.
- Prefer making invalid states unrepresentable through types, constructors, state machines, or API shape.
- Always validate true runtime boundaries such as HTTP input, persisted data, IPC, devices, files, plugins, and third-party APIs.

## Types and Interfaces

- Use strong types to express valid states and contracts.
- Avoid `any` unless the boundary genuinely requires it.
- Define input shapes near the functions that consume them.
- Let inference handle obvious local types.
- Annotate public or non-obvious contracts.
- Prefer `Pick` when the intended field set is explicit and stable. Use `Omit` when the meaningful relationship is “the source type except for these fields” and future source fields should intentionally flow through.
- Avoid chained or nested `Pick`/`Omit` types when a named type makes the resulting shape clearer.
- Keep domain-specific behavior out of generic infrastructure unless the infrastructure owns that policy.

When a contract changes, update its type, runtime behavior, boundary representation, and relevant tests as one coherent change.

## Errors and Async Code

- Do not swallow errors.
- Handle errors at the layer that has enough context to respond meaningfully.
- Preserve useful domain context in error messages and logs.
- Make retry, fallback, cancellation, and failure behavior explicit.
- Keep async ordering and concurrency decisions visible.
- Make ownership, lifecycle, and cleanup behavior explicit.
- Do not add error handling for impossible scenarios merely for defensive completeness.

## Comments and Naming

- Use descriptive names based on domain meaning and behavior.
- Avoid abbreviations and one-letter variables except for trivial conventional cases.
- Prefer names that explain intent rather than implementation.
- Do not comment code that is already clear from its structure.
- Use comments for decisions, constraints, invariants, compatibility requirements, and non-obvious ordering.
- Remove comments when the code or lifecycle changes invalidate them.
- Prefer improving names or structure over adding explanatory comments.

## Tests and Validation

- Test observable behavior through public interfaces.
- Prefer tests that describe domain behavior rather than implementation details.
- Cover important empty, boundary, failure, and state-transition cases.
- Keep expected results independent from the implementation under test.
- Use tests to document meaningful invariants.
- Validate focused changes first, then run broader repository checks when appropriate.
- Do not add tests for unreachable defensive scenarios unless the lifecycle can realistically reach them.

## Change Discipline

- When a capability, option, or contract is removed, remove its dependent configuration, copy, and dead code instead of preserving unused entries.
- Do not preserve obsolete entries merely to avoid touching related code; keep compatibility only when it is an explicit requirement.
- When a change narrows public APIs, allowed callers, capabilities, ownership, or representable states, re-evaluate dependent branches, options, guards, types, abstractions, configuration, and tests against the new reachable state space.
- Do not treat review findings as independent when one structural change changes the assumptions behind another.
- After applying a structural fix, perform a second review of the affected code—not only tests and type checks—and remove behavior that has become unreachable, redundant, or speculative.
- Scope the second review to code whose assumptions depended on the removed capability, expanding the review when the affected behavior is shared or public.

## Review Checklist

- Is every changed line required by the request or necessary for correctness?
- Did the change add an abstraction, guard, or restriction without a concrete justification?
- Could the same behavior be expressed more directly?
- Are repeated structures unified without hiding domain differences?
- Are ownership and invariants enforced at the correct boundary?
- Is the control flow easy to follow in one pass?
- Are errors and lifecycle behavior intentional?
- Do the tests verify behavior rather than implementation shape?
- Did any changed module gain material responsibilities, coupling, or side effects that belong elsewhere?
- Did a generic component acquire feature-specific behavior instead of keeping it at its owning boundary?
- After these changes, which previously reachable states or callers no longer exist, and what code only served them?

## Examples

See [`examples.md`](examples.md) for concise preferred and less-preferred code examples.

## Related Workflows

- Use `karpathy-guidelines` for implementation and focused refactoring.
- Use `codebase-design` for module and interface decisions.
- Use `code-review` for reviewing completed changes.
- Use `tdd` for behavior-heavy logic and stateful changes.
- Use frontend-specific skills for React implementation and validation.

The central rule is:

> Indirection, validation, and defensive code must earn their maintenance cost by improving meaning, reuse, correctness, or change locality.
