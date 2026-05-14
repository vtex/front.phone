# front.phone Constitution

## Core Principles

### I. Country Module Pattern (NON-NEGOTIABLE)
Each country is a self-contained CoffeeScript file in `src/script/countries/<ISO3>.coffee`.
Every country module must: define a class with `countryCode`, `regex`, `nationalDestinationCode`, `specialRules()`, and `splitNumber()`; register itself on `Phone.countries[countryCode]`; export the instance; and be required in `src/script/phone-all-countries.coffee`.

### II. Test Parity (NON-NEGOTIABLE)
Every country module must have a corresponding spec in `spec/countries/<ISO3>-spec.coffee`.
A country PR without tests will not be merged. Tests must cover at minimum: one valid mobile number, one valid landline, and one invalid number.

### III. E.123 Compliance
All phone formatting output must comply with the E.123 international notation standard.
`Phone.format()` output must be verifiable against E.123 for each country added.

### IV. Stable Public API
The public API of `Phone` (method signatures and return object shape) is frozen.
Methods: `getPhoneInternational`, `getPhoneNational`, `validate`, `format`, `normalize`.
Return shape: `{ countryCode, nationalDestinationCode, number, isMobile, isValid }`.
Any breaking change requires a major version bump and human approval.

### V. CoffeeScript Codebase
All source and test files are CoffeeScript (`.coffee`). Do not introduce JavaScript or TypeScript source files.
Indentation uses tabs. Follow the existing file conventions exactly.

## Constraints

- **No new runtime dependencies** without explicit human approval and justification
- **Grunt is the build tool** — do not replace or bypass it
- **yarn** is the package manager — use `yarn install --frozen-lockfile` in CI
- **Node compatibility**: maintain compatibility with the range defined in `package.json`
- Country regex patterns must be validated against real number samples before merging
- **Security**: N/A — library has no authentication, network, or data persistence
- **Performance**: TBD — no SLO defined; keep regex patterns efficient
- **Observability**: N/A — library has no runtime instrumentation

## Quality Gates

- All tests pass: `yarn test`
- Build succeeds: `yarn build`
- No test coverage regressions
- Country rules must not accept numbers that violate the country's real-world numbering plan

## Governance

This constitution supersedes all other practices for this repository.
Amendments require a PR with justification — no silent changes to this file.
Agents must not modify the public API, publish to npm, or alter the Grunt pipeline without human approval.

**Version**: 1.0 | **Ratified**: 2026-05-14 | **Last Amended**: 2026-05-14
