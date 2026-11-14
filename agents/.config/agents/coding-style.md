# Coding style

How I write code, in every language and project. A project's own docs add only what is specific to it: language, formatter, lint rules and layout. Where a project's docs disagree with this file, the project wins for that project.

## Control flow

- Keep the main path flat. Handle invalid, unavailable or already-complete cases first, with guard clauses and early returns.
- No `else` after a branch that returns.
- When a loop or callback would need nested conditions, extract a small helper with a clear name.

```ts
function setWidth(profile: Profile, raw: string): boolean {
  const width = Number(raw);
  if (Number.isNaN(width)) return false;
  if (width < 0 || width > 100) return false;

  profile.widthPercent = Math.round(width);
  return true;
}
```

## Modules

- One module per concept. Name the module after the concept, not after a layer or a kind of code (`rates`, not `utils` or `helpers`).
- A module exports its contract and nothing else. What it needs internally stays private.
- Prefer pure functions over shared state: inputs in, result out.

## Contracts

- Every boundary between modules has a well-defined interface: named types for what goes in and what comes out, and what the caller may rely on (preconditions, postconditions, errors).
- Callers depend on the contract, never on how a module works inside. A module can change inside without its callers changing.
- Return failure as a value the caller has to handle (a result or conflict type) when the caller is expected to respond to it; throw only for bugs.

## Ownership and dependencies

- Each rule and state change lives in the module that owns it. Callers use that module's public operations instead of repeating its rules.
- Pass external APIs and configuration into core logic. Keep direct access to the platform (browser, game client, file system, network) at the edge.
- Add no wrapper layer that doesn't serve a clear purpose.

## Naming

- Prefer mathematical terms where they fit: sequence, constant, parameter, constraint, objective. Plainer words are for user-facing text.
- Use the project's glossary when it has one, in code as well as docs.

## Unavailable information

When missing or restricted data changes what the code can safely do or report, keep the uncertainty instead of inferring a value. Carry a specific reason only when a caller needs to respond differently; otherwise a plain "unavailable" result is enough.

## Tests

- A test sits next to the module it tests and checks its contract, not its internals.
- Prefer hand-worked examples whose expected values a reader can check.

## Refactoring

Preserve behavior, including the order of side effects, when flattening or splitting existing code.
