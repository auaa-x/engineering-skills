# Engineering Principles Skills

A small collection of skills for applying engineering principles and designing appropriately scoped instruction documents.

## Skills

- `engineering-principles` applies practical coding principles for clear control flow, justified abstractions, explicit invariants, and focused changes.
- `instruction-curator` places and refines agent instructions through bounded repository inspection and a purpose-specific interview, including deciding whether guidance belongs in `AGENTS.md`, `SKILL.md`, documentation, design records, tests, or automated checks.

## Install

Install the curated bundle, including the recommended companion skills:

```bash
curl -fsSL https://raw.githubusercontent.com/auaa-x/engineering-skills/main/install.sh | bash
```

The bundle installs:

- `engineering-principles` and `instruction-curator` from this repository.
- `codebase-design`, `code-review`, `diagnosing-bugs`, `prototype`, and `tdd` from `mattpocock/skills`.
- `vercel-react-best-practices` and `vercel-composition-patterns` from `vercel-labs/agent-skills`.

Install only this repository's skills:

```bash
npx skills add auaa-x/engineering-skills --global
```

Install non-interactively for all supported agents:

```bash
npx skills add auaa-x/engineering-skills --all --global
```

The bundle is a convenience installer, not a dependency mechanism. Each upstream skill remains independently maintained by its source repository. To update installed skills later, use:

```bash
npx skills update -g
```

The skills are intentionally language- and framework-agnostic. Product-, framework-, and repository-specific guidance should remain in appropriately scoped instructions.
