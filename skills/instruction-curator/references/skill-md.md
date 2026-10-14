# SKILL.md Lens

Use this lens when creating or refining a `SKILL.md` file.

## Instruction Model

`SKILL.md` is reusable and task-triggered. It should activate because the user's request matches a capability, not because the agent happens to be in a particular repository.

The skill should add non-obvious decisions, domain knowledge, or a repeatable workflow. Do not create a skill that merely restates general competence or another installed skill.

## Establish the Capability

Determine:

- the user requests that should activate the skill;
- neighboring requests that should not activate it;
- the outcome the skill helps produce;
- the decisions or knowledge it contributes beyond normal agent behavior;
- whether it is portable or tied to a particular repository;
- the permissions and external actions that remain user-controlled;
- the observable conditions that indicate completion.

Keep the frontmatter description concise and discriminating. Put workflow detail in the body rather than expanding the trigger into a capability catalog.

## Derive the Interview

Build questions around unresolved decisions such as:

- What repeated task or failure justifies this skill?
- What should a successful invocation produce?
- What similar task belongs to another skill?
- Which choices should remain flexible, and which require deterministic steps?
- What context must be inspected before acting?
- What must be asked because it cannot be inferred?
- Does the skill need supporting references, scripts, or assets?
- Should details load only for a particular mode?
- Should invocation be automatic or explicit?

Ask only questions that materially affect activation, scope, workflow, resources, safety, or completion.

## Structure and Disclosure

Keep shared purpose, essential constraints, and routing in `SKILL.md`. Move substantial conditional guidance into focused references and state when each reference should be read.

Add scripts only when deterministic execution or repeated automation justifies maintaining them. Add assets only when they are part of generated output. Avoid placeholder directories and duplicated summaries.

## Content Test

Keep an instruction when it changes how the task is selected, reasoned about, performed, or verified.

Exclude:

- generic advice the agent already follows;
- speculative modes without realistic triggering requests;
- copied documentation from another skill or tool;
- repository-specific facts that belong in `AGENTS.md`;
- implied authorization for external or destructive actions;
- rigid steps where several approaches are equally valid.

Validate that the skill's name, description, workflow, references, and completion criteria describe one coherent capability.
