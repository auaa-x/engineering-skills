# Engineering Principles Examples

These examples illustrate the principles in `SKILL.md`. They are defaults, not rules to apply without considering context.

## Inline single-use demo values

Prefer keeping simple, single-use fixture data at its consumer when the binding adds no independent meaning.

Preferred:

```tsx
<Chart values={[1, 2, 3]} />
```

Less preferred:

```tsx
const chartValues = [1, 2, 3]

<Chart values={chartValues} />
```

## Destructure multi-property parameters

Prefer destructuring an object parameter at the function boundary when the function consumes multiple properties and does not need the object as a whole.

Preferred:

```ts
function buildOption({ frequencies, series, yAxisRange }: Config) {
  // ...
}
```

Less preferred:

```ts
function buildOption(response: Config) {
  const frequencies = response.frequencies
  const series = response.series
  const yAxisRange = response.yAxisRange
}
```

## Compose explicit types

Prefer `Pick` when the intended field set is explicit and stable.

Preferred:

```ts
type UserSummary = Pick<User, 'id' | 'name'>
```

Less preferred:

```ts
type UserSummary = Omit<User, 'password' | 'internalNotes'>
```

Use `Omit` when the meaningful relationship is the source type except for specific fields.

## Match control flow to the decision

Prefer `switch` for named variants of one discriminant.

Preferred:

```ts
switch (status) {
  case 'pending':
    return showPending()
  case 'active':
    return showActive()
  default:
    return showOther()
}
```

Use conditional logic for ranges, compound predicates, or multiple variables.
